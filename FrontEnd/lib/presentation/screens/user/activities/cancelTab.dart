// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se121_giupviec_app/common/helpers/SecureStorage.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/header.dart';
import 'package:se121_giupviec_app/common/widgets/input/disableInput.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_infor1.dart';
import 'package:se121_giupviec_app/core/configs/text/app_text_style.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:se121_giupviec_app/presentation/bloc/task/a_task_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/task/a_task_state.dart';
import 'package:se121_giupviec_app/presentation/screens/user/activities/taskerList.dart';
// import statements here

class Canceltab extends StatefulWidget {
  final DateTime cancelAt;
  final String cancelReason;
  final String cancelBy;
  final int userId;

  final int id;
  const Canceltab(
      {super.key,
      required this.userId,
      required this.id,
      required this.cancelAt,
      required this.cancelReason,
      required this.cancelBy});

  @override
  State<Canceltab> createState() => _CanceltabState();
}

class _CanceltabState extends State<Canceltab> {
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
    BlocProvider.of<ATaskCubit>(context).getATasks(widget.id, widget.userId);
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
                      Header(
                        color: AppColors.do_main,
                        text1: 'Đã hủy dịch vụ',
                        text2: 'Dịch vụ đã được hủy, không thể thực hiện',
                        icon: Icon(
                          Icons.cancel, // Icon kiểu hình tròn
                          color: Colors.white, // Màu của icon
                          size: 50, // Kích thước của icon
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.all(
                              AppInfor1.horizontal_padding),
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
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
                                          (task.taskType as Map<String,
                                                  dynamic>)['name'] ??
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
                                                                dynamic>)[
                                                            'ownerName']
                                                        .toString() ??
                                                    '',
                                                style: TextStyle(
                                                    fontFamily: 'Inter',
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                '${(task.location as Map<String, dynamic>)['detailAddress'] ?? ''}, ${(task.location as Map<String, dynamic>)['district'] ?? ''}, ${(task.location as Map<String, dynamic>)['province'] ?? ''}, ${(task.location as Map<String, dynamic>)['country'] ?? ''}',
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
                                                        .toString() ??
                                                    '',
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
                          padding: const EdgeInsets.all(
                              AppInfor1.horizontal_padding),
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
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
                                            widget.cancelBy ?? '',
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
                                            widget.cancelAt.toIso8601String() ??
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
                                        const Text('Lý do:',
                                            style: TextStyle(
                                                fontFamily: 'Inter',
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal)),
                                        const SizedBox(width: 25),
                                        Expanded(
                                          child: Text(
                                            widget.cancelReason ?? '',
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
                    userId: widget.userId,
                    id: widget.id,
                    numberOfTasker: task.numberOfTasker,
                    cancel: _hideLabel,
                    taskStatus: 'TS4',
                  ),
                ),
            ]);
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
