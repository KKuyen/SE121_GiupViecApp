import 'package:flutter/material.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';

class CTextfield extends StatefulWidget {
  final String? hintText;

  const CTextfield({super.key, this.hintText = ""});

  @override
  State<CTextfield> createState() => _TextfieldState();
}

class _TextfieldState extends State<CTextfield> {
  @override
  Widget build(BuildContext context) {
    return TextField(
        maxLength: 200,
        cursorColor: AppColors.xanh_main,
        maxLines: 5,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: const TextStyle(
              color: AppColors.xam72, fontWeight: FontWeight.normal),
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.xanh_main),
          ),
          labelStyle: const TextStyle(color: Colors.black),
          floatingLabelStyle: const TextStyle(color: AppColors.xanh_main),
        ));
  }
}
