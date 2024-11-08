import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/core/configs/constants/api_constants.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_info.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:se121_giupviec_app/data/models/User.dart';
import 'package:se121_giupviec_app/presentation/screens/user/message/listTaskMessage.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:intl/intl.dart';

import '../../../../common/helpers/SecureStorage.dart';
import '../../../../data/models/message_model.dart';
import '../../../../domain/entities/message.dart';
import '../../../bloc/Message/message_cubit.dart';
import '../../../bloc/Message/message_state.dart';

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
  List<Message> messages = [];
  IO.Socket? socket;
  ScrollController _scrollController = ScrollController();
  bool sendButton = false;
  SecureStorage secureStorage = SecureStorage();
  Future<String> _fetchUserId() async {
    String id = await secureStorage.readId();
    return id;
  }

  int? curentUserId;

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
    BlocProvider.of<MessageCubit>(context)
        .getMyMessage(widget.sourseUser.id, widget.targetUser.id);

    connect();
  }

  void connect() async {
    curentUserId = int.parse(await _fetchUserId());
    socket = IO.io(ApiConstants.baseUrl, <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket!.connect();
    socket!.emit("login", widget.sourseUser.id);
    socket!.onConnect((data) {
      print("Connected");
      socket!.on("message", (msg) {
        if (!mounted)
          return; // Kiểm tra thuộc tính mounted trước khi gọi setState

        print(msg);
        setMessages(msg["message"], false, msg["sourceId"], msg["targetId"]);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeOut);
        });
      });
    });
    print(socket!.connected);
  }

  void setMessages(String messages, bool isMe, int sourceId, int targetId) {
    if (!mounted) return; // Kiểm tra thuộc tính mounted trước khi gọi setState

    setState(() {
      this.messages.add(MessageModel(
          id: 1,
          content: messages,
          sourceId: sourceId,
          targetId: targetId,
          createdAt: DateFormat('dd-MM-yyyy HH:mm')
              .format(DateTime.now())
              .toString()));
    });
  }

  void sendMessage(String message, int sourceId, int targetId) {
    setMessages(message, true, sourceId, targetId);
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
                horizontal: AppInfo.main_padding,
                vertical: AppInfo.main_padding),
            child: BlocBuilder<MessageCubit, MessageState>(
              builder: (context, state) {
                if (state is MessageLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is MessageSuccess) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 100),
                        curve: Curves.easeOut);
                  });
                  messages = state.messages;
                  return ListView.builder(
                    itemCount: messages.length,
                    controller: _scrollController,
                    itemBuilder: (context, index) {
                      return _messageCard(
                        avatar: widget.targetUser.avatar,
                        isMe: curentUserId == messages[index].sourceId,
                        message: messages[index].content,
                        time: messages[index].createdAt.length == 16
                            ? messages[index].createdAt
                            : DateFormat('dd-MM-yyyy HH:mm').format(
                                DateTime.parse(messages[index].createdAt)
                                    .toLocal()),
                      );
                    },
                  );
                } else if (state is MessageError) {
                  return Center(child: Text('Error: ${state.message}'));
                } else {
                  return const Center(child: Text('Không tìm thấy tin nhắn'));
                }
              },
            )
            // ListView.builder(
            //   itemCount: messages.length,
            //   controller: _scrollController,
            //   itemBuilder: (context, index) {
            //     return _messageCard(
            //       avatar: widget.targetUser.avatar,
            //       isMe: curentUserId == messages[index].sourceId,
            //       message: messages[index].content,
            //       time: DateFormat('dd-MM-yyyy HH:mm')
            //           .format(DateTime.parse(messages[index].createdAt)),
            //     );
            //   },
            // ),
            ));
  }
}

class _time extends StatelessWidget {
  final String time;
  final bool showTime;
  const _time({
    required this.time,
    required this.showTime,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (showTime == false) {
      return const SizedBox();
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
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

class _messageCard extends StatefulWidget {
  final String avatar;
  final bool isMe;
  final String message;
  final String time;

  const _messageCard(
      {required this.avatar,
      required this.isMe,
      required this.message,
      required this.time,
      super.key});

  @override
  State<_messageCard> createState() => _messageCardState();
}

class _messageCardState extends State<_messageCard> {
  bool showTime = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _time(
          time: widget.time.substring(0, 16),
          showTime: showTime,
        ),
        GestureDetector(
          onTap: () => {
            setState(() {
              showTime = !showTime;
            })
          },
          child: Container(
            margin: widget.isMe
                ? EdgeInsets.only(top: 5, bottom: 5, left: 50)
                : EdgeInsets.only(top: 5, bottom: 5, right: 50),
            child: Row(
              mainAxisAlignment:
                  widget.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
              children: [
                if (!widget.isMe)
                  SvgPicture.asset(
                    widget.avatar,
                    width: 32,
                    height: 32,
                  ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      color: widget.isMe ? AppColors.cam_main : Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(15),
                        topRight: const Radius.circular(15),
                        bottomLeft: widget.isMe
                            ? const Radius.circular(15)
                            : const Radius.circular(3),
                        bottomRight: widget.isMe
                            ? const Radius.circular(3)
                            : const Radius.circular(15),
                      ),
                    ),
                    child: Text(
                      widget.message,
                      style: TextStyle(
                        color: widget.isMe ? Colors.white : Colors.black,
                        fontSize: 14,
                      ),
                      softWrap: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
