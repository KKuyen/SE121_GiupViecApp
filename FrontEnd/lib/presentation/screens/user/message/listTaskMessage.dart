import 'package:flutter/material.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/common/widgets/message/jobCard.dart';
import 'package:se121_giupviec_app/core/configs/assets/app_vectors.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_info.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';

class ListTaskMessage extends StatefulWidget {
  const ListTaskMessage({super.key});

  @override
  State<ListTaskMessage> createState() => _ListTaskMessageState();
}

class _ListTaskMessageState extends State<ListTaskMessage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Danh sách công việc',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
          leading: IconButton(
            icon: Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.05),
                  shape: BoxShape.circle),
              child: const Icon(
                Icons.arrow_back_ios_new,
                size: 16,
                color: Colors.black,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          bottom: const TabBar(
            indicatorColor: AppColors.xanh_main,
            labelColor: AppColors.xanh_main,
            tabs: <Widget>[
              Tab(
                text: "Ứng cử",
              ),
              Tab(
                text: "Đã nhận",
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            Center(
              child: UngCuTab(),
            ),
            Center(
              child: DaNhanTab(),
            )
          ],
        ),
      ),
    );
  }
}

class DaNhanTab extends StatelessWidget {
  const DaNhanTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          _time(time: "9:00 21/4/2024"),
          JobCard(avatar: AppVectors.facebook, isMe: false, isCenter: true),
          JobCard(avatar: AppVectors.facebook, isMe: false, isCenter: true),
          JobCard(avatar: AppVectors.facebook, isMe: false, isCenter: true),
          _time(time: "9:00 21/4/2024"),
          JobCard(avatar: AppVectors.facebook, isMe: false, isCenter: true),
        ],
      ),
    );
  }
}

class UngCuTab extends StatelessWidget {
  const UngCuTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          _time(time: "9:00 21/4/2024"),
          JobCard(avatar: AppVectors.facebook, isMe: false, isCenter: true),
          JobCard(avatar: AppVectors.facebook, isMe: false, isCenter: true),
          JobCard(avatar: AppVectors.facebook, isMe: false, isCenter: true),
          _time(time: "9:00 21/4/2024"),
          JobCard(avatar: AppVectors.facebook, isMe: false, isCenter: true),
        ],
      ),
    );
  }
}

class _time extends StatelessWidget {
  final String time;
  const _time({
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        time,
        style: const TextStyle(
          color: AppColors.xam72,
          fontSize: 12,
        ),
      ),
    );
  }
}
