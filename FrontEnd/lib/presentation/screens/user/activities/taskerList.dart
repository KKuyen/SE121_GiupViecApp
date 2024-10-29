// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:se121_giupviec_app/common/widgets/button/sizedbutton.dart';
import 'package:se121_giupviec_app/common/widgets/tasker_row/taskerRowAccept.dart';
import 'package:se121_giupviec_app/common/widgets/tasker_row/taskerRowDelete.dart';
import 'package:se121_giupviec_app/core/configs/text/app_text_style.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:se121_giupviec_app/presentation/bloc/task/a_task_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/tasker_list/taskerlist_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/tasker_list/taskerlist_state.dart';
import 'package:se121_giupviec_app/presentation/screens/user/activities/taskerProfile.dart';

class Taskerlist extends StatefulWidget {
  final VoidCallback cancel;
  final int id;
  final numberOfTasker;

  const Taskerlist(
      {required this.numberOfTasker,
      this.id = 1,
      super.key,
      required this.cancel});

  @override
  State<Taskerlist> createState() => _TaskerListState();
}

class _TaskerListState extends State<Taskerlist> {
  @override
  void initState() {
    super.initState();
    final taskerlistCubit =
        BlocProvider.of<TaskerlistCubit>(context).getTaskerList(widget.id);
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

          List<Object> approvedTaskers =
              taskerList.where((tasker) => tasker.status == "S2").toList();
          List<Object> pendingTasker =
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
                        Text('Danh sách ứng cử viên',
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
                        Spacer(),
                        Text(
                          '${approvedTaskers.length}/${widget.numberOfTasker} vị trí',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Inter',
                            color: AppColors.xanh_main,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        SizedBox(width: 15)
                      ],
                    ),

                    // Sử dụng Container để giới hạn chiều cao của danh sách đã xác nhận
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: approvedTaskers.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Taskerprofile()),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 12, 0),
                            child: Column(
                              children: [Taskerrowdelete(), Divider()],
                            ),
                          ),
                        );
                      },
                    ),
                    if (approvedTaskers.isEmpty)
                      Column(
                        children: [
                          SizedBox(height: 10),
                          Center(
                            child: Text(
                              'Không có ứng cử viên nào đã được xác nhận',
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
                    if (pendingTasker.isNotEmpty)
                      Container(
                        height: min(
                            200,
                            MediaQuery.of(context).size.height *
                                0.3), // Giới hạn chiều cao
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: pendingTasker.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Taskerprofile()),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(5, 0, 12, 0),
                                child: Column(
                                  children: [Taskerrowaccept(), Divider()],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    if (pendingTasker.isEmpty)
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
                    Row(
                      children: [
                        Sizedbutton(
                          onPressFun: () {},
                          text: 'Xác nhận',
                          height: 45,
                          width: MediaQuery.of(context).size.width * 0.5 - 40,
                        ),
                        const SizedBox(width: 10),
                        Sizedbutton(
                          onPressFun: () {},
                          text: 'Hủy',
                          height: 45,
                          backgroundColor: Colors.white,
                          textColor: AppColors.do_main,
                          isStroke: true,
                          StrokeColor: AppColors.do_main,
                          width: MediaQuery.of(context).size.width * 0.5 - 40,
                        )
                      ],
                    )
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
