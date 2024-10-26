import 'package:flutter/material.dart';
import 'package:se121_giupviec_app/common/widgets/task_card/approved_activity_widget.dart';
import 'package:se121_giupviec_app/common/widgets/task_card/cancel_activity_widget.dart';
import 'package:se121_giupviec_app/common/widgets/task_card/finished_activity_widget.dart';
import 'package:se121_giupviec_app/common/widgets/task_card/tasker_approve_widget.dart';
import 'package:se121_giupviec_app/common/widgets/task_card/tasker_waiting_activity_widget.dart';
import 'package:se121_giupviec_app/common/widgets/task_card/waiting_activity_widget.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:se121_giupviec_app/presentation/screens/user/activities/taskerList.dart';
import 'package:se121_giupviec_app/presentation/screens/user/activities/newTaskStep1.dart';

import 'package:se121_giupviec_app/presentation/screens/user/activities/waitingTab.dart';

class TaskerActivityPage extends StatefulWidget {
  const TaskerActivityPage({super.key});

  @override
  State<TaskerActivityPage> createState() => _TaskerActivityPageState();
}

class _TaskerActivityPageState extends State<TaskerActivityPage> {
  bool _isLabelVisible = false;

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
              cancel: _hideLabel,
            ),
          ),
      ],
    );
  }
}

class JobCardScreen extends StatelessWidget {
  final VoidCallback showLabel;
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
          'Công việc ',
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
            Tab(text: 'Ứng cử '),
            Tab(text: 'Đã nhận'),
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
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Newtaskstep1()),
          );
        },
        backgroundColor: AppColors.cam_main,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
        shape: const CircleBorder(),
      ),
    );
  }
}

class WaitingList extends StatelessWidget {
  final VoidCallback showLabel;

  const WaitingList({required this.showLabel});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return TaskerWatingActivityWidget(onShowLabel: showLabel);
      },
    );
  }
}

class ApprovedList extends StatelessWidget {
  final VoidCallback showLabel;

  const ApprovedList({required this.showLabel});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return TaskerApproveWidget(onShowLabel: showLabel);
      },
    );
  }
}
