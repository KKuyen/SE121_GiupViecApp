import 'package:flutter/material.dart';

import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:se121_giupviec_app/core/firebase/firebase_image.dart';

class Userrow extends StatefulWidget {
  final int userId;
  final bool isContact;
  final bool? isCall;
  final String taskerImageLink;
  final String userName;
  final String userPhone;
  final String userImageLink;

  const Userrow({
    this.isCall = false,
    required this.userId,
    required this.taskerImageLink,
    required this.isContact,
    super.key,
    required this.userName,
    required this.userPhone,
    required this.userImageLink,
  });

  @override
  State<Userrow> createState() => _userRow();
}

class _userRow extends State<Userrow> {
  FirebaseImageService _firebaseImageService = FirebaseImageService();
  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  errorWidget: (context, url, error) => Icon(Icons.error),
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
                widget.userName,
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
          const SizedBox(width: 5),
          if (widget.isCall == true)
            IconButton(
              color: widget.isContact ? AppColors.cam_main : AppColors.xam72,
              iconSize: 22,
              icon: const FaIcon(FontAwesomeIcons.phoneAlt),
              onPressed: widget.isContact ? () {} : null,
            ),
          const SizedBox(width: 5),
          IconButton(
            color: widget.isContact ? AppColors.cam_main : AppColors.xam72,
            iconSize: 22,
            icon: const FaIcon(FontAwesomeIcons.solidMessage),
            onPressed: widget.isContact ? () {} : null,
          ),
        ],
      ),
    );
  }
}
