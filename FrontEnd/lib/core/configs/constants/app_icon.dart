import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';

class AppIcon {
  static Icon getIconXanhMain(String iconName) {
    switch (iconName) {
      case 'broom':
        return const Icon(FontAwesomeIcons.broom, color: AppColors.xanh_main);
      case 'cutlery':
        return const Icon(FontAwesomeIcons.cutlery, color: AppColors.xanh_main);
      case 'dry_cleaning_rounded':
        return const Icon(Icons.dry_cleaning_rounded,
            color: AppColors.xanh_main);
      case 'bagShopping':
        return const Icon(FontAwesomeIcons.shoppingBag,
            color: AppColors.xanh_main);
      case 'local_florist_rounded':
        return const Icon(Icons.local_florist_rounded,
            color: AppColors.xanh_main);
      default:
        return const Icon(Icons.task, color: AppColors.xanh_main);
    }
  }

  static String? getImageUrl(String? avatar) {
    if (avatar == null || avatar.isEmpty) return null;
    final supabaseUrl = "https://wbekftdbbgbvuybtvjoi.supabase.co";
    final publicUrl = "$supabaseUrl/storage/v1/object/public/images/$avatar";
    return publicUrl;
  }

  static Icon getIconCamMain(String iconName) {
    switch (iconName) {
      case 'broom':
        return const Icon(FontAwesomeIcons.broom, color: AppColors.cam_main);
      case 'cutlery':
        return const Icon(FontAwesomeIcons.cutlery, color: AppColors.cam_main);
      case 'dry_cleaning_rounded':
        return const Icon(Icons.dry_cleaning_rounded,
            color: AppColors.cam_main);
      case 'bagShopping':
        return const Icon(FontAwesomeIcons.shoppingBag,
            color: AppColors.cam_main);
      case 'local_florist_rounded':
        return const Icon(Icons.local_florist_rounded,
            color: AppColors.cam_main);
      default:
        return const Icon(Icons.error);
    }
  }
}
