import 'package:flutter/material.dart';
import 'package:se121_giupviec_app/core/configs/assets/app_vectors.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';

class Sizedbutton extends StatefulWidget {
  final VoidCallback onPressFun;
  final String text;
  final double width;
  final double height;
  final Color backgroundColor;
  final Color textColor;
  final bool isStroke;
  final Color StrokeColor;

  const Sizedbutton({
    required this.onPressFun,
    super.key,
    this.text = 'Nội dung', // Default text
    this.width = 130.0, // Default width
    this.height = 50.0, // Default height
    this.backgroundColor = AppColors.xanh_main, // Default color
    this.textColor = Colors.white, // Default textColor
    this.isStroke = false, // Default isStroke
    this.StrokeColor = Colors.white, // Default StrokeColor
  });

  @override
  State<Sizedbutton> createState() => _SizedbuttonState();
}

class _SizedbuttonState extends State<Sizedbutton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        widget.onPressFun();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.backgroundColor, // Background color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50), // Rounded corners
          side: widget.isStroke
              ? BorderSide(color: widget.StrokeColor)
              : BorderSide.none, // Border
        ),
        minimumSize: Size(widget.width, widget.height), // Size of the button
      ),
      child: Text(
        widget.text,
        style: TextStyle(
          fontSize: 17,
          fontFamily: 'Inter',
          fontWeight: FontWeight.normal,
          color: widget.textColor,
          // Text color
        ),
      ),
    );
  }
}
