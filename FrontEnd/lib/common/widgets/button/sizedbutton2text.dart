import 'package:flutter/material.dart';
import 'package:se121_giupviec_app/core/configs/assets/app_vectors.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';

class Sizedbutton2 extends StatefulWidget {
  final VoidCallback onPressFun;
  final String text1;
  final String text2;
  final double width;
  final double height;
  final Color backgroundColor;
  final Color textColor;
  final bool isStroke;
  final Color StrokeColor;
  final bool isEnabled;

  const Sizedbutton2({
    required this.onPressFun,
    super.key,
    this.isEnabled = true,
    this.text1 = 'Nội dung1',
    this.text2 = 'Nội dung2', // Default text
    this.width = 130.0, // Default width
    this.height = 50.0, // Default height
    this.backgroundColor = AppColors.xanh_main, // Default color
    this.textColor = Colors.white, // Default textColor
    this.isStroke = false, // Default isStroke
    this.StrokeColor = Colors.white, // Default StrokeColor
  });

  @override
  State<Sizedbutton2> createState() => _SizedbuttonState2();
}

class _SizedbuttonState2 extends State<Sizedbutton2> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.isEnabled ? widget.onPressFun : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.isEnabled
            ? widget.backgroundColor
            : const Color.fromARGB(255, 48, 46, 46), // Background color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          // Rounded corners
          side: widget.isStroke
              ? BorderSide(color: widget.StrokeColor)
              : BorderSide.none, // Border
        ),
        minimumSize: Size(widget.width, widget.height), // Size of the button
      ),
      child: Row(
        children: [
          Text(
            widget.text1,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.bold,
              color: widget.textColor,
              // Text color
            ),
          ),
          Spacer(),
          Text(
            widget.text2,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.normal,
              color: widget.textColor,
              // Text color
            ),
          ),
        ],
      ),
    );
  }
}
