import 'package:flutter/material.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/header.dart';
import 'package:se121_giupviec_app/common/widgets/button/2sttbutton.dart';
import 'package:se121_giupviec_app/common/widgets/tasker_row/taskerRowAbutton.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_infor1.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';

class Blocktaskers extends StatefulWidget {
  const Blocktaskers({super.key});

  @override
  State<Blocktaskers> createState() => _blocktaskersState();
}

class _blocktaskersState extends State<Blocktaskers> {
  bool isBlock = false;
  void toggleLove() {
    setState(() {
      isBlock = !isBlock;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.nen_the,
      appBar: const BasicAppbar(
        title: Text(
          'Danh sách chặn',
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
          color: AppColors.do_main,
          text1: "Bạn đã chặn 2 tasker",
          text2: "Những tasker bị hạn chế không thể ứng cử công việc của bạn",
          icon: Icon(
            Icons.block,
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
              // ignore: prefer_const_constructors
              return Taskerrowabutton(
                  iconButton: const TwoSttButton(
                sttkey: true,
                icon: Icon(
                  Icons.block,
                  color: AppColors.do_main,
                  size: 33,
                ),
                icon2: Icon(
                  Icons.block,
                  color: AppColors.xam72,
                  size: 33,
                ),
              ));
            },
          ),
        )
      ])),
    );
  }
}
