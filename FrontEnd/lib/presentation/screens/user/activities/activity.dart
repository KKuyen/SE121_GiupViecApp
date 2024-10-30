import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se121_giupviec_app/common/widgets/task_card/approved_activity_widget.dart';
import 'package:se121_giupviec_app/common/widgets/task_card/cancel_activity_widget.dart';

import 'package:se121_giupviec_app/common/widgets/task_card/waiting_activity_widget.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:se121_giupviec_app/presentation/bloc/task/get_all_task_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/task/get_all_task_state.dart';
import 'package:se121_giupviec_app/presentation/screens/user/activities/newTaskStep1.dart';
import 'package:se121_giupviec_app/presentation/screens/user/activities/taskerList.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  bool _isLabelVisible = false;
  int numberOfTasker = 0;
  int id = 1;

  void _showLabel(int id, int numberOfTasker) {
    setState(() {
      _isLabelVisible = true;
      this.numberOfTasker = numberOfTasker;
      this.id = id;
    });
  }

  void _hideLabel() {
    setState(() {
      _isLabelVisible = false;
    });
  }

  @override
  void initState() {
    super.initState();
    final taskCubit = BlocProvider.of<TaskCubit>(context).getAllTasks(1);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DefaultTabController(
          length: 4,
          child: JobCardScreen(showLabel: _showLabel, hideLabel: _hideLabel),
        ),
        if (_isLabelVisible)
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
        if (_isLabelVisible)
          Center(
            child: Taskerlist(
              id: id,
              numberOfTasker: numberOfTasker,
              cancel: _hideLabel,
            ),
          ),
      ],
    );
  }
}

class JobCardScreen extends StatelessWidget {
  final void Function(int, int) showLabel;
  final VoidCallback hideLabel;

  const JobCardScreen({required this.showLabel, required this.hideLabel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.nen_the,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const Text(
          'Hoạt động',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Inter',
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: const TabBar(
          indicatorColor: AppColors.xanh_main, // Set the underline color
          labelColor: AppColors.xanh_main, // Set the selected tab text color
          unselectedLabelColor:
              Colors.black, // Set the unselected tab text color
          tabs: [
            Tab(text: 'Đang tìm'),
            Tab(text: 'Đã nhận'),
            Tab(text: 'Hoàn thành'),
            Tab(text: 'Đã hủy'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: WaitingList(showLabel: showLabel),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ApprovedList(showLabel: showLabel),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: FinishedList(showLabel: showLabel),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: CancelList(showLabel: showLabel),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Newtaskstep1()),
          );
        },
        backgroundColor: AppColors.xanh_main,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class WaitingList extends StatelessWidget {
  final void Function(int, int) showLabel;

  const WaitingList({super.key, required this.showLabel});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        if (state is TaskLoading) {
          return Center(
            child: Center(
                child: Container(
                    height: 40,
                    width: 40,
                    child: const CircularProgressIndicator())),
          );
        } else if (state is TaskSuccess) {
          return ListView.builder(
              itemCount: state.TS1tasks.length,
              itemBuilder: (context, index) {
                var task = state.TS1tasks[index];
                int maxTasker = 0;
                int appTasker = 0;
                for (var tasker in task.taskerLists ?? []) {
                  if ((tasker as Map<String, dynamic>)['status'] == 'S1') {
                    maxTasker++;
                  }
                  if ((tasker as Map<String, dynamic>)['status'] == 'S2') {
                    appTasker++;
                  }
                }

                return WatingActivityWidget(
                  ungCuVien: maxTasker,
                  daNhan: appTasker,
                  createAt: task.createdAt,
                  numberOfTasker: task.numberOfTasker ?? 0,
                  onShowLabel: () =>
                      showLabel(task.id, task.numberOfTasker ?? 0),
                  id: task.id,
                  startDay: task.time,
                  price: task.price ?? '',
                  note: task.note ?? '',
                  ownerName:
                      (task.location as Map<String, dynamic>)['ownerName'],
                  phone: (task.location
                      as Map<String, dynamic>)['ownerPhoneNumber'],
                  deltailAddress:
                      (task.location as Map<String, dynamic>)['detailAddress'],
                  province: (task.location as Map<String, dynamic>)['province'],
                  district: (task.location as Map<String, dynamic>)['district'],
                  country: (task.location as Map<String, dynamic>)['country'],
                  serviceName: (task.taskType as Map<String, dynamic>)['name'],
                );
              });
        } else if (state is TaskError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const Center(child: Text('No tasks found'));
        }
      },
    );
  }
}

class ApprovedList extends StatelessWidget {
  final void Function(int, int) showLabel;

