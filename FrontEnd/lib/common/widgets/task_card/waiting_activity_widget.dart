// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:se121_giupviec_app/common/widgets/button/sizedbutton.dart';
import 'package:se121_giupviec_app/core/configs/assets/app_vectors.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';

class WatingActivityWidget extends StatefulWidget {
  const WatingActivityWidget({super.key});

  @override
  State<WatingActivityWidget> createState() => WatingActivityWidgetState();
}

class WatingActivityWidgetState extends State<WatingActivityWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
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
                    padding: const EdgeInsets.fromLTRB(10, 10, 15, 5),
                    child: SvgPicture.asset(
                      AppVectors.baby_carriage_icon,
                      height: 30,
                      width: 30,
                    ),
                  ),
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Align children to the left
                    children: [
                      Row(
                        children: [
                          Text(
                            'Trông trẻ',
                            textAlign: TextAlign.left, // Align text to the left
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            '#',
                            textAlign: TextAlign.left, // Align text to the left
                            style: TextStyle(
                              fontFamily: 'Inter',
                              color: Color(0xFF4AB7B6),
                              fontSize: 17,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            'DV01',
                            textAlign: TextAlign.left, // Align text to the left
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
                        'Đã đăng 20 phút trước',
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
                    size: 28.0,
                  )
                ],
              ),
              SizedBox(height: 8),
              Divider(),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 5),
                child: Row(
                  children: [
                    Text(
                      'Ngày bắt đầu:   ',
                      style: TextStyle(
                        color: Color(0xFF727272),
                        fontSize: 15,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(width: 20),
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
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Địa chỉ:   ',
                      style: TextStyle(
                        color: Color(0xFF727272),
                        fontSize: 15,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(width: 65),
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
                            '+(84) 345664xxx',
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
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 5),
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
                    SizedBox(width: 88),
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
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 5),
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
                    SizedBox(width: 60),
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
              SizedBox(height: 8),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment
                          .start, // Ensure the column itself aligns its children to the start
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Có 5 ứng cử viên cho công việc',
                            style: TextStyle(
                              color: AppColors.cam_main,
                              fontSize: 15,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '1/4 vị trí',
                            style: TextStyle(
                              color: AppColors.xanh_main,
                              fontSize: 15,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Sizedbutton(text: 'Xem chi tiết', width: 130)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
