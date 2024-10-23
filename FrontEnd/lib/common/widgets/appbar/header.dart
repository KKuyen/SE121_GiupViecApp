import 'package:flutter/material.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_infor1.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';

class Header extends StatefulWidget {
  final String text1;
  final String text2;
  final Icon icon;
  final Color color;

  const Header({
    super.key,
    required this.text1,
    required this.text2,
    required this.icon,
    this.color = AppColors.xanh_main,
  });

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: widget.color),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: 22, horizontal: AppInfor1.horizontal_padding),
          child: Row(
            children: [
              // Sử dụng Expanded để văn bản chiếm hết không gian có thể
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.text1,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter',
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 5), // Khoảng cách giữa các đoạn text
                    Text(
                      widget.text2,
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'Inter',
                        color: Colors.white,
                        // Màu chữ nhạt hơn cho phần mô tả
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20), // Khoảng cách giữa văn bản và icon
              // Ic
              widget.icon,
            ],
          ),
        ));
  }
}
