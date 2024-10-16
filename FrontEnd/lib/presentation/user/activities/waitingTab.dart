// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/header.dart';
import 'package:se121_giupviec_app/common/widgets/button/sizedbutton.dart';
import 'package:se121_giupviec_app/common/widgets/input/disableInput.dart';
import 'package:se121_giupviec_app/common/widgets/tasker_row/taskerRowBasic.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_infor1.dart';
import 'package:se121_giupviec_app/core/configs/text/app_text_style.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:se121_giupviec_app/presentation/user/activities/taskerList.dart';
// import statements here

class Waitingtab extends StatefulWidget {
  const Waitingtab({super.key});

  @override
  State<Waitingtab> createState() => _WaitingtabState();
}

class _WaitingtabState extends State<Waitingtab> {
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
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Sizedbutton(
                    onPressFun: () {
                      // Add your logic here
                    },
                    text: 'Xác nhận hủy',
                    StrokeColor: AppColors.cam_main,
                    isStroke: true,
                    textColor: AppColors.cam_main,
                    backgroundColor: Colors.white,
                    width: MediaQuery.of(context).size.width - 20,
                    height: 45,
                  ),
                ],
              ),
            ),
          ),

          //noi dung
          body: SingleChildScrollView(
              child: Column(
            children: [
              Header(
                color: AppColors.cam_main,
                text1: 'Đang tuyển chọn ứng cử viên',
                text2:
                    'Chú ý thời gian làm việc, nếu bạn không tuyển chọn đủ ứng cử viên thì tới thời hạn công việc sẽ tự hủy.',
                icon: Icon(
                  Icons.approval,
                  color: Colors.white, // Màu của icon
                  size: 50, // Kích thước của icon
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: const BoxDecoration(color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(AppInfor1.horizontal_padding),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Người giúp việc',
                            style: AppTextStyle.tieudebox,
                          ),
                          const Spacer(),
                          const Text(
                            '1/4 vị trí',
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.xanh_main),
                          ),
                          const SizedBox(width: 8)
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: 4, // Số lượng tasker
                          itemBuilder: (context, index) {
                            return const Taskerrowbasic(
                              taskerImageLink: '',
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Text(
                                      '5 ứng cử viên ',
                                      style: TextStyle(
                                        color: AppColors.cam_main,
                                        fontSize: 16,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                              ],
                            ),
                            const Spacer(),
                            Sizedbutton(
                              onPressFun: _showLabel,
                              text: 'Danh sách',
                              width: 80,
                              height: 40,
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
                                      color: AppColors.xanh_main,
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
                                      color: Colors.black,
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
                                    _formattedTime + " " + _formattedDate,
                                    softWrap: true,
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2100),
                                      builder: (BuildContext context,
                                          Widget? child) {
                                        return Theme(
                                          data: ThemeData.light().copyWith(
                                            primaryColor: AppColors
                                                .xanh_main, // Header background color
                                            highlightColor: AppColors
                                                .xanh_main, // Selected date color
                                            colorScheme: ColorScheme.light(
                                              primary: AppColors
                                                  .xanh_main, // Header background color
                                              onPrimary: Colors
                                                  .white, // Header text color
                                              onSurface: Colors
                                                  .black, // Body text color
                                            ),
                                            dialogBackgroundColor: Colors
                                                .white, // Background color
                                          ),
                                          child: child!,
                                        );
                                      },
                                    ).then((selectedDate) {
                                      if (selectedDate != null) {
                                        showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                          builder: (BuildContext context,
                                              Widget? child) {
                                            return Theme(
                                              data: ThemeData.light().copyWith(
                                                primaryColor: AppColors
                                                    .xanh_main, // Header background color
                                                hintColor: AppColors
                                                    .xanh_main, // Selected time color
                                                colorScheme: ColorScheme.light(
                                                  primary: AppColors
                                                      .xanh_main, // Header background color
                                                  onPrimary: Colors
                                                      .white, // Header text color
                                                  onSurface: Colors
                                                      .black, // Body text color
                                                ),
                                                dialogBackgroundColor: Colors
                                                    .white, // Background color
                                              ),
                                              child: child!,
                                            );
                                          },
                                        ).then((selectedTime) {
                                          if (selectedTime != null) {
                                            setState(() {
                                              // Update the date and time here
                                              // For example, you can format and display the selected date and time
                                              _formattedDate =
                                                  "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
                                              _formattedTime =
                                                  "${selectedTime.format(context)}";
                                            });
                                          }
                                        });
                                      }
                                    });
                                  },
                                  icon: Icon(
                                    Icons.calendar_today_rounded,
                                    size: 25,
                                  ),
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
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      const SizedBox(height: 5),
                                      const Text(
                                        '123 Đường ABC, Quận 1, TP.HCM',
                                        softWrap: true,
                                        style: TextStyle(
                                            fontFamily: 'Inter',
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      const SizedBox(height: 5),
                                      const Text(
                                        '(+84) 123 456 789',
                                        style: TextStyle(
                                            fontFamily: 'Inter',
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.location_on,
                                    size: 30,
                                  ),
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
                                      color: Colors.black,
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
                                SizedBox(
                                  width: 5,
                                ),
                                IconButton(
                                    onPressed: _toggleEditableNote,
                                    icon: !_isEditableNote
                                        ? Icon(Icons.edit)
                                        : Icon(
                                            Icons.check,
                                            color: AppColors.xanh_main,
                                          ))
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
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
                          'Lịch sử',
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
                                const Text('Ngày đặt: ',
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal)),
                                const SizedBox(width: 25),
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
