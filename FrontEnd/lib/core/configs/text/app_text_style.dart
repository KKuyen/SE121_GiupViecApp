import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';

class AppTextStyle {
  static const tieudebox = TextStyle(
      fontFamily: 'Inter',
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black,
      decoration: TextDecoration.none);
  static const textthuong = TextStyle(
      fontFamily: 'Inter',
      fontSize: 16,
      color: Colors.black,
      decoration: TextDecoration.none,
      fontWeight: FontWeight.normal);
  static const textthuongxam = TextStyle(
      fontFamily: 'Inter',
      fontSize: 16,
      color: AppColors.xam72,
      decoration: TextDecoration.none,
      fontWeight: FontWeight.normal);
  static const textthuongxanhmain = TextStyle(
      fontFamily: 'Inter',
      fontSize: 16,
      color: AppColors.xanh_main,
      decoration: TextDecoration.none,
      fontWeight: FontWeight.normal);
}
