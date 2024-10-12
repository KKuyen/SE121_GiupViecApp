import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/common/widgets/search/search.dart';
import 'package:se121_giupviec_app/common/widgets/voucher/voucherCard.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_info.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';

class MyVoucherPage extends StatefulWidget {
  const MyVoucherPage({super.key});

  @override
  State<MyVoucherPage> createState() => _MyVoucherPageState();
}

class _MyVoucherPageState extends State<MyVoucherPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: BasicAppbar(
          title: Text('Ưu đãi của tôi',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
        ),
        body: Padding(
          padding: EdgeInsets.only(
            left: AppInfo.main_padding,
            right: AppInfo.main_padding,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: Search(
                    hint: "Tìm kiếm ưu đãi",
                  )),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.filter_alt_rounded,
                    color: AppColors.xanh_main,
                    size: 35,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ));
  }
}
