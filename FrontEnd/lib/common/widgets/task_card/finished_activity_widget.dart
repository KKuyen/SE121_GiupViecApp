// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:se121_giupviec_app/common/widgets/button/sizedbutton.dart';
import 'package:se121_giupviec_app/common/widgets/tasker_row/taskerRowBasic.dart';
import 'package:se121_giupviec_app/core/configs/assets/app_vectors.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:se121_giupviec_app/presentation/user/activities/finishTab.dart';

class FinishedActivityWidget extends StatefulWidget {
  const FinishedActivityWidget({super.key});

  @override
  State<FinishedActivityWidget> createState() => FinishedActivityWidgetState();
}

class FinishedActivityWidgetState extends State<FinishedActivityWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Finishtab()),
        );
      },
      child: Center(
          child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 5, 15, 5),
                      child: SvgPicture.asset(
                        AppVectors.baby_carriage_icon,
                        height: 30,
                        width: 30,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment
                          .start, // Align children to the left
                      children: [
                        Row(
                          children: [
                            Text(
                              'Trông trẻ',
                              textAlign:
                                  TextAlign.left, // Align text to the left
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Text(
                              '#',
                              textAlign:
                                  TextAlign.left, // Align text to the left
                              style: TextStyle(
                                fontFamily: 'Inter',
                                color: Color(0xFF4AB7B6),
                                fontSize: 17,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Text(
                              'DV01',
                              textAlign:
                                  TextAlign.left, // Align text to the left
                              style: TextStyle(
                                color: Color(0xFF4AB7B6),
                                fontSize: 17,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Đã hoàn thành',
                          textAlign: TextAlign.left, // Align text to the left
                          style: TextStyle(
                            color: Color(0xFF727272),
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Icon(
                      Icons.more_vert,
                      color: Colors.black,
                      size: 25.0,
                    )
                  ],
                ),
                const SizedBox(height: 4),
                Divider(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 2, 5, 5),
                  child: Row(
                    children: [
                      const Text(
                        'Ngày bắt đầu:   ',
                        style: TextStyle(
                          color: Color(0xFF727272),
                          fontSize: 15,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        'Thứ 7, 20/11/2021',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 2, 5, 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Địa chỉ:   ',
                        style: TextStyle(
                          color: Color(0xFF727272),
                          fontSize: 15,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Trần Hồng Quyền',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Text(
                              'Quốc lộ 13/47B 479, Khu Phố 5, Thủ Đức, Hồ Chí Minh, Việt Nam',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.normal,
                              ),
                              softWrap: true,
                              overflow: TextOverflow.visible,
                            ),
                            Text(
                              '+(54) 345664xxx',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 2, 5, 5),
                  child: Row(
                    children: [
                      Text(
                        'Giá:   ',
                        style: TextStyle(
                          color: Color(0xFF727272),
                          fontSize: 15,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(width: 48),
                      Text(
                        'Thứ 7, 20/11/2021',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 2, 5, 5),
                  child: Row(
                    children: [
                      Text(
                        'Ghi chú:   ',
                        style: TextStyle(
                          color: Color(0xFF727272),
                          fontSize: 15,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(width: 18),
                      Expanded(
                        child: Text(
                          'Nhân viên hổ trợ mang theo dụng cụ, đến sớm 15 phút',
                          style: TextStyle(
                            color: AppColors.xam72,
                            fontSize: 15,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 2, 5, 5),
                  child: Column(
                    children: [
                      const Text('Danh sách người giúp việc',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.bold,
                          )),
                      Padding(
                        padding: const EdgeInsets.all(0),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount:
                              3, // Replace with the actual number of items
                          itemBuilder: (context, index) {
                            return Taskerrowbasic(
                                taskerImageLink:
                                    'https://storage.googleapis.com/se100-af7bc.appspot.com/images/1728630023846-ANIME-PICTURES.NET_-_801133-1197x674-elden_ring-malenia_blade_of_miquella-agong-single-long_hair-wide_image-transformed.jpeg?GoogleAccessId=firebase-adminsdk-6avlp%40se100-af7bc.iam.gserviceaccount.com&Expires=1729234829&Signature=F2pTBMS10pYiDfqBskF7NyLlITUEOwhOQqOPvxmEcCkjBPTV8Lf8KvIu53UV6LNy2s6suCNU0qq97rFaXy%2FKYAquOHeG9%2F%2BstlPmPwViM1mhHF0q12ptEJAwfXbXycND%2FuyaAhNm35zNTBNy%2BdAy%2FZQR4J0CO6lXKLlYLzqP8%2BKuwI4o711lsxSYUVRv1S4%2Fi58Gm%2FF8RDTg%2Fy%2BsP2BGfV71VF44bWcvkwtwjGOkGXWMCmRjmmaDjPiJhxQX9rGDuCyi89Sh9er%2FPWD2lrg6WIh2r14XJjnMnNK8a9tNvH8F5xNDUnohHo2qqOHzWtsOzULdoUUx%2B2USosN9Y79VxQ%3D%3D');
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
