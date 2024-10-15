import 'package:flutter/material.dart';
import 'package:se121_giupviec_app/core/configs/text/app_text_style.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';

class ReviewCardWidget extends StatefulWidget {
  const ReviewCardWidget({super.key});

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
                      'Nguyễn Văn A',
                      style: AppTextStyle.textthuong,
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text('Chất lượng dịch vụ tốt, rất hài lòng với dịch vụ của bạn',
                style: AppTextStyle.textthuongxam),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Wrap(spacing: 5, runSpacing: 10, children: [
                for (int i = 0; i < 5; i++)
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
            SizedBox(
              height: 10,
            ),
            Container(
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
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
                      Text('Giúp việc định kì',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            decoration: TextDecoration.none,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.normal,
                          )),
                      Text('25/02/2024',
                          style: TextStyle(
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
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                  color: AppColors.nen_the,
                  borderRadius: BorderRadius.circular(10)),
            ),
          ],
        ));
  }
}
