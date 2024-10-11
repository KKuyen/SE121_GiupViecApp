import 'package:flutter/material.dart';
import 'package:se121_giupviec_app/common/widgets/task_card/approved_activity_widget.dart';
import 'package:se121_giupviec_app/common/widgets/task_card/cancel_activity_widget.dart';
import 'package:se121_giupviec_app/common/widgets/task_card/finished_activity_widget.dart';
import 'package:se121_giupviec_app/common/widgets/task_card/waiting_activity_widget.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:se121_giupviec_app/presentation/user/activities/taskerList.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
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
    return MaterialApp(
      title: 'Job Card Demo',
      theme: ThemeData(
        primaryColor: AppColors.xanh_main,
        tabBarTheme: TabBarTheme(
          splashFactory: NoSplash.splashFactory,
          labelColor: AppColors.xanh_main,
          unselectedLabelColor: const Color.fromARGB(179, 0, 0, 0),
          indicator: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: AppColors.xanh_main,
                width: 3.0,
              ),
            ),
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
        ),
      ),
      home: Stack(
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
      ),
      debugShowCheckedModeBanner: false,
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
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Hoạt động',
          style: TextStyle(
            color: Colors.black,
            fontSize: 26,
            fontFamily: 'Inter',
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: TabBar(
          tabs: [
            Tab(text: 'Đang tìm'),
            Tab(text: 'Đã nhận'),
            Tab(text: 'Đã hoàn thành'),
            Tab(text: 'Đã hủy'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          WaitingList(showLabel: showLabel),
          ApprovedList(showLabel: showLabel),
          FinishedList(showLabel: showLabel),
          CancelList(showLabel: showLabel),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.xanh_main,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
        shape: CircleBorder(),
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
        return WatingActivityWidget(onShowLabel: showLabel);
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
        return ApprovedActivityWidget();
      },
    );
  }
}

class FinishedList extends StatelessWidget {
  final VoidCallback showLabel;

  const FinishedList({required this.showLabel});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return FinishedActivityWidget();
      },
    );
  }
}

class CancelList extends StatelessWidget {
  final VoidCallback showLabel;

  const CancelList({required this.showLabel});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return CancelActivityWidget();
      },
    );
  }
}
