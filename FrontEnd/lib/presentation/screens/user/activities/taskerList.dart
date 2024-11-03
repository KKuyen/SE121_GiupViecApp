// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';
import 'package:se121_giupviec_app/common/widgets/button/sizedbutton.dart';
import 'package:se121_giupviec_app/common/widgets/tasker_row/taskerRowAccept.dart';
import 'package:se121_giupviec_app/common/widgets/tasker_row/taskerRowBasic.dart';
import 'package:se121_giupviec_app/common/widgets/tasker_row/taskerRowDelete.dart';
import 'package:se121_giupviec_app/common/widgets/tasker_row/taskerRowReview.dart';
import 'package:se121_giupviec_app/core/configs/text/app_text_style.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:se121_giupviec_app/domain/entities/taskerList.dart';
import 'package:se121_giupviec_app/domain/repository/BlockTaskers_repository.dart';
import 'package:se121_giupviec_app/presentation/bloc/task/a_task_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/tasker_list/taskerlist_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/tasker_list/taskerlist_state.dart';
import 'package:se121_giupviec_app/presentation/screens/user/activities/activity.dart';
import 'package:se121_giupviec_app/presentation/screens/user/activities/taskerProfile.dart';

class Taskerlist extends StatefulWidget {
  final VoidCallback cancel;
  final Future<void> Function()? callBackFun;
  final Future<void> Function()? callBackFunforTab;

  final int id;
  final numberOfTasker;
  final String taskStatus;

  Taskerlist(
      {required this.numberOfTasker,
      required this.taskStatus,
      this.id = 1,
      super.key,
      this.callBackFun,
      this.callBackFunforTab,
      required this.cancel});

  @override
  State<Taskerlist> createState() => _TaskerListState();
}

class _TaskerListState extends State<Taskerlist> {
  int type = 1;
  late ValueNotifier<List<TaskerList>> approvedTaskersNotifier;
  late ValueNotifier<List<TaskerList>> pendingTaskerNotifier;
  int approvedLength = 0;
  int pendingLength = 0;

  @override
  void initState() {
    super.initState();
    approvedTaskersNotifier = ValueNotifier([]);
    pendingTaskerNotifier = ValueNotifier([]);
    final taskerlistCubit =
        BlocProvider.of<TaskerlistCubit>(context).getTaskerList(widget.id);
  }

  void moveTaskerToPending(TaskerList taskerList) {
    print("roi");
    approvedTaskersNotifier.value = List.from(approvedTaskersNotifier.value)
      ..remove(taskerList);
    pendingTaskerNotifier.value = List.from(pendingTaskerNotifier.value)
      ..add(taskerList);
    pendingTaskerNotifier.notifyListeners();
    approvedTaskersNotifier.notifyListeners();
    print(pendingTaskerNotifier.value.length);
  }

