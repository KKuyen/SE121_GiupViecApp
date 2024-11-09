// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/header.dart';
import 'package:se121_giupviec_app/common/widgets/button/sizedbutton.dart';
import 'package:se121_giupviec_app/common/widgets/input/disableInput.dart';

import 'package:se121_giupviec_app/common/widgets/tasker_row/taskerRowReview.dart';
import 'package:se121_giupviec_app/common/widgets/userRow/userRow.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_infor1.dart';
import 'package:se121_giupviec_app/core/configs/text/app_text_style.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:se121_giupviec_app/presentation/bloc/task/a_task_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/task/a_task_state.dart';
import 'package:se121_giupviec_app/presentation/screens/user/activities/newTaskStep1.dart';
import 'package:se121_giupviec_app/presentation/screens/user/activities/taskerList.dart';
// import statements here

class ApplyTaskTab extends StatefulWidget {
  final int id;
  final int numberOfTasker;
  final VoidCallback loading;

  const ApplyTaskTab({
    super.key,
    required this.id,
    required this.loading,
    required this.numberOfTasker,
  });

  @override
  State<ApplyTaskTab> createState() => _ApplyTaskTabState();
}

class _ApplyTaskTabState extends State<ApplyTaskTab> {
  bool _isLabelVisible = false;

  final bool _isEditableNote = false;
  bool isContact = false;

  void _hideLabel() {
    setState(() {
      _isLabelVisible = false;
    });
  }

  @override
  void initState() {
    super.initState();

    BlocProvider.of<ATaskCubit>(context).getATasks(widget.id, 1);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      BlocBuilder<ATaskCubit, ATaskState>(
        builder: (context, state) {
          if (state is ATaskLoading) {
            return Center(
              child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                  ),
                  child: Center(
                      child: SizedBox(
                          height: 40,
                          width: 40,
                          child: CircularProgressIndicator()))),
            );
          } else if (state is ATaskSuccess) {
            final task = state.task;
            final taskerList = state.taskerList;
            int maxTasker = 0;
            int appTasker = 0;
            for (var tasker in task.taskerLists ?? []) {
              if ((tasker as Map<String, dynamic>)['status'] == 'S1') {
                maxTasker++;
              }
              if ((tasker)['status'] == 'S2') {
                appTasker++;
              }
            }
            return Scaffold(
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
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Xác nhận'),
                                  content:
                                      Text('Bạn có chắc chắn muốn hủy ứng cử?'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Không'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        await BlocProvider.of<ATaskCubit>(
                                                context)
                                            .taskercanccel(3, widget.id);
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                        // Close the dialog
                                        widget.loading();
                                      },
                                      child: Text('Có'),
                                    ),
                                  ],
                                );
                              },
                            );
                            // Add your logic here
                          },
                          text: 'Hủy ứng cử',
                          StrokeColor: AppColors.cam_main,
                          isStroke: true,
                          textColor: AppColors.cam_main,
                          backgroundColor: Colors.white,
                          width: MediaQuery.of(context).size.width - 15,
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
                    if (!isContact)
                      Header(
                        color: AppColors.cam_main,
                        text1: 'Đang chờ khánh hàng liên hệ trước',
                        text2: "Lưu ý chú ý thông báo.",
                        icon: Icon(
                          FontAwesomeIcons.clock, // Icon kiểu hình tròn
                          color: Colors.white, // Màu của icon
                          size: 40, // Kích thước của icon
                        ),
                      ),
                    if (isContact)
                      Header(
                        color: AppColors.cam_main,
                        text1: 'Đã liên hệ, chờ khách hàng duyệt',
                        text2:
                            "Chờ khách hàng chấp nhận đơn ứng cử của bạn, bạn có thể nhắn tin với khách hàng để trao dổi thêm thông tin.",
                        icon: Icon(
                          FontAwesomeIcons.clock, // Icon kiểu hình tròn
                          color: Colors.white, // Màu của icon
                          size: 40, // Kích thước của icon
                        ),
                      ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: const BoxDecoration(color: Colors.white),
                      child: Padding(
                        padding:
                            const EdgeInsets.all(AppInfor1.horizontal_padding),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'Khách hàng',
                                style: AppTextStyle.tieudebox,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Column(children: [
                                Userrow(
                                    isContact: isContact,
                                    userId: task.userId,
                                    userName: (task.user
                                        as Map<String, dynamic>)['name'],
                                    userPhone: (task.user
                                        as Map<String, dynamic>)['phoneNumber'],
                                    userImageLink: (task.user
                                        as Map<String, dynamic>)['avatar'])
                              ]),
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
                        padding:
                            const EdgeInsets.all(AppInfor1.horizontal_padding),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
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
                                        '#DV${task.id}',
                                        style: TextStyle(
                                            fontFamily: 'Inter',
                                            color: AppColors.cam_main,
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
                                        (task.taskType as Map<String, dynamic>)[
                                                'name'] ??
                                            '',
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
                                          task.time.toString(),
                                          softWrap: true,
                                          style: TextStyle(
                                              fontFamily: 'Inter',
                                              color: Colors.black,
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
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              (task.location as Map<String,
                                                      dynamic>)['ownerName']
                                                  .toString(),
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                              softWrap: true,
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              '${(task.location as Map<String, dynamic>)['detailAddress'] ?? ""}, ${(task.location as Map<String, dynamic>)['district'] ?? ""}, ${(task.location as Map<String, dynamic>)['province'] ?? ''}, ${(task.location as Map<String, dynamic>)['country'] ?? ''}',
                                              softWrap: true,
                                              maxLines:
                                                  3, // Số dòng tối đa, có thể tăng tùy ý
                                              overflow: TextOverflow
                                                  .ellipsis, // Hiển thị dấu "..." nếu vượt quá
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              (task.location as Map<String,
                                                          dynamic>)[
                                                      'ownerPhoneNumber']
                                                  .toString(),
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                              softWrap: true,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Spacer(),
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
                                        '${task.price} VNĐ',
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
                                        text: task.note ?? '',
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
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
                        padding:
                            const EdgeInsets.all(AppInfor1.horizontal_padding),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
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
                                      const SizedBox(width: 87),
                                      Expanded(
                                        child: Text(
                                          task.createdAt.toIso8601String(),
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
                                      const Text('Ngày xác nhận: ',
                                          style: TextStyle(
                                              fontFamily: 'Inter',
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal)),
                                      const SizedBox(width: 42),
                                      Expanded(
                                        child: Text(
                                          task.approvedAt?.toIso8601String() ??
                                              '',
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
                                      const Text('Ngày hoàn thành: ',
                                          style: TextStyle(
                                              fontFamily: 'Inter',
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal)),
                                      const SizedBox(width: 25),
                                      Expanded(
                                        child: Text(
                                          task.finishedAt?.toIso8601String() ??
                                              '',
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
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                )));
          } else if (state is ATaskError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(child: Text('No tasks found'));
          }
        },
      ),
      if (_isLabelVisible)
        Container(
          color: Colors.black.withOpacity(0.5),
        ),
      if (_isLabelVisible) Center(),
    ]);
  }
}
