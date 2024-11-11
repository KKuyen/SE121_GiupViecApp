import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se121_giupviec_app/common/widgets/task_card/tasker_approve_widget.dart';
import 'package:se121_giupviec_app/common/widgets/task_card/tasker_finish_widget.dart';
import 'package:se121_giupviec_app/common/widgets/task_card/tasker_waiting_activity_widget.dart';

import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:se121_giupviec_app/domain/entities/task.dart';
import 'package:se121_giupviec_app/presentation/bloc/task/tasker/tasker_get_all_task_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/task/tasker/tasker_get_all_task_state.dart';

class TaskerActivityPage extends StatefulWidget {
  final int userId;

  const TaskerActivityPage({super.key, required this.userId});

  @override
  State<TaskerActivityPage> createState() => _TaskerActivityPageState();
}

class _TaskerActivityPageState extends State<TaskerActivityPage> {
  bool _isLabelVisible = false;
  int numberOfTasker = 0;
  int id = 1;
  final bool _isTaskerList = false;
  String taskStatus = '';
  late Task currentTask;
  late int taskTypeId;
  late String TaskTypeName;
  late String TaskTypeAvatar;

  void _showLabel(int id, int numberOfTasker, String status, Task task,
      int taskTypeId, String TaskTypeName, String TaskTypeAvatar) {
    setState(() {
      _isLabelVisible = true;
      this.numberOfTasker = numberOfTasker;
      this.id = id;
      taskStatus = status;
      currentTask = task;
      this.taskTypeId = taskTypeId;
      this.TaskTypeName = TaskTypeName;
      this.TaskTypeAvatar = TaskTypeAvatar;
    });
  }

  void _hideLabel() {
    setState(() {
      _isLabelVisible = false;
    });
  }

  void _refreshScreen() async {
    await BlocProvider.of<TaskerTaskCubit>(context).begin(widget.userId);
  }

  Future<void> _reload() async {
    print("bố mày đây");
    setState(() {
      BlocProvider.of<TaskerTaskCubit>(context).getTS1Tasks(widget.userId);
      BlocProvider.of<TaskerTaskCubit>(context).getTS2Tasks(widget.userId);
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DefaultTabController(
          length: 3,
          child: JobCardScreen(
              showLabel: _showLabel,
              hideLabel: _hideLabel,
              userId: widget.userId),
        ),
        if (_isLabelVisible)
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
        if (_isLabelVisible) Center(),
      ],
    );
  }
}

class JobCardScreen extends StatefulWidget {
  final int userId;
  final void Function(int, int, String, Task, int, String, String) showLabel;
  final VoidCallback hideLabel;

  const JobCardScreen(
      {super.key,
      required this.showLabel,
      required this.hideLabel,
      required this.userId});

  @override
  State<JobCardScreen> createState() => _JobCardScreenState();
}

class _JobCardScreenState extends State<JobCardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isTS1Loaded = false;
  bool _isTS2Loaded = false;
  bool _isTS3Loaded = false;
  final bool _isTS4Loaded = false;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;
      _loadTasksForTab(_tabController.index);
    });

    // Load initial tasks for the first tab
    _loadTasksForTab(0);
  }

  void _loadTasksForTab(int index) {
    switch (index) {
      case 0:
        if (!_isTS1Loaded) {
          BlocProvider.of<TaskerTaskCubit>(context).getTS1Tasks(widget.userId);
          _isTS1Loaded = !_isTS1Loaded;
        } else {
          break;
        }
      case 1:
        if (!_isTS2Loaded) {
          BlocProvider.of<TaskerTaskCubit>(context).getTS2Tasks(widget.userId);
          _isTS2Loaded = !_isTS2Loaded;
        }
        break;
      case 2:
        if (!_isTS3Loaded) {
          BlocProvider.of<TaskerTaskCubit>(context).getTS3Tasks(widget.userId);
          _isTS3Loaded = !_isTS3Loaded;
        }
        break;
    }
  }

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
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.cam_main,
          labelColor: AppColors.cam_main,
          unselectedLabelColor: Colors.black,
          tabs: const [
            Tab(text: 'Ứng cử'),
            Tab(text: 'Đã nhận'),
            Tab(text: 'Hoàn thành'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          WaitingList(
            showLabel: widget.showLabel,
            userId: widget.userId,
          ),
          ApprovedList(showLabel: widget.showLabel, userId: widget.userId),
          FinishedList(showLabel: widget.showLabel, userId: widget.userId),
        ],
      ),
    );
  }
}

