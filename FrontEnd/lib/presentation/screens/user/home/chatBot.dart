import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({super.key});

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final ScrollController _scrollController = ScrollController();
  List<Message> messages = [
    Message(
      content: "Hello! How can I assist you today?",
      isMe: false,
    ),
    Message(
      content: "I need help with my order.",
      isMe: true,
    ),
  ];

  void sendMessage(String message) {
    setState(() {
      messages.add(Message(
        content: message,
        isMe: true,
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
        appBar: AppBar(
          title: const Text('ChatBot'),
        ),
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
                      hintText: 'Enter message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.send,
                    color: Colors.blue,
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
                    color: isMe ? Colors.blue : Colors.white,
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
