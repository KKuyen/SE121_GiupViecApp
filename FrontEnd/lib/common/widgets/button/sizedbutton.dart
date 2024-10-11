import 'package:flutter/material.dart';
import 'package:se121_giupviec_app/core/configs/assets/app_vectors.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';

class Sizedbutton extends StatefulWidget {
  final String text;
  final double width;

  const Sizedbutton({super.key, required this.text, required this.width});

  @override
  State<Sizedbutton> createState() => _SizedbuttonState();
}

class _SizedbuttonState extends State<Sizedbutton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Define what happens when the button is pressed
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: AppColors.xanh_main, // Text color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50), // Rounded corners
        ),
        minimumSize: Size(widget.width, 50), // Size of the button
      ),
      child: Text(
        widget.text,
        style: TextStyle(
          fontSize: 15,
          fontFamily: 'Inter',
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
