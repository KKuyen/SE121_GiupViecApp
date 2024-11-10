import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:se121_giupviec_app/core/firebase/firebase_image.dart';

class Isutaskerrow extends StatefulWidget {
  final String taskerName;
  final String taskerPhone;
  final int accountId;
  final String taskerImageLink;
  final int taskerId;
  const Isutaskerrow({
    required this.taskerId,
    super.key,
    required this.accountId,
    required this.taskerName,
    required this.taskerPhone,
    required this.taskerImageLink,
  });

  @override
  State<Isutaskerrow> createState() => _isuTaskerRowState();
}

class _isuTaskerRowState extends State<Isutaskerrow> {
  final FirebaseImageService _firebaseImageService = FirebaseImageService();

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              } else if (snapshot.hasData) {
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
              } else {
                return Icon(Icons.error);
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
          if (widget.taskerId == widget.accountId)
            Container(
              width: 50,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: AppColors.xanh_main,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  'Bạn',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
