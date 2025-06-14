// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se121_giupviec_app/common/helpers/SecureStorage.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/header.dart';
import 'package:se121_giupviec_app/common/widgets/button/sizedbutton.dart';
import 'package:se121_giupviec_app/common/widgets/input/disableInput.dart';
import 'package:se121_giupviec_app/common/widgets/tasker_row/taskerRowBasic.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_infor1.dart';
import 'package:se121_giupviec_app/core/configs/text/app_text_style.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:se121_giupviec_app/presentation/bloc/notification/notification_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/task/a_task_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/task/a_task_state.dart';

import 'package:se121_giupviec_app/presentation/screens/user/activities/taskerList.dart';
// import statements here

class Approvetab extends StatefulWidget {
  final int id;
  final int numberOfTasker;
  final int userId;
  const Approvetab(
      {super.key,
      required this.id,
      required this.numberOfTasker,
      required this.userId});

  @override
  State<Approvetab> createState() => _ApprovetabState();
}

class _ApprovetabState extends State<Approvetab> {
  final String _formattedDate = '20:58';
  final String _formattedTime = '16/10/2024';
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

  String returnText(DateTime time) {
    if (time.isAfter(DateTime.now())) {
      return 'Ngày ${time.day}/${time.month}/${time.year} là lịch làm việc. Lưu ý chú ý thời gian';
    } else {
      return 'Đã tới ngày làm. Công việc bắt đầu lúc ${time.hour}giờ ${time.minute} phút';
    }
  }

