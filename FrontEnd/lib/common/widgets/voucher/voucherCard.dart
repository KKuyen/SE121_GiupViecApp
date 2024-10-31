import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:se121_giupviec_app/core/configs/assets/app_vectors.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_info.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';

class VoucherCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String RpointCost;
  final VoidCallback onPressed;

  const VoucherCard({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.onPressed,
    required this.RpointCost,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding:
            const EdgeInsets.only(right: 10.0, bottom: AppInfo.main_padding),
        child: Container(
          height: 150,
          width: 220,
          decoration: const BoxDecoration(
              border: Border.fromBorderSide(BorderSide(color: Colors.grey)),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(imageUrl), fit: BoxFit.cover),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          description,
                          style:
                              const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          RpointCost,
                          style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: AppColors.cam_main),
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        SvgPicture.asset(
                          AppVectors.coin,
                          color: AppColors.cam_main,
                          height: 17,
                          width: 17,
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
