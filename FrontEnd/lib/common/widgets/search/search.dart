import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_info.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';

class Search extends StatelessWidget {
  final String hint;
  const Search({
    this.hint = 'Tìm kiếm dịch vụ',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          hintText: hint,
          prefixIcon: const Icon(
            CupertinoIcons.search,
            color: AppColors.xanh_main,
            size: 27,
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          )),
    );
  }
}
