import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/header.dart';
import 'package:se121_giupviec_app/common/widgets/button/2sttbutton.dart';
import 'package:se121_giupviec_app/common/widgets/tasker_row/taskerRowAbutton.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_infor1.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';

class Lovetaskers extends StatefulWidget {
  const Lovetaskers({super.key});

  @override
  State<Lovetaskers> createState() => _LovetaskersState();
}

class _LovetaskersState extends State<Lovetaskers> {
  bool isLove = false;
  void toggleLove() {
    setState(() {
      isLove = !isLove;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.nen_the,
      appBar: const BasicAppbar(
        title: Text(
          'Tasker yêu thích',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        isHideBackButton: false,
        isHavePadding: true,
        color: Colors.white,
      ),
      body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Header(
          text1: "Bạn đã yêu thích 2 tasker",
          text2:
              "Những tasker bạn yêu thích có thể được ưu tiên tự động nhận việc làm",
          icon: Icon(
            FontAwesomeIcons.solidHeart,
            color: Colors.white,
            size: 47,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppInfor1.horizontal_padding),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 2, // Replace with the actual number of taskers
            itemBuilder: (context, index) {
              // tamm thoi comment
              // return Taskerrowabutton(
              //     iconButton: const TwoSttButton(
              //   sttkey: true,
              //   icon: Icon(
              //     FontAwesomeIcons.solidHeart,
              //     color: AppColors.xanh_main,
              //     size: 32,
              //   ),
              //   icon2: Icon(
              //     FontAwesomeIcons.heart,
              //     color: AppColors.xam72,
              //     size: 32,
              //   ),
              // ));
            },
          ),
        )
      ])),
    );
  }
}
