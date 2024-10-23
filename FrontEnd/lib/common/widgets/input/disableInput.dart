import 'package:flutter/material.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';

class DisableInput extends StatelessWidget {
  final String text;
  final String hintext;
  final Color color;
  final bool enabled; // Thêm thuộc tính enabled

  const DisableInput({
    this.text = 'Noi dung',
    this.hintext = 'Nhập thông tin',
    this.color = AppColors.xam72,
    this.enabled = false, // Mặc định là không cho phép chỉnh sửa
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        cursorColor: AppColors.xanh_main,

        enabled: enabled, // Sử dụng biến enabled để điều khiển
        style: TextStyle(
          color: color,
          fontFamily: 'Inter',
          fontSize: 15,
        ),
        controller: TextEditingController(text: text), // Nội dung mặc định
        maxLines: null, // Cho phép nhiều dòng
        keyboardType: TextInputType.multiline, // Hỗ trợ nhiều dòng
        decoration: InputDecoration(
          hintText: hintext, // Hiển thị khi không có nội dung
          hintStyle: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 15,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: !enabled
                ? BorderSide.none
                : const BorderSide(
                    color: AppColors
                        .xam_vien), // Nếu enabled = false thì không có đường viền
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: AppColors.xanh_main, // Màu viền khi TextField được focus
            ),
          ),
          filled: true,
          fillColor: Colors.white, // Nền trắng
        ),
      ),
    );
  }
}
