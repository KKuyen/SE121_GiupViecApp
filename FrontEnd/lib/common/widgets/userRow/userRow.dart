import 'package:flutter/material.dart';

import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Userrow extends StatefulWidget {
  final int userId;
  final bool isContact;
  final bool? isCall;

  final String userName;
  final String userPhone;
  final String userImageLink;

  const Userrow({
    this.isCall = false,
    required this.userId,
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
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        children: [
          Image.network(
            'https://storage.googleapis.com/se100-af7bc.appspot.com/images/1728630023846-ANIME-PICTURES.NET_-_801133-1197x674-elden_ring-malenia_blade_of_miquella-agong-single-long_hair-wide_image-transformed.jpeg?GoogleAccessId=firebase-adminsdk-6avlp%40se100-af7bc.iam.gserviceaccount.com&Expires=1729234829&Signature=F2pTBMS10pYiDfqBskF7NyLlITUEOwhOQqOPvxmEcCkjBPTV8Lf8KvIu53UV6LNy2s6suCNU0qq97rFaXy%2FKYAquOHeG9%2F%2BstlPmPwViM1mhHF0q12ptEJAwfXbXycND%2FuyaAhNm38zNTBNy%2BdAy%2FZQR4J0CO6lXKLlYLzqP8%2BKuwI4o711lsxSYUVRv1S4%2Fi58Gm%2FF8RDTg%2Fy%2BsP2BGfV71VF44bWcvkwtwjGOkGXWMCmRjmmaDjPiJhxQX9rGDuCyi89Sh9er%2FPWD2lrg6WIh2r14XJjnMnNK8a9tNvH8F5xNDUnohHo2qqOHzWtsOzULdoUUx%2B2USosN9Y79VxQ%3D%3D',
            width: 35,
            height: 35,
            fit: BoxFit.cover,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child;
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            (loadingProgress.expectedTotalBytes ?? 1)
                        : null,
                  ),
                );
              }
            },
            errorBuilder:
                (BuildContext context, Object error, StackTrace? stackTrace) {
              return const Icon(
                Icons.error,
                color: Colors.red,
                size: 35,
              );
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
