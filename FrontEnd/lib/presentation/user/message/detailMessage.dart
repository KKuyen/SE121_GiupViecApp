import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/common/widgets/button/sizedbutton.dart';
import 'package:se121_giupviec_app/common/widgets/message/jobCard.dart';
import 'package:se121_giupviec_app/core/configs/assets/app_vectors.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_info.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:se121_giupviec_app/data/models/User.dart';
import 'package:se121_giupviec_app/presentation/user/message/listTaskMessage.dart';

class Detailmessage extends StatefulWidget {
  final User user;
  const Detailmessage({required this.user, super.key});

  @override
  State<Detailmessage> createState() => _DetailmessageState();
}

class _DetailmessageState extends State<Detailmessage> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _openCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // Xử lý ảnh đã chụp
      print('Image path: ${image.path}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: BasicAppbar(
          color: const Color.fromARGB(255, 255, 255, 255),
          isHideBackButton: false,
          action: Row(
            children: [
              const Icon(
                Icons.phone,
                size: 27,
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
                  size: 27,
                ),
              ),
            ],
          ),
          isHavePadding: false,
          title: Row(
            children: [
              SvgPicture.asset(
                widget.user.avatar,
                width: 35,
                height: 35,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(widget.user.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          )),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: AppInfo.main_padding,
          right: AppInfo.main_padding,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.image_rounded,
                  size: 34,
                  color: AppColors.xanh_main,
                ),
                onPressed: () {
                  print("Không chọn ảnh");

                  _openCamera();
                },
              ),
              Expanded(
                flex: 1,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Nhập tin nhắn...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.send,
                  color: AppColors.xanh_main,
                  size: 32,
                ),
                onPressed: () {
                  // Xử lý gửi tin nhắn ở đây
                },
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppInfo.main_padding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              const _time(time: "10:00 14/10/2024"),
              _messageCard(
                avatar: widget.user.avatar,
                isMe: true,
                message: 'Chào bạn, bạn cần giúp gì?',
              ),
              JobCard(
                avatar: widget.user.avatar,
                isMe: false,
              ),
              _messageCard(
                avatar: widget.user.avatar,
                isMe: false,
                message: 'Chào bạn, bạn cần giúp gì?',
              ),
              _messageCard(
                avatar: widget.user.avatar,
                isMe: true,
                message: 'Chào bạn, bạn cần giúp gì?',
              ),
              _messageCard(
                avatar: widget.user.avatar,
                isMe: true,
                message: 'Chào bạn, bạn cần giúp gì?',
              ),
              const _time(time: "11:05 14/10/2024"),
              _messageCard(
                avatar: widget.user.avatar,
                isMe: false,
                message: 'Chào bạn, bạn cần giúp gì?',
              ),
              _messageCard(
                avatar: widget.user.avatar,
                isMe: false,
                message: 'Chào bạn, bạn cần giúp gì?',
              ),
              _messageCard(
                avatar: widget.user.avatar,
                isMe: true,
                message: 'Chào bạn, bạn cần giúp gì?',
              ),
              _messageCard(
                avatar: widget.user.avatar,
                isMe: true,
                message: 'Chào bạn, bạn cần giúp gì?',
              ),
              const _time(time: "11:05 14/10/2024"),
              _messageCard(
                avatar: widget.user.avatar,
                isMe: false,
                message: 'Chào bạn, bạn cần giúp gì?',
              ),
              _messageCard(
                avatar: widget.user.avatar,
                isMe: false,
                message: 'Chào bạn, bạn cần giúp gì?',
              ),
              _messageCard(
                avatar: widget.user.avatar,
                isMe: true,
                message: 'Chào bạn, bạn cần giúp gì?',
              ),
              _messageCard(
                avatar: widget.user.avatar,
                isMe: true,
                message: 'Chào bạn, bạn cần giúp gì?',
              ),
              const _time(time: "11:05 14/10/2024"),
              _messageCard(
                avatar: widget.user.avatar,
                isMe: false,
                message: 'Chào bạn, bạn cần giúp gì?',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _time extends StatelessWidget {
  final String time;
  const _time({
    required this.time,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        time,
        style: const TextStyle(
          color: AppColors.xam72,
          fontSize: 12,
        ),
      ),
    );
  }
}

class _messageCard extends StatelessWidget {
  final String avatar;
  final bool isMe;
  final String message;
  const _messageCard(
      {required this.avatar,
      required this.isMe,
      required this.message,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe)
            SvgPicture.asset(
              avatar,
              width: 32,
              height: 32,
            ),
          const SizedBox(
            width: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
              color: isMe ? AppColors.cam_main : Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(15),
                topRight: const Radius.circular(15),
                bottomLeft:
                    isMe ? const Radius.circular(15) : const Radius.circular(3),
                bottomRight:
                    isMe ? const Radius.circular(3) : const Radius.circular(15),
              ),
            ),
            child: Text(
              message,
              style: TextStyle(
                color: isMe ? Colors.white : Colors.black,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
