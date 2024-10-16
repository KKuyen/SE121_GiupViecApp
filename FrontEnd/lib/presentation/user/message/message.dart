import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/common/widgets/search/search.dart';
import 'package:se121_giupviec_app/core/configs/assets/app_images.dart';
import 'package:se121_giupviec_app/core/configs/assets/app_vectors.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_info.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:se121_giupviec_app/data/models/User.dart';
import 'package:se121_giupviec_app/presentation/user/message/detailMessage.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      appBar: BasicAppbar(
        isHideBackButton: true,
        action: Icon(
          Icons.more_horiz_rounded,
          size: 30,
        ),
        isHavePadding: false,
        title: Text('Tin nhắn',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppInfo.main_padding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              Search(
                hint: "Tìm kiếm tin nhắn",
              ),
              SizedBox(
                height: 15,
              ),
              _listMessage()
            ],
          ),
        ),
      ),
    );
  }
}

class _listMessage extends StatelessWidget {
  const _listMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _messageCard(
          avatar: AppVectors.google,
          name: 'Lê Thị Osin',
          message: 'Mình chia tay đi',
          time: '12:00',
          isSeen: false,
        ),
        _messageCard(
          avatar: AppVectors.facebook,
          name: 'Lê Thị Osin',
          message: 'Mình chia tay đi',
          time: '12:00',
          isSeen: true,
        ),
        _messageCard(
          avatar: AppVectors.facebook,
          name: 'Lê Thị Osin',
          message: 'Mình chia tay đi',
          time: '12:00',
          isSeen: true,
        ),
        _messageCard(
          avatar: AppVectors.google,
          name: 'Lê Thị Osin',
          message: 'Mình chia tay đi',
          time: '12:00',
          isSeen: false,
        ),
        _messageCard(
          avatar: AppVectors.facebook,
          name: 'Lê Thị Osin',
          message: 'Mình chia tay đi',
          time: '12:00',
          isSeen: true,
        ),
        _messageCard(
          avatar: AppVectors.google,
          name: 'Lê Thị Osin',
          message: 'Mình chia tay đi',
          time: '12:00',
          isSeen: false,
        ),
        _messageCard(
          avatar: AppVectors.facebook,
          name: 'Lê Thị Osin',
          message: 'Mình chia tay đi',
          time: '12:00',
          isSeen: true,
        ),
        _messageCard(
          avatar: AppVectors.google,
          name: 'Lê Thị Osin',
          message: 'Mình chia tay đi',
          time: '12:00',
          isSeen: false,
        ),
        _messageCard(
          avatar: AppVectors.google,
          name: 'Lê Thị Osin',
          message: 'Mình chia tay đi',
          time: '12:00',
          isSeen: true,
        ),
      ],
    );
  }
}

class _messageCard extends StatelessWidget {
  final String avatar;
  final String name;
  final String message;
  final String time;
  final bool isSeen;
  const _messageCard({
    this.avatar = AppVectors.facebook,
    this.name = 'Lê Thị Osin',
    this.message = 'Mình chia tay đi',
    this.time = '12:00',
    this.isSeen = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        User user = User(id: 1, name: name, avatar: avatar);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Detailmessage(user: user)));
      },
      child: ListTile(
        contentPadding: EdgeInsets.zero, // Loại bỏ padding mặc định

        leading: SvgPicture.asset(
          avatar,
          width: 41,
          height: 41,
        ),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          children: [
            Text(
              message,
              style: TextStyle(
                  color: isSeen ? Colors.grey : Colors.black,
                  fontWeight: isSeen ? FontWeight.normal : FontWeight.bold),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(time,
                style: TextStyle(
                    color: isSeen ? Colors.grey : Colors.black,
                    fontWeight: isSeen ? FontWeight.normal : FontWeight.bold)),
          ],
        ),
        trailing: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: isSeen ? Colors.transparent : AppColors.cam_main,
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
    );
  }
}
