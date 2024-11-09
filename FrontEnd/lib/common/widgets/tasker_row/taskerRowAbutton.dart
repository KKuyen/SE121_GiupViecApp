import 'package:flutter/material.dart';

import 'package:se121_giupviec_app/common/widgets/button/2sttbutton.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:se121_giupviec_app/presentation/screens/user/activities/taskerProfile.dart';

class Taskerrowabutton extends StatefulWidget {
  final int taskerId;
  final int userId;

  final String taskerName;
  final String taskerPhone;
  final String taskerImageLink;
  final TwoSttButton iconButton;

  const Taskerrowabutton({
    required this.userId,
    required this.taskerId,
    required this.iconButton,
    super.key,
    required this.taskerName,
    required this.taskerPhone,
    required this.taskerImageLink,
  });

  @override
  State<Taskerrowabutton> createState() => _TaskerrowdaState();
}

class _TaskerrowdaState extends State<Taskerrowabutton> {
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
            CachedNetworkImage(
              imageUrl: widget.taskerImageLink,
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
            widget.iconButton,
          ],
        ),
      ),
    );
  }
}
