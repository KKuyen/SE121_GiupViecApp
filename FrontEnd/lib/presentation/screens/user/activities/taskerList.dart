// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';

import 'package:se121_giupviec_app/common/widgets/button/sizedbutton.dart';
import 'package:se121_giupviec_app/common/widgets/tasker_row/taskerRowAccept.dart';
import 'package:se121_giupviec_app/common/widgets/tasker_row/taskerRowDelete.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:se121_giupviec_app/presentation/screens/user/activities/taskerProfile.dart';

class Taskerlist extends StatefulWidget {
  final VoidCallback cancel;
  final int id;

  const Taskerlist({this.id = 1, super.key, required this.cancel});

  @override
  State<Taskerlist> createState() => _TaskerListState();
}

class _TaskerListState extends State<Taskerlist> {
  @override
  Widget build(BuildContext context) {
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
                    '2/4 vị trí',
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
                height: min(
                    200,
                    MediaQuery.of(context).size.height *
                        0.3), // Giới hạn chiều cao
                child: ListView.builder(
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
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5, 5, 12, 0),
                        child: Column(
                          children: [Taskerrowaccept(), Divider()],
                        ),
                      ),
                    );
                  },
                ),
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
  }
}