class WaitingList extends StatelessWidget {
  final int userId;
  final void Function(int, int, String, Task, int, String, String) showLabel;

  const WaitingList({super.key, required this.showLabel, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskerTaskCubit, TaskerTaskState>(
      builder: (context, state) {
        if (state is TaskerTaskLoading) {
          return const Center(
            child: Center(
                child: SizedBox(
                    height: 40, width: 40, child: CircularProgressIndicator())),
          );
        } else if (state is TaskerTaskSuccess) {
          if (state.TS1tasks!.isEmpty) {
            return const Center(child: Text('Không có công việc nào'));
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: state.TS1tasks!.length,
                    itemBuilder: (context, index) {
                      var task = state.TS1tasks![index];

                      return TaskerWatingActivityWidget(
                        customerId: task.userId,
                        accountId: userId,
                        avatar:
                            (task.taskType as Map<String, dynamic>)['avatar'] ??
                                '',
                        ungCuVien: task.taskerLists
                                ?.where((tasker) =>
                                    (tasker
                                        as Map<String, dynamic>)['status'] ==
                                    'S1')
                                .length ??
                            0,
                        loading: () async {
                          await BlocProvider.of<TaskerTaskCubit>(context)
                              .getTS1Tasks(userId);
                        },
                        daNhan: task.taskerLists
                                ?.where((tasker) =>
                                    (tasker
                                        as Map<String, dynamic>)['status'] ==
                                    'S2')
                                .length ??
                            0,
                        createAt: task.createdAt,
                        numberOfTasker: task.numberOfTasker ?? 0,
                        id: task.id,
                        startDay: task.time,
                        price: task.price ?? '',
                        note: task.note ?? '',
                        ownerName: (task.location
                                as Map<String, dynamic>?)?['ownerName'] ??
                            '',
                        phone: (task.location as Map<String, dynamic>?)?[
                                'ownerPhoneNumber'] ??
                            '',
                        detailAddress: (task.location
                                as Map<String, dynamic>?)?['detailAddress'] ??
                            '',
                        province: (task.location
                                as Map<String, dynamic>?)?['province'] ??
                            '',
                        district: (task.location
                                as Map<String, dynamic>?)?['district'] ??
                            '',
                        country: (task.location
                                as Map<String, dynamic>?)?['country'] ??
                            '',
                        serviceName:
                            (task.taskType as Map<String, dynamic>?)?['name'] ??
                                '',
                      );
                    }),
              ),
            ],
          );
        } else if (state is TaskerTaskError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const Center(child: Text('No tasks found'));
        }
      },
    );
  }
}

class ApprovedList extends StatelessWidget {
  final int userId;
  final void Function(int, int, String, Task, int, String, String) showLabel;

