import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:se121_giupviec_app/common/widgets/button/sizedbutton.dart';
import 'package:se121_giupviec_app/core/configs/assets/app_vectors.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';

class JobCard extends StatelessWidget {
  final String avatar;
  final bool isMe;
  final bool isCenter;
  const JobCard({
    required this.avatar,
    required this.isMe,
    this.isCenter = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: isCenter
              ? MainAxisAlignment.center
              : isMe
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
          children: [
            if (!isMe && !isCenter)
              SvgPicture.asset(
                avatar,
                width: 32,
                height: 32,
              ),
            const SizedBox(
              width: 10,
            ),
            Container(
              width: 240,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Đã ứng cử công việc",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(
                      height: 7,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          AppVectors.facebook,
                          width: 32,
                          height: 32,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: const TextSpan(
                                text: "Trông trẻ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                                children: [
                                  TextSpan(
                                    text: " #2121215",
                                    style: TextStyle(
                                      color: AppColors.cam_main,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Text(
                              "20/3/2024 6:00",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    RichText(
                      text: const TextSpan(
                        text: "Giá: ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                        children: [
                          TextSpan(
                            text: "100.000đ/60m/2h",
                            style: TextStyle(
                              color: AppColors.cam_main,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    RichText(
                      text: const TextSpan(
                        text: "Ứng cử viên: ",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                        children: [
                          TextSpan(
                            text: "2/4",
                            style: TextStyle(
                              color: AppColors.cam_main,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Sizedbutton(
                      onPressFun: () {},
                      text: "Xác nhận thuê",
                      backgroundColor: AppColors.xanh_main,
                      textColor: Colors.white,
                      width: 210,
                      height: 40,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
