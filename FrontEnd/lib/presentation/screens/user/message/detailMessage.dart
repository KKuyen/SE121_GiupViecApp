import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/common/widgets/message/jobCard.dart';
import 'package:se121_giupviec_app/core/configs/constants/api_constants.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_info.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:se121_giupviec_app/data/models/Message.dart';
import 'package:se121_giupviec_app/data/models/User.dart';
import 'package:se121_giupviec_app/presentation/screens/user/message/listTaskMessage.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Detailmessage extends StatefulWidget {
  final User targetUser;
  final User sourseUser;

  const Detailmessage(
      {required this.targetUser, required this.sourseUser, super.key});

  @override
  State<Detailmessage> createState() => _DetailmessageState();
}

class _DetailmessageState extends State<Detailmessage> {
  final ImagePicker _picker = ImagePicker();
  final List<Message> messages = [];
  IO.Socket? socket;
  ScrollController _scrollController = ScrollController();
  bool sendButton = false;

  Future<void> _openCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // Xử lý ảnh đã chụp
      print('Image path: ${image.path}');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("sourseId: " + widget.sourseUser.id.toString());
    print("targetId: " + widget.targetUser.id.toString());
    connect();
  }

  void connect() {
    socket = IO.io(ApiConstants.baseChatUrl, <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket!.connect();
    socket!.emit("login", widget.sourseUser.id);
    socket!.onConnect((data) {
      print("Connected");
      socket!.on("message", (msg) {
        print(msg);
        setMessages(msg["message"], false);
      });
    });
    print(socket!.connected);
  }

  void setMessages(String messages, bool isMe) {
    setState(() {
      this.messages.add(Message(
          message: messages, isMe: isMe, time: DateTime.now().toString()));
    });
  }

  void sendMessage(String message, int sourceId, int targetId) {
    setMessages(message, true);
    socket!.emit("message",
        {"message": message, "sourceId": sourceId, "targetId": targetId});
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController messageController = TextEditingController();
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
                  color: AppColors.xanh_main,
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
                    Icons.info,
                    size: 27,
                    color: AppColors.xanh_main,
                  ),
                ),
              ],
            ),
            isHavePadding: false,
            title: Row(
              children: [
                SvgPicture.asset(
                  widget.targetUser.avatar,
                  width: 35,
                  height: 35,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(widget.targetUser.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            )),
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
                    color: AppColors.xanh_main,
                    size: 32,
                  ),
                  onPressed: () {
                    messageController.text.isEmpty
                        ? null
                        : sendMessage(messageController.text,
                            widget.sourseUser.id, widget.targetUser.id);
                    messageController.clear();
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _scrollController.animateTo(
                          _scrollController.position.maxScrollExtent,
                          duration: const Duration(milliseconds: 100),
                          curve: Curves.easeOut);
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppInfo.main_padding, vertical: AppInfo.main_padding),
          child: ListView.builder(
            itemCount: messages.length,
            controller: _scrollController,
            itemBuilder: (context, index) {
              return _messageCard(
                avatar: widget.targetUser.avatar,
                isMe: messages[index].isMe,
                message: messages[index].message,
              );
            },
          ),
        ));
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
      margin: isMe
          ? EdgeInsets.only(top: 5, bottom: 5, left: 50)
          : EdgeInsets.only(top: 5, bottom: 5, right: 50),
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
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
    );
  }
}