  @override
  void initState() {
    super.initState();

    final aTaskCubit = BlocProvider.of<ATaskCubit>(context)
        .getATasks2(widget.id, widget.userId);
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
                        if (!task.time.isBefore(DateTime.now()))
                          Sizedbutton(
                            onPressFun: () async {
                              bool? confirmDelete = await showDialog<bool>(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Xác nhận'),
                                    content: Text(
                                        'Bạn có chắc chắn muốn xóa công việc này không?'),
                                    actions: <Widget>[
                                      Sizedbutton(
                                          onPressFun: () {
                                            Navigator.of(context).pop(
                                                false); // Return false if not confirmed
                                          },
                                          text: 'Hủy',
                                          backgroundColor: AppColors.xanh_main,
                                          height: 45,
                                          width: 100),
                                      Spacer(),
                                      Sizedbutton(
                                          onPressFun: () {
                                            Navigator.of(context).pop(
                                                true); // Return true if confirmed
                                          },
                                          text: 'Xóa',
                                          backgroundColor: AppColors.do_main,
                                          height: 45,
                                          width: 100),
                                    ],
                                  );
                                },
                              );

                              if (confirmDelete == true) {
                                // Show a second dialog to select an integer cancelCode
                                int? cancelCode = await showDialog<int>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                        'Lý do hủy',
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ListTile(
                                            title: Text(
                                                'Tôi không có nhu cầu  nữa',
                                                style: AppTextStyle.textthuong),
                                            onTap: () =>
                                                Navigator.of(context).pop(0),
                                          ),
                                          ListTile(
                                            title: Text(
                                                'Tôi có công việc đột xuất',
                                                style: AppTextStyle.textthuong),
                                            onTap: () =>
                                                Navigator.of(context).pop(1),
                                          ),
                                          ListTile(
                                            title: Text(
                                                'Tôi muốn đặt công việc khác',
                                                style: AppTextStyle.textthuong),
                                            onTap: () =>
                                                Navigator.of(context).pop(2),
                                          ),
                                          ListTile(
                                            title: Text('Lý do khác',
                                                style: AppTextStyle.textthuong),
                                            onTap: () =>
                                                Navigator.of(context).pop(3),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );

                                if (cancelCode != null) {
                                  await BlocProvider.of<ATaskCubit>(context)
                                      .deleteTask(widget.id, cancelCode);
                                  for (var tasker in state.taskerList) {
                                    if (tasker.status == 'S2' ||
                                        tasker.status == 'S1') {
                                      await BlocProvider.of<
                                              allNotificationCubit>(context)
                                          .addANotificaiton(
                                        tasker.taskerId,
                                        'Công việc đã bị hủy',
                                        'Công việc #DV${state.task.id} của bạn đã bị hủy bởi khách hàng.',
                                        'cancel.jpg',
                                      );
                                    }
                                  }
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Đã hủy công việc '),
                                      backgroundColor: AppColors.xanh_main,
                                    ),
                                  );
                                  Navigator.pop(context, true);
                                }
                              }
                            },
                            text: 'Xác nhận hủy',
                            StrokeColor: AppColors.cam_main,
                            isStroke: true,
                            textColor: AppColors.cam_main,
                            backgroundColor: Colors.white,
                            width: MediaQuery.of(context).size.width - 20,
                            height: 45,
                          ),
                        if (task.time.isBefore(DateTime.now()))
                          Sizedbutton(
                            onPressFun: () async {
                              bool? confirmComplete = await showDialog<bool>(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Xác nhận'),
                                    content: Text(
                                        'Bạn có chắc chắn muốn xác nhận hoàn thành công việc này không?'),
                                    actions: <Widget>[
                                      Sizedbutton(
                                        onPressFun: () {
                                          Navigator.of(context).pop(
                                              false); // Return false if not confirmed
                                        },
                                        text: 'Hủy',
                                        backgroundColor: Colors.white,
                                        isStroke: true,
                                        textColor: AppColors.xanh_main,
                                        StrokeColor: AppColors.xanh_main,
                                        height: 45,
                                        width: 100,
                                      ),
                                      Sizedbutton(
                                        onPressFun: () {
                                          Navigator.of(context).pop(true); //
                                        },
                                        text: 'Xác nhận',
                                        backgroundColor: AppColors.xanh_main,
                                        height: 45,
                                        width: 70,
                                      ),
                                    ],
                                  );
                                },
                              );

                              if (confirmComplete == true) {
                                await BlocProvider.of<ATaskCubit>(context)
                                    .finishTask(widget.id);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Đã xác nhận hoàn thành công việc '),
                                    backgroundColor: AppColors.xanh_main,
                                  ),
                                );
                                Navigator.pop(context, true);
                              }
                              // Add your logic here
                            },
                            text: 'Đã hoàn thành',
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
                      text1: (task.time.isAfter(DateTime.now()))
                          ? "Đang chờ tới ngày làm"
                          : "Đã tới ngày làm",
                      text2: returnText(task.time),
                      icon: Icon(
                        Icons.timelapse,
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
                                  if (atasker.status == "S2") {
                                    return Taskerrowbasic(
                                      userId: widget.userId,
                                      taskerId: (atasker.tasker
                                          as Map<String, dynamic>)['id'],
                                      taskerName: (atasker.tasker as Map<String,
                                              dynamic>)['name'] ??
                                          '',
                                      taskerImageLink: (atasker.tasker as Map<
                                              String, dynamic>)['avatar'] ??
                                          '',
                                      taskerPhone: (atasker.tasker as Map<
                                              String,
                                              dynamic>)['phoneNumber'] ??
                                          '',
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
                                Flexible(
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
                                      fontWeight: FontWeight.bold,
                                    ),
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
                                      Flexible(
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
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              '${(task.location as Map<String, dynamic>)['detailAddress'] ?? ''}, ${(task.location as Map<String, dynamic>)['district'] ?? ""}, ${(task.location as Map<String, dynamic>)['province'] ?? ''}, ${(task.location as Map<String, dynamic>)['country'] ?? ''}',
                                              softWrap: true,
                                              style: TextStyle(
                                                  fontFamily: 'Inter',
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight:
                                                      FontWeight.normal),
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
                                                  fontWeight:
                                                      FontWeight.normal),
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
                                      const SizedBox(width: 70),
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
                                      const SizedBox(width: 25),
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
