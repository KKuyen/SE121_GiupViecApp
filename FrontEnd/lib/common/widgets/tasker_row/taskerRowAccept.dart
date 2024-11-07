import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:se121_giupviec_app/presentation/screens/user/activities/taskerProfile.dart';

class Taskerrowaccept extends StatefulWidget {
  final int taskerId;
  final VoidCallback onPressFun;

  final String taskerName;
  final String taskerPhone;
  final String taskerImageLink;

  const Taskerrowaccept({
    required this.taskerId,
    required this.onPressFun,
    super.key,
    required this.taskerName,
    required this.taskerPhone,
    required this.taskerImageLink,
  });

  @override
  State<Taskerrowaccept> createState() => _Taskerrowaccept();
}

class _Taskerrowaccept extends State<Taskerrowaccept> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Taskerprofile(taskerId: widget.taskerId),
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
            const SizedBox(width: 5),
            IconButton(
              color: AppColors.xanh_main,
              iconSize: 20,
              icon: const FaIcon(FontAwesomeIcons.check),
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