  void moveTaskerToApprove(TaskerList taskerList) {
    pendingTaskerNotifier.value = List.from(pendingTaskerNotifier.value)
      ..remove(taskerList);
    approvedTaskersNotifier.value = List.from(approvedTaskersNotifier.value)
      ..add(taskerList);
    pendingTaskerNotifier.notifyListeners();
    approvedTaskersNotifier.notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskerlistCubit, TaskerListState>(
      builder: (context, state) {
        if (state is TaskerListLoading) {
          return Center(
            child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                ),
                child: Center(
                    child: Container(
                        height: 40,
                        width: 40,
                        child: CircularProgressIndicator()))),
          );
        } else if (state is TaskerListSuccess) {
          final taskerList = state.taskerList;

          int approveTaskerNumber = 0;
          for (var tasker in state.taskerList) {
            if (tasker.status == "S2") {
              approveTaskerNumber++;
            }
          }

          approvedTaskersNotifier.value =
              taskerList.where((tasker) => tasker.status == "S2").toList();
          if (widget.taskStatus == 'TS3') {
            approvedTaskersNotifier.value =
                taskerList.where((tasker) => tasker.status == "S5").toList();
          }
          pendingTaskerNotifier.value =
              taskerList.where((tasker) => tasker.status == "S1").toList();
          return Padding(
            padding: EdgeInsets.all(15),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 15, 20),
                child: Column(
                  mainAxisSize: MainAxisSize
                      .min, // Điều này giúp cột chỉ chiếm diện tích cần thiết
                  children: [
                    Row(
                      children: [
                        if (widget.taskStatus == 'TS1')
                          Text('Danh sách ứng cử viên',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                decoration: TextDecoration.none,
                              )),
                        if (widget.taskStatus == 'TS2' ||
                            widget.taskStatus == 'TS3')
                          Text('Danh sách người giúp việc',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                decoration: TextDecoration.none,
                              )),
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: widget.cancel,
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        if (widget.taskStatus == 'TS1')
                          Text(
                            'Danh sách đã xác nhận',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.xam72,
                              fontFamily: 'Inter',
                              decoration: TextDecoration.none,
                            ),
                          ),
                        if (widget.taskStatus == 'TS1') Spacer(),
                        SizedBox(width: 15)
                      ],
                    ),
                    SizedBox(height: 10),

                    // Sử dụng Container để giới hạn chiều cao của danh sách đã xác nhận
                    if (widget.taskStatus == 'TS1')
                      ValueListenableBuilder<List<TaskerList>>(
                        valueListenable: approvedTaskersNotifier,
                        builder: (context, approvedTaskers, _) {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: approvedTaskers.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Taskerprofile(
                                              taskerId:
                                                  approvedTaskers[index].id,
                                            )),
                                  );
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 0, 12, 0),
                                  child: Column(
                                    children: [
                                      Taskerrowdelete(
                                        onPressFun: () {
                                          moveTaskerToPending(
                                              approvedTaskers[index]);
                                        },
                                        taskerName: (approvedTaskers[index]
                                                .tasker
                                            as Map<String, dynamic>)['name'],
                                        taskerId: (approvedTaskers[index].tasker
                                            as Map<String, dynamic>)['id'],
                                        taskerPhone:
                                            (approvedTaskers[index].tasker
                                                    as Map<String, dynamic>)[
                                                'phoneNumber'],
                                      ),
                                      Divider()
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    if (widget.taskStatus == 'TS3')
                      ValueListenableBuilder<List<TaskerList>>(
                        valueListenable: approvedTaskersNotifier,
                        builder: (context, approvedTaskers, _) {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: approvedTaskers.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Taskerprofile(
                                              taskerId:
                                                  approvedTaskers[index].id,
                                            )),
                                  );
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 0, 12, 0),
                                  child: Column(
                                    children: [
                                      Taskerrowreview(
                                        taskerName: (approvedTaskers[index]
                                                .tasker
                                            as Map<String, dynamic>)['name'],
                                        taskerId: (approvedTaskers[index].tasker
                                            as Map<String, dynamic>)['id'],
                                        taskerPhone:
                                            (approvedTaskers[index].tasker
                                                    as Map<String, dynamic>)[
                                                'phoneNumber'],
                                      ),
                                      Divider()
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    if (widget.taskStatus == 'TS2')
                      ValueListenableBuilder<List<TaskerList>>(
                        valueListenable: approvedTaskersNotifier,
                        builder: (context, approvedTaskers, _) {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: approvedTaskers.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Taskerprofile(
                                              taskerId:
                                                  approvedTaskers[index].id,
                                            )),
                                  );
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 0, 12, 0),
                                  child: Column(
                                    children: [
                                      Taskerrowbasic(
                                        taskerName: (approvedTaskers[index]
                                                .tasker
                                            as Map<String, dynamic>)['name'],
                                        taskerId: (approvedTaskers[index].tasker
                                            as Map<String, dynamic>)['id'],
                                        taskerPhone:
                                            (approvedTaskers[index].tasker
                                                    as Map<String, dynamic>)[
                                                'phoneNumber'],
                                      ),
                                      Divider()
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    if (approvedTaskersNotifier.value.length == 0 &&
                        pendingTaskerNotifier.value.length == 0)
                      Column(
                        children: [
                          SizedBox(height: 10),
                          Center(
                            child: Text(
                              'Danh sách trống',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Inter',
                                color: AppColors.xam72,
                                decoration: TextDecoration.none,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
//bo đi neu la case 2
                    if (widget.taskStatus == 'TS1')
                      Column(
                        children: [
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Text(
                                'Danh sách ứng cử viên',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Inter',
                                  color: AppColors.xam72,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),

                          // Sử dụng Container để giới hạn chiều cao của danh sách ứng cử viên

                          Container(
                            child: ValueListenableBuilder<List<TaskerList>>(
                                valueListenable: pendingTaskerNotifier,
                                builder: (context, pendingTasker, _) {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: pendingTasker.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Taskerprofile(
                                                        taskerId:
                                                            pendingTasker[index]
                                                                .id)),
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              5, 0, 12, 0),
                                          child: Column(
                                            children: [
                                              Taskerrowaccept(
                                                onPressFun: () {
                                                  moveTaskerToApprove(
                                                      pendingTasker[index]);
                                                },
                                                taskerName:
                                                    (pendingTasker[index].tasker
                                                        as Map<String,
                                                            dynamic>)['name'],
                                                taskerId:
                                                    (pendingTasker[index].tasker
                                                        as Map<String,
                                                            dynamic>)['id'],
                                                taskerPhone:
                                                    (pendingTasker[index].tasker
                                                            as Map<String,
                                                                dynamic>)[
                                                        'phoneNumber'],
                                              ),
                                              Divider()
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }),
                          ),
                          if (pendingTaskerNotifier.value.length == 0 &&
                              approvedTaskersNotifier.value.length == 0)
                            Column(
                              children: [
                                SizedBox(height: 10),
                                Center(
                                  child: Text(
                                    'Không có ứng cử viên nào khác',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Inter',
                                      color: AppColors.xam72,
                                      decoration: TextDecoration.none,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          const SizedBox(height: 10),
                          if (pendingTaskerNotifier.value.length != 0 ||
                              approvedTaskersNotifier.value.length != 0)
                            Row(
                              children: [
                                Sizedbutton(
                                  onPressFun: () async {
                                    BlocProvider.of<TaskerlistCubit>(context)
                                        .emitLoading();

                                    for (var tasker
                                        in approvedTaskersNotifier.value) {
                                      await BlocProvider.of<ATaskCubit>(context)
                                          .updateTaskerStatus(tasker.id, 'S2');
                                    }
                                    for (var tasker
                                        in pendingTaskerNotifier.value) {
                                      await BlocProvider.of<ATaskCubit>(context)
                                          .updateTaskerStatus(tasker.id, 'S1');
                                    }
                                    if (approvedTaskersNotifier.value.length ==
                                        state.taskerList.length) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ActivityPage()),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                            'Công việc đã đủ người giúp việc, đang chờ tới ngày làm'),
                                        backgroundColor: AppColors.xanh_main,
                                      ));
                                    }
                                    if (widget.callBackFun == null) {
                                      print("vào cái này");

                                      await widget.callBackFunforTab!();

                                      widget.cancel();
                                    } else {
                                      await widget.callBackFun!();

                                      widget.cancel();
                                    }
                                  },
                                  text: 'Xác nhận',
                                  height: 45,
                                  width:
                                      MediaQuery.of(context).size.width * 0.5 -
                                          40,
                                ),
                                const SizedBox(width: 10),
                                Sizedbutton(
                                  onPressFun: () {
                                    widget.cancel();
                                  },
                                  text: 'Hủy',
                                  height: 45,
                                  backgroundColor: Colors.white,
                                  textColor: AppColors.do_main,
                                  isStroke: true,
                                  StrokeColor: AppColors.do_main,
                                  width:
                                      MediaQuery.of(context).size.width * 0.5 -
                                          40,
                                )
                              ],
                            )
                        ],
                      ),
                  ],
                ),
              ),
            ),
          );
        } else if (state is TaskerListError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const Center(child: Text('No tasks found'));
        }
      },
    );
  }
}
