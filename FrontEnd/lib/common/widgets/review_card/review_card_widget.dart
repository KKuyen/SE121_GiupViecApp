import 'package:flutter/material.dart';
import 'package:se121_giupviec_app/core/configs/text/app_text_style.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';

class ReviewCardWidget extends StatefulWidget {
  final String userName;
  final String userAvatar;
  final int star;
  final String content;
  final String? image1;
  final String? image2;
  final String? image3;
  final String? image4;
  final String? taskTypeImage;
  final String? taskTypeName;
  final String? time;

  const ReviewCardWidget(
      {super.key,
      required this.userName,
      required this.userAvatar,
      required this.star,
      required this.content,
      this.image1,
      this.image2,
      this.image3,
      this.image4,
      this.taskTypeImage,
      this.taskTypeName,
      this.time});

  @override
  State<ReviewCardWidget> createState() => _ReviewCardWidgetState();
}

class _ReviewCardWidgetState extends State<ReviewCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.xam_vien,
                      width: 2,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.userName,
                      style: AppTextStyle.textthuong,
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(widget.content, style: AppTextStyle.textthuongxam),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Wrap(spacing: 5, runSpacing: 10, children: [
                if (widget.image1 != null)
                  Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color: AppColors.xam72,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                if (widget.image2 != null)
                  Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color: AppColors.xam72,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                if (widget.image3 != null)
                  Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color: AppColors.xam72,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                if (widget.image4 != null)
                  Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color: AppColors.xam72,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
              ]),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                  color: AppColors.nen_the,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.cam_main,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.taskTypeName ?? '',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            decoration: TextDecoration.none,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.normal,
                          )),
                      Text(widget.time != null ? widget.time! : '',
                          style: const TextStyle(
                            color: AppColors.xam72,
                            fontSize: 12,
                            decoration: TextDecoration.none,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.normal,
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
