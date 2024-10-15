// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/common/widgets/button/sizedbutton.dart';
import 'package:se121_giupviec_app/common/widgets/input/disableInput.dart';
import 'package:se121_giupviec_app/common/widgets/tasker_row/taskerRowBasic.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_infor1.dart';
import 'package:se121_giupviec_app/core/configs/text/app_text_style.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:se121_giupviec_app/presentation/user/activities/taskerList.dart';
// import statements here

class Canceltab extends StatefulWidget {
  const Canceltab({super.key});

  @override
  State<Canceltab> createState() => _CanceltabState();
}

class _CanceltabState extends State<Canceltab> {
  String _formattedDate = '20:58';
  String _formattedTime = '16/10/2024';
  bool _isLabelVisible = false;

  bool _isEditableNote = false;

  void _showLabel() {
    setState(() {
      _isLabelVisible = true;
    });
  }

  void _hideLabel() {
    setState(() {
      _isLabelVisible = false;
    });
  }

  void _toggleEditableNote() {
    setState(() {
      _isEditableNote =
          !_isEditableNote; // Chuyển trạng thái từ có thể chỉnh sửa sang không và ngược lại
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
          backgroundColor: AppColors.nen_the,
          appBar: BasicAppbar(
            title: const Text(
              'Thông tin',
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

          //noi dung
          body: SingleChildScrollView(
              child: Column(
            children: [
              Container(
                  decoration: const BoxDecoration(color: AppColors.do_main),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 22, horizontal: AppInfor1.horizontal_padding),
                    child: Row(
                      children: [
                        // Sử dụng Expanded để văn bản chiếm hết không gian có thể
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Đã hủy dịch vụ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Inter',
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(
                                  height: 5), // Khoảng cách giữa các đoạn text
                              Text(
                                'Đã hủy dịch vụ vào ngày 23/10/2024',
                                softWrap: true,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'Inter',
                                  color: Colors.white,
                                  // Màu chữ nhạt hơn cho phần mô tả
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 20), // Khoảng cách giữa văn bản và icon
                        // Ic
                        Icon(
                          Icons.cancel, // Icon kiểu hình tròn
                          color: Colors.white, // Màu của icon
                          size: 50, // Kích thước của icon
                        ),
                      ],
                    ),
                  )),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(AppInfor1.horizontal_padding),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Thông tin chi tiết',
                          style: AppTextStyle.tieudebox,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Divider(),
                                const Text('Mã đơn hàng: ',
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal)),
                                const SizedBox(width: 24),
                                Text(
                                  '#DV01',
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      color: AppColors.xam72,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Divider(),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                const Text('Tên dịch vụ: ',
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal)),
                                const SizedBox(width: 38),
                                Text(
                                  'Trông trẻ',
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      color: AppColors.xam72,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Divider(),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                const Text('Ngày bắt đầu: ',
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal)),
                                const SizedBox(width: 25),
                                Expanded(
                                  child: Text(
                                    "$_formattedTime $_formattedDate",
                                    softWrap: true,
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        color: AppColors.xam72,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Divider(),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                const Text('Địa chỉ: ',
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal)),
                                const SizedBox(width: 26),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Trần Hồng Quyền',
                                        style: TextStyle(
                                            fontFamily: 'Inter',
                                            color: AppColors.xam72,
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      const SizedBox(height: 5),
                                      const Text(
                                        '123 Đường ABC, Quận 1, TP.HCM',
                                        softWrap: true,
                                        style: TextStyle(
                                            fontFamily: 'Inter',
                                            color: AppColors.xam72,
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      const SizedBox(height: 5),
                                      const Text(
                                        '(+84) 123 456 789',
                                        style: TextStyle(
                                            fontFamily: 'Inter',
                                            color: AppColors.xam72,
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Divider(),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                const Text('Giá: ',
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal)),
                                const SizedBox(width: 52),
                                Text(
                                  '100.000 VND',
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      color: AppColors.xam72,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Divider(),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                const Text('Ghi chú: ',
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal)),
                                const SizedBox(width: 9),
                                DisableInput(
                                  enabled: _isEditableNote,
                                  text:
                                      'Nhân viên hổ trợ mang theo dụng cụ, đến sớm 15 phút',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(AppInfor1.horizontal_padding),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Lý do hủy',
                          style: AppTextStyle.tieudebox,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                const Text('Yêu cầu bởi: ',
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal)),
                                const SizedBox(width: 47),
                                Expanded(
                                  child: Text(
                                    'Khách hàng',
                                    softWrap: true,
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        color: AppColors.xam72,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const Text('Yêu cầu vào:',
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal)),
                                const SizedBox(width: 42),
                                Expanded(
                                  child: Text(
                                    '2:00 PM, 16/7/2024',
                                    softWrap: true,
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        color: AppColors.xam72,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                const Text('Lý do:',
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal)),
                                const SizedBox(width: 25),
                                Expanded(
                                  child: Text(
                                    'Khách hàng có việc đột xuất',
                                    softWrap: true,
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        color: AppColors.xam72,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ))),
      if (_isLabelVisible)
        Container(
          color: Colors.black.withOpacity(0.5),
        ),
      if (_isLabelVisible)
        Center(
          child: Taskerlist(
            cancel: _hideLabel,
          ),
        ),
    ]);
  }
}
