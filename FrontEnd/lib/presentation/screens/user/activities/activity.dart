import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se121_giupviec_app/common/helpers/SecureStorage.dart';
import 'package:se121_giupviec_app/common/widgets/task_card/approved_activity_widget.dart';
import 'package:se121_giupviec_app/common/widgets/task_card/cancel_activity_widget.dart';

import 'package:se121_giupviec_app/common/widgets/task_card/waiting_activity_widget.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:se121_giupviec_app/domain/entities/task.dart';
import 'package:se121_giupviec_app/presentation/bloc/task/get_all_task_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/task/get_all_task_state.dart';
import 'package:se121_giupviec_app/presentation/screens/user/activities/newTaskStep1.dart';
import 'package:se121_giupviec_app/presentation/screens/user/activities/taskerList.dart';

class ActivityPage extends StatefulWidget {
  int allUserId;

  ActivityPage({super.key, required this.allUserId});

  @override
  State<ActivityPage> createState() => _ActivityPageState();

  void setState(Null Function() param0) {}
}

class _ActivityPageState extends State<ActivityPage> {
  int userId = 0;
  Future<void> userID() async {
    final id = await SecureStorage().readId();
    print("id nef");
    print(id);
    setState(() {
      userId = int.parse(id);
    });
    _refreshScreen();
  }

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
    await BlocProvider.of<TaskCubit>(context).getTS1Tasks(widget.allUserId);
  }

  Future<void> _reload() async {
    setState(() {
      BlocProvider.of<TaskCubit>(context).getTS1Tasks(widget.allUserId);
      BlocProvider.of<TaskCubit>(context).getTS2Tasks(widget.allUserId);
    });
  }

  @override
  void initState() {
    super.initState();
    userID();
    print('initttttttttttttttttttttt');
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DefaultTabController(
          length: 4,
          child: JobCardScreen(
            showLabel: _showLabel,
            hideLabel: _hideLabel,
            allUserId: widget.allUserId,
          ),
        ),
        if (_isLabelVisible)
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
        if (_isLabelVisible)
          Center(
            child: Taskerlist(
              userId: widget.allUserId,
              task: currentTask,
              taskTypeId: taskTypeId,
              taskTypeAvatar: TaskTypeAvatar,
              taskTypeName: TaskTypeName,
              callBackFun: () => _reload(),
              id: id,
              numberOfTasker: numberOfTasker,
              cancel: _hideLabel,
              taskStatus: taskStatus,
            ),
          ),
      ],
    );
  }
}

class JobCardScreen extends StatefulWidget {
  final int allUserId;
  final void Function(int, int, String, Task, int, String, String) showLabel;
  final VoidCallback hideLabel;

  const JobCardScreen(
      {super.key,
      required this.showLabel,
      required this.hideLabel,
      required this.allUserId});

  @override
  State<JobCardScreen> createState() => _JobCardScreenState();
}

class _JobCardScreenState extends State<JobCardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isTS1Loaded = false;
  bool _isTS2Loaded = false;
  bool _isTS3Loaded = false;
  bool _isTS4Loaded = false;

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
          BlocProvider.of<TaskCubit>(context).getTS1Tasks(widget.allUserId);
          _isTS1Loaded = !_isTS1Loaded;
        } else {
          break;
        }
      case 1:
        if (!_isTS2Loaded) {
          BlocProvider.of<TaskCubit>(context).getTS2Tasks(widget.allUserId);
          _isTS2Loaded = !_isTS2Loaded;
        }
        break;
      case 2:
        if (!_isTS3Loaded) {
          BlocProvider.of<TaskCubit>(context).getTS3Tasks(widget.allUserId);
          _isTS3Loaded = !_isTS3Loaded;
        }
        break;
      case 3:
        if (!_isTS4Loaded) {
          BlocProvider.of<TaskCubit>(context).getTS4Tasks(widget.allUserId);
          _isTS4Loaded = !_isTS4Loaded;
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
          indicatorColor: AppColors.xanh_main,
          labelColor: AppColors.xanh_main,
          unselectedLabelColor: Colors.black,
          tabs: const [
            Tab(text: 'Đang tìm'),
            Tab(text: 'Đã nhận'),
            Tab(text: 'Hoàn thành'),
            Tab(text: 'Đã hủy'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          WaitingList(showLabel: widget.showLabel, allUserId: widget.allUserId),
          ApprovedList(
              showLabel: widget.showLabel, allUserId: widget.allUserId),
          FinishedList(
              showLabel: widget.showLabel, allUserId: widget.allUserId),
          CancelList(showLabel: widget.showLabel, allUserId: widget.allUserId),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Newtaskstep1(
                      userId: widget.allUserId,
                    )),
          );
          if (result == true) {
            BlocProvider.of<TaskCubit>(context).getTS1Tasks(widget.allUserId);
          }
        },
        backgroundColor: AppColors.xanh_main,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class WaitingList extends StatefulWidget {
  final int allUserId;
  final void Function(int, int, String, Task, int, String, String) showLabel;

  const WaitingList(
      {super.key, required this.showLabel, required this.allUserId});

  @override
  State<WaitingList> createState() => _WaitingListState();
}

