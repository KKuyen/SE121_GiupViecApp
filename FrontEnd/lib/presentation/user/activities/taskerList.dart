import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';

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
                height: 10,
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
              SizedBox(
                height: 15,
              ),
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
            ],
          ),
        ),
      ),
    );
  }
}
