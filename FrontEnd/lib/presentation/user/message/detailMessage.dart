import 'package:flutter/material.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/core/configs/assets/app_vectors.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_info.dart';
import 'package:se121_giupviec_app/presentation/user/message/listTaskMessage.dart';

class Detailmessage extends StatefulWidget {
  const Detailmessage({super.key});

  @override
  State<Detailmessage> createState() => _DetailmessageState();
}

class _DetailmessageState extends State<Detailmessage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
          isHideBackButton: false,
          action: Row(
            children: [
              const Icon(
                Icons.phone,
                size: 30,
              ),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ListTaskMessage()));
                },
                child: const Icon(
                  Icons.more_horiz_rounded,
                  size: 30,
                ),
              ),
            ],
          ),
          isHavePadding: false,
          title: const Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(AppVectors.avatar),
              ),
              SizedBox(
                width: 10,
              ),
              Text('Nguyễn Văn A',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          )),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: AppInfo.main_padding),
        child: SingleChildScrollView(
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
