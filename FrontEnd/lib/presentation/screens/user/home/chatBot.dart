import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:http/http.dart' as http;

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
  ];
  bool isLoading = false; // Thêm biến trạng thái loading

  void sendMessage(String message) async {
    setState(() {
      messages.add(Message(content: message, isMe: true));
      isLoading = true; // Bắt đầu loading
      messages.add(Message(content: "Đang trả lời...", isMe: false));
    });

    try {
      final url = Uri.parse(
          'https://a640-42-116-6-46.ngrok-free.app/webhooks/rest/webhook');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'sender': 'user', 'message': message}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          isLoading = false; // Kết thúc loading
          // Xóa tin nhắn "Đang trả lời..." và thêm phản hồi thực tế
          messages.removeLast();
          if (data.isNotEmpty && data[0]['text'] != null) {
            messages.add(Message(content: data[0]['text'], isMe: false));
          } else {
            messages.add(Message(
                content: "Không nhận được phản hồi từ server", isMe: false));
          }
        });
      } else {
        setState(() {
          isLoading = false; // Kết thúc loading
          messages.removeLast();
          messages.add(
              Message(content: "Lỗi: ${response.statusCode}", isMe: false));
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false; // Kết thúc loading
        messages.removeLast();
        messages.add(Message(content: "Lỗi kết nối: $e", isMe: false));
      });
    }

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
