import 'package:flutter/material.dart';
import 'package:se121_giupviec_app/core/configs/text/app_text_style.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';

class Addprice extends StatefulWidget {
  final String name;
  final String description;
  final String unit;
  final int stepValue;
  final int beginValue;
  final int stepPrice;

  const Addprice({
    super.key,
    this.description = 'Đây là mô tả',
    this.name = 'Trông trẻ',
    this.unit = 'cháu',
    this.stepValue = 1,
    this.beginValue = 0,
    this.stepPrice = 100000,
  });

  @override
  State<Addprice> createState() => _AddpriceState();
}

class _AddpriceState extends State<Addprice> {
  int sang = 1;
  void _Select(int x) {
    setState(() {
      sang = x;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.name,
            style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.xanh_main,
                decoration: TextDecoration.none)),
        Text(widget.description,
            style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: AppColors.xam72,
                decoration: TextDecoration.none)),
        SizedBox(height: 10),
        Row(
          children: [
            GestureDetector(
              onTap: () => _Select(1),
              child: container(
                sang: sang,
                doiso: 1,
                unit: widget.unit,
                stepValue: widget.stepValue,
                beginValue: widget.beginValue,
                stepPrice: 100000,
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () => _Select(2),
              child: container(
                sang: sang,
                doiso: 2,
                unit: widget.unit,
                stepValue: widget.stepValue,
                beginValue: widget.beginValue,
                stepPrice: 100000,
              ),
            )
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            GestureDetector(
              onTap: () => _Select(3),
              child: container(
                sang: sang,
                doiso: 3,
                unit: widget.unit,
                stepValue: widget.stepValue,
                beginValue: widget.beginValue,
                stepPrice: 100000,
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () => _Select(4),
              child: container(
                sang: sang,
                doiso: 4,
                unit: widget.unit,
                stepValue: widget.stepValue,
                beginValue: widget.beginValue,
                stepPrice: 100000,
              ),
            )
          ],
        )
      ],
    );
  }
}

class container extends StatelessWidget {
  const container({
    super.key,
    required this.sang,
    required this.doiso,
    required this.unit,
    required this.stepValue,
    required this.beginValue,
    required this.stepPrice,
  });

  final int sang;
  final int doiso;
  final String unit;
  final int stepValue;
  final int beginValue;
  final int stepPrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              (beginValue + (doiso) * stepValue).toString() + ' ' + unit,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: sang == doiso ? AppColors.xanh_main : AppColors.xam72,
                decoration: TextDecoration.none,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              '+ ' + ((doiso - 1) * stepPrice).toString() + ' ' + ' đ',
            ),
          ],
        ),
      ),
      height: 75,
      width: MediaQuery.of(context).size.width / 2 - 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: sang == doiso ? AppColors.xanh_main : AppColors.xam72,
          width: sang == doiso ? 2 : 1,
        ),
      ),
    );
  }
}