  const ApprovedList(
      {super.key, required this.showLabel, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskerTaskCubit, TaskerTaskState>(
      builder: (context, state) {
        if (state is TaskerTaskLoading) {
          return const Center(
            child: Center(
                child: SizedBox(
                    height: 40, width: 40, child: CircularProgressIndicator())),
          );
        } else if (state is TaskerTaskSuccess) {
          if (state.TS2tasks!.isEmpty) {
            return const Center(child: Text('Không có công việc nào'));
          }
          return ListView.builder(
              itemCount: state.TS2tasks!.length,
              itemBuilder: (context, index) {
                var task = state.TS2tasks![index];

                return TaskerApproveWidget(
                  customerId: task.userId,
                  accountId: userId,
                  avatar:
                      (task.taskType as Map<String, dynamic>)['avatar'] ?? '',
                  ungCuVien: task.taskerLists
                          ?.where((tasker) =>
                              (tasker as Map<String, dynamic>)['status'] ==
                              'S1')
                          .length ??
                      0,
                  loading: () async {
                    print("vo roi");
                    await BlocProvider.of<TaskerTaskCubit>(context)
                        .getTS2Tasks(userId);
                  },
                  daNhan: task.taskerLists
                          ?.where((tasker) =>
                              (tasker as Map<String, dynamic>)['status'] ==
                              'S2')
                          .length ??
                      0,
                  createAt: task.createdAt,
                  numberOfTasker: task.numberOfTasker ?? 0,
                  id: task.id,
                  startDay: task.time,
                  price: task.price ?? '',
                  note: task.note ?? '',
                  ownerName:
                      (task.location as Map<String, dynamic>?)?['ownerName'] ??
                          '',
                  phone: (task.location
                          as Map<String, dynamic>?)?['ownerPhoneNumber'] ??
                      '',
                  detailAddress: (task.location
                          as Map<String, dynamic>?)?['detailAddress'] ??
                      '',
                  province:
                      (task.location as Map<String, dynamic>?)?['province'] ??
                          '',
                  district:
                      (task.location as Map<String, dynamic>?)?['district'] ??
                          '',
                  country:
                      (task.location as Map<String, dynamic>?)?['country'] ??
                          '',
                  serviceName:
                      (task.taskType as Map<String, dynamic>?)?['name'] ?? '',
                );
              });
        } else if (state is TaskerTaskError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const Center(child: Text('No tasks found'));
        }
      },
    );
  }
}

class FinishedList extends StatelessWidget {
  final int userId;
  final void Function(int, int, String, Task, int, String, String) showLabel;

  const FinishedList(
      {super.key, required this.showLabel, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskerTaskCubit, TaskerTaskState>(
      builder: (context, state) {
        if (state is TaskerTaskLoading) {
          return const Center(
            child: Center(
                child: SizedBox(
                    height: 40, width: 40, child: CircularProgressIndicator())),
          );
        } else if (state is TaskerTaskSuccess) {
          if (state.TS3tasks!.isEmpty) {
            return const Center(child: Text('Không có công việc nào'));
          }

          return ListView.builder(
              itemCount: state.TS3tasks!.length,
              itemBuilder: (context, index) {
                var task = state.TS3tasks![index];

                return TaskerFinishWidget(
                  accountId: userId,
                  customerId: task.userId ?? 0,
                  avatar:
                      (task.taskType as Map<String, dynamic>)['avatar'] ?? '',
                  ungCuVien: task.taskerLists
                          ?.where((tasker) =>
                              (tasker as Map<String, dynamic>)['status'] ==
                              'S1')
                          .length ??
                      0,
                  loading: () async {
                    DefaultTabController.of(context).animateTo(3);

                    // Add a short delay to allow tab animation to complete

                    BlocProvider.of<TaskerTaskCubit>(context)
                        .getTS3Tasks(userId);
                    BlocProvider.of<TaskerTaskCubit>(context)
                        .getTS1Tasks(userId);
                  },
                  daNhan: task.taskerLists
                          ?.where((tasker) =>
                              (tasker as Map<String, dynamic>)['status'] ==
                              'S2')
                          .length ??
                      0,
                  createAt: task.createdAt,
                  numberOfTasker: task.numberOfTasker ?? 0,
                  id: task.id,
                  startDay: task.time,
                  price: task.price ?? '',
                  note: task.note ?? '',
                  ownerName:
                      (task.location as Map<String, dynamic>?)?['ownerName'] ??
                          '',
                  phone: (task.location
                          as Map<String, dynamic>?)?['ownerPhoneNumber'] ??
                      '',
                  detailAddress: (task.location
                          as Map<String, dynamic>?)?['detailAddress'] ??
                      '',
                  province:
                      (task.location as Map<String, dynamic>?)?['province'] ??
                          '',
                  district:
                      (task.location as Map<String, dynamic>?)?['district'] ??
                          '',
                  country:
                      (task.location as Map<String, dynamic>?)?['country'] ??
                          '',
                  serviceName:
                      (task.taskType as Map<String, dynamic>?)?['name'] ?? '',
                );
              });
        } else if (state is TaskerTaskError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const Center(child: Text('No tasks found'));
        }
      },
    );
  }
}
