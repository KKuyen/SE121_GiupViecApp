// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:se121_giupviec_app/common/widgets/tasker_row/taskerRowAccept.dart';
import 'package:se121_giupviec_app/common/widgets/tasker_row/taskerRowDelete.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:se121_giupviec_app/presentation/user/activities/taskerProfile.dart';

class Taskerlist extends StatefulWidget {
  final VoidCallback cancel;

  const Taskerlist({super.key, required this.cancel});

  @override
  State<Taskerlist> createState() => _TaskerListState();
}

class _TaskerListState extends State<Taskerlist> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(40),
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
                        fontSize: 22,
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
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Text(
                    'Danh sách đã xác nhận',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.xam72,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  Spacer(),
                  Text(
                    '2/4 vị trí',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.xanh_main,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                ],
              ),
              SizedBox(height: 15),
              ListView.builder(
                shrinkWrap: true,
                itemCount:
                    4, // Replace with the actual number of taskerRowAccept items
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Taskerprofile()),
                      );
                      // Do something
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 5, 12, 0),
                      child: Column(
                        children: [Taskerrowdelete(), Divider()],
                      ),
                    ),
                  ); // Replace with your actual TaskerRowAccept widget
                },
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Text(
                    'Danh sách ứng cử viên',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.xam72,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              ListView.builder(
                shrinkWrap: true,
                itemCount:
                    4, // Replace with the actual number of taskerRowAccept items
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Taskerprofile()),
                      );
                      // Do something
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 5, 12, 0),
                      child: Column(
                        children: [Taskerrowaccept(), Divider()],
                      ),
                    ),
                  ); // Replace with your actual TaskerRowAccept widget
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
