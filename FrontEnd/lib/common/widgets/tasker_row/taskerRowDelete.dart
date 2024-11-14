import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';
import 'package:se121_giupviec_app/core/configs/assets/app_vectors.dart';

import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:se121_giupviec_app/core/firebase/firebase_image.dart';
import 'package:se121_giupviec_app/presentation/screens/user/activities/taskerProfile.dart';

class Taskerrowdelete extends StatefulWidget {
  final VoidCallback onPressFun;
  final String taskerName;
  final String taskerPhone;
  final String taskerImageLink;
  final int taskerId;
  final int userId;
  const Taskerrowdelete({
    required this.onPressFun,
    required this.taskerId,
    super.key,
    required this.taskerName,
    required this.userId,
    required this.taskerPhone,
    required this.taskerImageLink,
  });

  @override
  State<Taskerrowdelete> createState() => _TaskerrowdeleteState();
}

class _TaskerrowdeleteState extends State<Taskerrowdelete> {
  FirebaseImageService _firebaseImageService = FirebaseImageService();
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
        padding: const EdgeInsets.symmetric(vertical: 3.0),
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
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.taskerName,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Inter',
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
            const Spacer(),
            IconButton(
              iconSize: 20,
              color: AppColors.do_main,
              icon: const FaIcon(FontAwesomeIcons.trash),
              onPressed: () {
                widget.onPressFun();
              },
            ),
          ],
        ),
      ),
    );
  }
}
