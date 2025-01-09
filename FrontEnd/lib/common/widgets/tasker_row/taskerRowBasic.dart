import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';
import 'package:se121_giupviec_app/core/configs/assets/app_vectors.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:se121_giupviec_app/core/firebase/firebase_image.dart';
import 'package:se121_giupviec_app/presentation/screens/user/activities/taskerProfile.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/models/User.dart';
import '../../../presentation/screens/user/message/detailMessage.dart';
import '../../helpers/SecureStorage.dart';

class Taskerrowbasic extends StatefulWidget {
  final String taskerName;
  final String taskerPhone;
  final String taskerImageLink;
  final int taskerId;
  final int userId;
  const Taskerrowbasic({
    required this.taskerId,
    super.key,
    required this.userId,
    required this.taskerName,
    required this.taskerPhone,
    required this.taskerImageLink,
  });

  @override
  State<Taskerrowbasic> createState() => _TaskerrowbasicState();
}

class _TaskerrowbasicState extends State<Taskerrowbasic> {
  FirebaseImageService _firebaseImageService = FirebaseImageService();
  SecureStorage secureStorage = SecureStorage();
  Future<User> _fetchUserData() async {
    String name = await secureStorage.readName();
    String id = await secureStorage.readId();
    String avatar = await secureStorage.readAvatar();
    User user = User(id: int.parse(id), name: name, avatar: avatar);
    print("user" + user.id.toString());
    return user;
  }

  void _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Taskerprofile(
              taskerId: widget.taskerId,
              userId: widget.userId,
            ),
          ),
        ),
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0.0),
        child: Row(
          children: [
            FutureBuilder<String>(
              future: _firebaseImageService.loadImage(widget.taskerImageLink),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Icon(Icons.error);
                } else {
                  return CachedNetworkImage(
                    imageUrl: snapshot.data!,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => SvgPicture.asset(
                      AppVectors.avatar,
                      width: 40.0,
                      height: 40.0,
                    ),
                    imageBuilder: (context, imageProvider) => Container(
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.taskerName,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
            const Spacer(),
            IconButton(
              iconSize: 20,
              color: AppColors.cam_main,
              icon: const FaIcon(FontAwesomeIcons.phoneAlt),
              onPressed: () {
                // Do something
                _makePhoneCall(widget.taskerPhone);
              },
            ),
            const SizedBox(width: 8),
            IconButton(
              color: AppColors.cam_main,
              iconSize: 20,
              icon: const FaIcon(FontAwesomeIcons.solidMessage),
              onPressed: () async {
                User user = await _fetchUserData();
                User targetUser = User(
                    id: widget.taskerId,
                    name: widget.taskerName,
                    avatar: widget.taskerImageLink);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Detailmessage(
                            targetUser: targetUser, sourseUser: user)));
                // Do something
              },
            ),
          ],
        ),
      ),
    );
  }
}