class _WaitingListState extends State<WaitingList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        if (state is TaskLoading) {
          return const Center(
            child: Center(
                child: SizedBox(
                    height: 40, width: 40, child: CircularProgressIndicator())),
          );
        } else if (state is TaskSuccess) {
          if (state.TS1tasks!.isEmpty) {
            return const Center(child: Text('Không có công việc nào'));
          }
          return Column(
            children: [
              if (state.setting?.autoAcceptStatus == true)
                const Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 5),
                  child: Text(
                    'Tự động duyệt công việc đang bật, điều chỉnh ở cài đặt',
                    style: TextStyle(
                        color: AppColors.xanh_main,
                        fontSize: 15,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              Expanded(
                child: ListView.builder(
                    itemCount: state.TS1tasks!.length,
                    itemBuilder: (context, index) {
                      var task = state.TS1tasks![index];

                      return WatingActivityWidget(
                        userId: widget.allUserId,
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
                          BlocProvider.of<TaskCubit>(context)
                              .getTS1Tasks(widget.allUserId);
                          BlocProvider.of<TaskCubit>(context)
                              .getTS2Tasks(widget.allUserId);
                          BlocProvider.of<TaskCubit>(context)
                              .getTS4Tasks(widget.allUserId);
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
                        onShowLabel: () => widget.showLabel(
                            task.id,
                            task.numberOfTasker ?? 0,
                            task.taskStatus ?? 'TS1',
                            task,
                            task.taskTypeId,
                            (task.taskType as Map<String, dynamic>)['name'],
                            (task.taskType as Map<String, dynamic>)['avatar']),
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
        } else if (state is TaskError) {
          return Center();
        } else {
          return const Center(child: Text('No tasks found'));
        }
      },
    );
  }
}

class ApprovedList extends StatefulWidget {
  final int allUserId;
  final void Function(int, int, String, Task, int, String, String) showLabel;

  const ApprovedList(
      {super.key, required this.showLabel, required this.allUserId});

  @override
  State<ApprovedList> createState() => _ApprovedListState();
}

class _ApprovedListState extends State<ApprovedList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        if (state is TaskLoading) {
          final taskCubit =
              BlocProvider.of<TaskCubit>(context).getAllTasks(widget.allUserId);
          return const Center(
            child: Center(
                child: SizedBox(
                    height: 40, width: 40, child: CircularProgressIndicator())),
          );
        } else if (state is TaskSuccess) {
          if (state.TS2tasks!.isEmpty) {
            return const Center(child: Text('Không có công việc nào'));
          }
          return ListView.builder(
              itemCount: state.TS2tasks!.length,
              itemBuilder: (context, index) {
                var task = state.TS2tasks![index];

                return ApprovedActivityWidget(
                  userId: widget.allUserId,
                  avatar:
                      (task.taskType as Map<String, dynamic>)['avatar'] ?? '',
                  taskTypeId: task.taskTypeId,
                  loading: () => {
                    DefaultTabController.of(context).animateTo(3),
                    BlocProvider.of<TaskCubit>(context)
                        .getTS2Tasks(widget.allUserId),
                    BlocProvider.of<TaskCubit>(context)
                        .getTS3Tasks(widget.allUserId),
                    BlocProvider.of<TaskCubit>(context)
                        .getTS4Tasks(widget.allUserId),
                  },
                  ungCuVien: task.taskerLists
                          ?.where((tasker) =>
                              (tasker as Map<String, dynamic>)['status'] ==
                              'S1')
                          .length ??
                      0,
                  daNhan: task.taskerLists
                          ?.where((tasker) =>
                              (tasker as Map<String, dynamic>)['status'] ==
                              'S2')
                          .length ??
                      0,
                  onShowLabel: () => widget.showLabel(
                      task.id,
                      task.numberOfTasker ?? 0,
                      task.taskStatus ?? 'TS2',
                      task,
                      task.taskTypeId,
                      (task.taskType as Map<String, dynamic>)['name'],
                      (task.taskType as Map<String, dynamic>)['avatar']),
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
          return Center();
        } else {
          return const Center(child: Text('No tasks found'));
        }
      },
    );
  }
}

class FinishedList extends StatefulWidget {
  final int allUserId;
  final void Function(int, int, String, Task, int, String, String) showLabel;

  const FinishedList(
      {super.key, required this.showLabel, required this.allUserId});

  @override
  State<FinishedList> createState() => _FinishedListState();
}

class _FinishedListState extends State<FinishedList> {
  int userId = 0;
  Future<void> userID() async {
    final id = await SecureStorage().readId();
    setState(() {
      userId = int.parse(id);
    });
  }

  @override
  void initState() {
    super.initState();
    userID();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        if (state is TaskLoading) {
          return const Center(
            child: Center(
                child: SizedBox(
                    height: 40, width: 40, child: CircularProgressIndicator())),
          );
        } else if (state is TaskSuccess) {
          if (state.TS3tasks!.isEmpty) {
            return const Center(child: Text('Không có công việc nào'));
          }

          return ListView.builder(
              itemCount: state.TS3tasks!.length,
              itemBuilder: (context, index) {
                var task = state.TS3tasks![index];

                return ApprovedActivityWidget(
                  userId: widget.allUserId,
                  avatar:
                      (task.taskType as Map<String, dynamic>)['avatar'] ?? '',
                  taskTypeId: task.taskTypeId,
                  loading: () => {
                    DefaultTabController.of(context).animateTo(3),
                    BlocProvider.of<TaskCubit>(context).getTS2Tasks(userId),
                    BlocProvider.of<TaskCubit>(context).getTS4Tasks(userId),
                  },
                  isFinished: true,
                  ungCuVien: task.taskerLists
                          ?.where((tasker) =>
                              (tasker as Map<String, dynamic>)['status'] ==
                              'S1')
                          .length ??
                      0,
                  daNhan: task.taskerLists
                          ?.where((tasker) =>
                              (tasker as Map<String, dynamic>)['status'] ==
                              'S5')
                          .length ??
                      0,
                  onShowLabel: () => widget.showLabel(
                      task.id,
                      task.numberOfTasker ?? 0,
                      task.taskStatus ?? 'TS2',
                      task,
                      task.taskTypeId,
                      (task.taskType as Map<String, dynamic>)['name'],
                      (task.taskType as Map<String, dynamic>)['avatar']),
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
          return Center();
        } else {
          return const Center(child: Text('No tasks found'));
        }
      },
    );
  }
}

class CancelList extends StatelessWidget {
  final int allUserId;
  final void Function(int, int, String, Task, int, String, String) showLabel;

  const CancelList(
      {super.key, required this.showLabel, required this.allUserId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        if (state is TaskLoading) {
          return const Center(
            child: Center(
                child: SizedBox(
                    height: 40, width: 40, child: CircularProgressIndicator())),
          );
        } else if (state is TaskSuccess) {
          if (state.TS4tasks!.isEmpty) {
            return const Center(child: Text('Không có công việc nào'));
          }
          return ListView.builder(
              itemCount: state.TS4tasks!.length,
              itemBuilder: (context, index) {
                var task = state.TS4tasks![index];
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

                return CancelActivityWidget(
                  userId: allUserId,
                  avatar:
                      (task.taskType as Map<String, dynamic>)['avatar'] ?? '',
                  taskStatus: task.taskStatus ?? '',
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
          return Center();
        } else {
          return const Center(child: Text('No tasks found'));
        }
      },
    );
  }
}
