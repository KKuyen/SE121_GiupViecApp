import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/common/widgets/button/sizedbutton.dart';
import 'package:se121_giupviec_app/common/widgets/button/sizedbutton2text.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_infor1.dart';
import 'package:se121_giupviec_app/core/configs/text/app_text_style.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';

class Newtaskstep1 extends StatefulWidget {
  const Newtaskstep1({super.key});

  @override
  State<Newtaskstep1> createState() => _Newtaskstep1State();
}

class _Newtaskstep1State extends State<Newtaskstep1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.nen_the,
        appBar: BasicAppbar(
          title: const Text(
            'Đặt dịch vụ',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          isHideBackButton: false,
          isHavePadding: true,
          color: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                child: Row(
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(color: AppColors.xanh_main, width: 2),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Trông trẻ', style: AppTextStyle.tieudebox),
                        SizedBox(
                            height:
                                5), // Khoảng cách giữa tiêu đề và văn bản mô tả
                        Container(
                          width: MediaQuery.of(context).size.width -
                              110, // Giới hạn chiều rộng của văn bản để wrap
                          child: Text(
                            'Đây là dịch vụ chăm sóc và đảm bảo an toàn cho các đứa trẻ từ 1-6 tuổi',
                            style:
                                TextStyle(fontSize: 14, color: AppColors.xam72),
                            softWrap:
                                true, // Đảm bảo rằng văn bản sẽ tự động xuống dòng
                            overflow: TextOverflow
                                .visible, // Cho phép văn bản hiển thị đầy đủ
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15), // Padding hai bên
                child: Container(
                  height: 65,
                  child: Stack(
                    children: [
                      // Các đường dashed viền trên
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Dash(
                          direction: Axis.horizontal,
                          length: MediaQuery.of(context).size.width -
                              30, // Chiều dài trừ đi padding
                          dashLength: 5,
                          dashColor: AppColors.xanh_main,
                          dashThickness: 2,
                        ),
                      ),
                      // Các đường dashed viền dưới
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Dash(
                          direction: Axis.horizontal,
                          length: MediaQuery.of(context).size.width -
                              30, // Chiều dài trừ đi padding
                          dashLength: 5,
                          dashColor: AppColors.xanh_main,
                          dashThickness: 2,
                        ),
                      ),
                      // Các đường dashed viền bên trái
                      Positioned(
                        top: 0,
                        bottom: 0,
                        left: 0,
                        child: Dash(
                          direction: Axis.vertical,
                          length: 65,
                          dashLength: 5,
                          dashColor: AppColors.xanh_main,
                          dashThickness: 2,
                        ),
                      ),
                      // Các đường dashed viền bên phải
                      Positioned(
                        top: 0,
                        bottom: 0,
                        right: 0,
                        child: Dash(
                          direction: Axis.vertical,
                          length: 65,
                          dashLength: 5,
                          dashColor: AppColors.xanh_main,
                          dashThickness: 2,
                        ),
                      ),

                      // Row ở giữa container
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              'Giá gốc dịch vụ:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.xanh_main,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '200 000 đ',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.xanh_main,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15, vertical: 15), // Padding hai bên),
                child: Sizedbutton2(
                  onPressFun: () {},
                  width: double.infinity,
                  height: 45,
                  text1: '200 000 đ / 2 cháu / 2 giờ',
                  text2: 'Tiếp theo',
                ),
              ),
            ],
          ),
        ));
  }
}