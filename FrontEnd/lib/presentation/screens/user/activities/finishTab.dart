// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/header.dart';
import 'package:se121_giupviec_app/common/widgets/button/sizedbutton.dart';
import 'package:se121_giupviec_app/common/widgets/input/disableInput.dart';

import 'package:se121_giupviec_app/common/widgets/tasker_row/taskerRowReview.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_infor1.dart';
import 'package:se121_giupviec_app/core/configs/text/app_text_style.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:se121_giupviec_app/presentation/bloc/task/a_task_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/task/a_task_state.dart';
import 'package:se121_giupviec_app/presentation/screens/user/account/addReport.dart';
import 'package:se121_giupviec_app/presentation/screens/user/activities/newTaskStep1.dart';
// import statements here

class Finishtab extends StatefulWidget {
  final int id;
  final int userId;
  final int numberOfTasker;
  final int taskTypeId;
  const Finishtab(
      {super.key,
      required this.id,
      required this.numberOfTasker,
      required this.userId,
      required this.taskTypeId});

  @override
  State<Finishtab> createState() => _FinishTabState();
}

class _FinishTabState extends State<Finishtab> {
  bool _isLabelVisible = false;

  final bool _isEditableNote = false;

  void _hideLabel() {
    setState(() {
      _isLabelVisible = false;
    });
  }

  @override
  void initState() {
    super.initState();

    BlocProvider.of<ATaskCubit>(context).getATasks2(widget.id, widget.userId);
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CreateReportScreen(
                                  taskId: widget.id,
                                  userId: widget.userId,
                                ),
                              ),
                            );
                          },
                          text: 'Khiếu nại',
                          StrokeColor: AppColors.cam_main,
                          isStroke: true,
                          textColor: AppColors.cam_main,
                          backgroundColor: Colors.white,
                          width: MediaQuery.of(context).size.width / 2 - 15,
                          height: 45,
                        ),
                        Sizedbutton(
                          onPressFun: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Newtaskstep1(
                                  userId: 3,
                                  taskTypeId: widget.taskTypeId,
                                ),
                              ),
                            );
                          },
                          text: 'Đặt lại',
                          width: MediaQuery.of(context).size.width / 2 - 15,
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
                      text1: 'Công việc đã hoàn thành',
                      text2:
                          "Bạn đã xác nhận hoàn thành công việc, cảm ơn đã sử dụng dịch vụ của chúng tôi.",
                      icon: Icon(
                        Icons.check, // Icon kiểu hình tròn
                        color: Colors.white, // Màu của icon
                        size: 50, // Kích thước của icon
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
                                'Người giúp việc',
                                style: AppTextStyle.tieudebox,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Column(
                                children: taskerList.map<Widget>((atasker) {
                                  if (atasker.status == "S5") {
                                    return Taskerrowreview(
                                      userName: (state.task.user as Map<String,
                                              dynamic>)['name'] ??
                                          '',
                                      userId: widget.userId,
                                      reload: () {
                                        print('reload');
                                        BlocProvider.of<ATaskCubit>(context)
                                            .getATasks2(
                                                widget.id, widget.userId);
                                      },
                                      Star: (atasker.reviewStar?.toDouble()),
                                      task: state.task,
                                      taskTypeAvatar: (task.taskType as Map<
                                              String, dynamic>)['avatar'] ??
                                          "",
                                      taskTypeName: (task.taskType as Map<
                                              String, dynamic>)['name'] ??
                                          '',
                                      taskTypeId: (task.taskType
                                              as Map<String, dynamic>)['id'] ??
                                          1,
                                      taskerId: (atasker.tasker
                                              as Map<String, dynamic>)['id'] ??
                                          1,
                                      taskerName: (atasker.tasker as Map<String,
                                              dynamic>)['name'] ??
                                          '',
                                      taskerImageLink: (atasker.tasker as Map<
                                              String, dynamic>)['avatar'] ??
                                          '',
                                      taskerPhone: (atasker.tasker as Map<
                                          String, dynamic>)['phoneNumber'],
                                    );
                                  } else {
                                    return Container(); // Return an empty container if the status is not "S1"
                                  }
                                }).toList(),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Thông tin chi tiết',
                                  style: AppTextStyle.tieudebox,
                                ),
                                Expanded(
                                  child: Text(
                                    task.isPaid == true
                                        ? 'Đã thanh toán'
                                        : 'Chưa thanh toán',
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        color: task.isPaid == true
                                            ? AppColors.xanh_main
                                            : AppColors.do_main,
                                        fontSize: 15,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold),
                                    softWrap: true,
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                              ],
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
    ]);
  }
}