  const ApprovedList({required this.showLabel});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        if (state is TaskLoading) {
          return Center(
            child: Center(
                child: Container(
                    height: 40,
                    width: 40,
                    child: const CircularProgressIndicator())),
          );
        } else if (state is TaskSuccess) {
          return ListView.builder(
              itemCount: state.TS2tasks.length,
              itemBuilder: (context, index) {
                var task = state.TS2tasks[index];
                int maxTasker = 0;
                int appTasker = 0;
                for (var tasker in task.taskerLists ?? []) {
                  if ((tasker as Map<String, dynamic>)['status'] == 'S1') {
                    maxTasker++;
                  }
                  if ((tasker as Map<String, dynamic>)['status'] == 'S2') {
                    appTasker++;
                  }
                }

                return ApprovedActivityWidget(
                  ungCuVien: maxTasker,
                  daNhan: appTasker,
                  onShowLabel: () =>
                      showLabel(task.id, task.numberOfTasker ?? 0),
                  createAt: task.createdAt,
                  numberOfTasker: task.numberOfTasker ?? 0,
                  id: task.id,
                  startDay: task.time,
                  price: task.price ?? '',
                  note: task.note ?? '',
                  ownerName:
                      (task.location as Map<String, dynamic>)['ownerName'],
                  phone: (task.location
                      as Map<String, dynamic>)['ownerPhoneNumber'],
                  deltailAddress:
                      (task.location as Map<String, dynamic>)['detailAddress'],
                  province: (task.location as Map<String, dynamic>)['province'],
                  district: (task.location as Map<String, dynamic>)['district'],
                  country: (task.location as Map<String, dynamic>)['country'],
                  serviceName: (task.taskType as Map<String, dynamic>)['name'],
                );
              });
        } else if (state is TaskError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const Center(child: Text('No tasks found'));
        }
      },
    );
  }
}

class FinishedList extends StatelessWidget {
  final void Function(int, int) showLabel;

  const FinishedList({required this.showLabel});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        if (state is TaskLoading) {
          return Center(
            child: Center(
                child: Container(
                    height: 40,
                    width: 40,
                    child: const CircularProgressIndicator())),
          );
        } else if (state is TaskSuccess) {
          return ListView.builder(
              itemCount: state.TS3tasks.length,
              itemBuilder: (context, index) {
                var task = state.TS3tasks[index];
                int maxTasker = 0;
                int appTasker = 0;
                for (var tasker in task.taskerLists ?? []) {
                  if ((tasker as Map<String, dynamic>)['status'] == 'S1') {
                    maxTasker++;
                  }
                  if ((tasker as Map<String, dynamic>)['status'] == 'S2') {
                    appTasker++;
                  }
                }

                return ApprovedActivityWidget(
                  isFinished: true,
                  ungCuVien: maxTasker,
                  daNhan: appTasker,
                  onShowLabel: () =>
                      showLabel(task.id, task.numberOfTasker ?? 0),
                  createAt: task.createdAt,
                  numberOfTasker: task.numberOfTasker ?? 0,
                  id: task.id,
                  startDay: task.time,
                  price: task.price ?? '',
                  note: task.note ?? '',
                  ownerName:
                      (task.location as Map<String, dynamic>)['ownerName'],
                  phone: (task.location
                      as Map<String, dynamic>)['ownerPhoneNumber'],
                  deltailAddress:
                      (task.location as Map<String, dynamic>)['detailAddress'],
                  province: (task.location as Map<String, dynamic>)['province'],
                  district: (task.location as Map<String, dynamic>)['district'],
                  country: (task.location as Map<String, dynamic>)['country'],
                  serviceName: (task.taskType as Map<String, dynamic>)['name'],
                );
              });
        } else if (state is TaskError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const Center(child: Text('No tasks found'));
        }
      },
    );
  }
}

class CancelList extends StatelessWidget {
  final void Function(int, int) showLabel;

  const CancelList({required this.showLabel});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        if (state is TaskLoading) {
          return Center(
            child: Center(
                child: Container(
                    height: 40,
                    width: 40,
                    child: const CircularProgressIndicator())),
          );
        } else if (state is TaskSuccess) {
          return ListView.builder(
              itemCount: state.TS4tasks.length,
              itemBuilder: (context, index) {
                var task = state.TS4tasks[index];
                int maxTasker = 0;
                int appTasker = 0;
                for (var tasker in task.taskerLists ?? []) {
                  if ((tasker as Map<String, dynamic>)['status'] == 'S1') {
                    maxTasker++;
                  }
                  if ((tasker as Map<String, dynamic>)['status'] == 'S2') {
                    appTasker++;
                  }
                }

                return CancelActivityWidget(
                  cancelAt: task.cancelAt ?? DateTime.now(),
                  cancelReason: task.cancelReason ?? '',
                  ungCuVien: maxTasker,
                  daNhan: appTasker,
                  createAt: task.createdAt,
                  numberOfTasker: task.numberOfTasker ?? 0,
                  id: task.id,
                  startDay: task.time,
                  price: task.price ?? '',
                  note: task.note ?? '',
                  ownerName:
                      (task.location as Map<String, dynamic>)['ownerName'],
                  phone: (task.location
                      as Map<String, dynamic>)['ownerPhoneNumber'],
                  deltailAddress:
                      (task.location as Map<String, dynamic>)['detailAddress'],
                  province: (task.location as Map<String, dynamic>)['province'],
                  district: (task.location as Map<String, dynamic>)['district'],
                  country: (task.location as Map<String, dynamic>)['country'],
                  serviceName: (task.taskType as Map<String, dynamic>)['name'],
                );
              });
        } else if (state is TaskError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const Center(child: Text('No tasks found'));
        }
      },
    );
  }
}
