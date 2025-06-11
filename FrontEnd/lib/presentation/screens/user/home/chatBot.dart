import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({super.key});

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final ScrollController _scrollController = ScrollController();
  List<Message> messages = [
    Message(
      content:
          "Xin chào, tôi là Bích - trợ lý ảo của bạn. Bạn cần giúp gì không?",
      isMe: false,
    ),
    Message(
      content: "Hướng dẫn tôi cách đăng việc.",
      isMe: true,
    ),
    Message(
      content:
          "Để đăng việc, bạn cần truy cập vào trang chủ của ứng dụng, sau đó chọn mục 'Đăng việc'. Tại đây, bạn sẽ được hướng dẫn từng bước để hoàn thành việc đăng.",
      isMe: false,
    ),
    Message(
      content: "Tôi muốn thêm địa chỉ của mình vào hồ sơ.",
      isMe: true,
    ),
    Message(
      content:
          "Để thêm địa chỉ vào hồ sơ, bạn cần truy cập vào phần 'Hồ sơ' trong ứng dụng. Tại đây, bạn có thể chỉnh sửa thông tin cá nhân và thêm địa chỉ của mình.",
      isMe: false,
    ),
  ];

  void sendMessage(String message) {
    setState(() {
      messages.add(Message(
        content: message,
        isMe: true,
      ));
    });
    setState(() {
      messages.add(Message(
        content: "Đã nhận được tin nhắn của bạn",
        isMe: false,
      ));
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 100), curve: Curves.easeOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController messageController = TextEditingController();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFFF2F2F2),
        appBar: const BasicAppbar(title: Text('Trợ lý ảo'), isCenter: true),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 10,
            right: 10,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: messageController,
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
                    color: AppColors.cam_main,
                    size: 32,
                  ),
                  onPressed: () {
                    if (messageController.text.isNotEmpty) {
                      sendMessage(messageController.text);
                      messageController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: ListView.builder(
              itemCount: messages.length,
              controller: _scrollController,
              itemBuilder: (context, index) {
                return _messageCard(
                  isMe: messages[index].isMe,
                  message: messages[index].content,
                );
              },
            )));
  }
}

class Message {
  final String content;
  final bool isMe;

  Message({required this.content, required this.isMe});
}

class _messageCard extends StatelessWidget {
  final bool isMe;
  final String message;

  const _messageCard({required this.isMe, required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: isMe
              ? const EdgeInsets.only(top: 5, bottom: 5, left: 50)
              : const EdgeInsets.only(top: 5, bottom: 5, right: 50),
          child: Row(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Flexible(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                    color: isMe ? AppColors.cam_main : Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(15),
                      topRight: const Radius.circular(15),
                      bottomLeft: isMe
                          ? const Radius.circular(15)
                          : const Radius.circular(3),
                      bottomRight: isMe
                          ? const Radius.circular(3)
                          : const Radius.circular(15),
                    ),
                  ),
                  child: Text(
                    message,
                    style: TextStyle(
                      color: isMe ? Colors.white : Colors.black,
                      fontSize: 14,
                    ),
                    softWrap: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
