import 'package:flutter/material.dart';
import 'package:se121_giupviec_app/core/configs/text/app_text_style.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';

class MiniTtCardWidget extends StatefulWidget {
  final String taskType;
  const MiniTtCardWidget({this.taskType = 'taskType', super.key});

  @override
  State<MiniTtCardWidget> createState() => _MiniTtCardWidgetState();
}

class _MiniTtCardWidgetState extends State<MiniTtCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.xanh_main,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Text(
          widget.taskType,
          style: AppTextStyle.textthuongxanhmain,
        ),
      ),
    );
  }
}
