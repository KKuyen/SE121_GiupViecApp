import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_info.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:se121_giupviec_app/data/models/User.dart' as CustomUser;
import 'package:intl/intl.dart';
import 'package:se121_giupviec_app/presentation/screens/user/message/listTaskMessage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../common/helpers/SecureStorage.dart';
import '../../../../core/configs/assets/app_vectors.dart';
import '../../../../core/firebase/firebase_image.dart';
import '../../../../data/models/message_model.dart';

class Detailmessage extends StatefulWidget {
  final CustomUser.User targetUser;
  final CustomUser.User sourseUser;

  const Detailmessage({
    required this.targetUser,
    required this.sourseUser,
    super.key,
  });

  @override
  State<Detailmessage> createState() => _DetailmessageState();
}

class _DetailmessageState extends State<Detailmessage> {
  final ImagePicker _picker = ImagePicker();
  final ScrollController _scrollController = ScrollController();
  final SecureStorage secureStorage = SecureStorage();
  final SupabaseClient supabase = Supabase.instance.client;
  final FirebaseImageService _firebaseImageService = FirebaseImageService();
  final TextEditingController messageController = TextEditingController();

  List<MessageModel> messages = [];
  int? curentUserId;

  @override
  void initState() {
    super.initState();
    curentUserId = widget.sourseUser.id;

    _initializeSupabaseRealtime();
    _OrderMessages();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  void _initializeSupabaseRealtime() {
    supabase.from('message').stream(primaryKey: ['id']).listen((data) {
      for (var row in data) {
        if ((row['sourceId'] == widget.sourseUser.id &&
                row['targetId'] == widget.targetUser.id) ||
            (row['targetId'] == widget.sourseUser.id &&
                row['sourceId'] == widget.targetUser.id)) {
          setMessages(
            row['content'],
            row['sourceId'] == widget.sourseUser.id,
            row['sourceId'],
            row['targetId'],
            row['createdAt'],
          );
        }
      }

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeOut,
          );
        }
      });
    });
  }

  void _OrderMessages() async {}

  void setMessages(
    String content,
    bool isMe,
    int sourceId,
    int targetId,
    String createdAt,
  ) {
    if (!mounted) return;

    // Ngăn thêm trùng tin nhắn
    if (messages.any((m) =>
        m.content == content &&
        m.sourceId == sourceId &&
        m.targetId == targetId &&
        m.createdAt == createdAt)) return;

    setState(() {
      messages.add(MessageModel(
        id: messages.length + 1,
        content: content,
        sourceId: sourceId,
        targetId: targetId,
        createdAt: createdAt,
      ));
    });
  }

  Future<void> sendMessage(
    String message,
    int sourceId,
    int targetId,
  ) async {
    await supabase.from('message').insert({
      'content': message,
      'sourceId': sourceId,
      'targetId': targetId,
      'createdAt': DateTime.now().toIso8601String(),
    });

    await supabase
        .from('message_review')
        .update({
          'lastMessage': message,
          'lastMessageTime': DateFormat('HH:mm').format(DateTime.now()),
        })
        .eq('sourceId', sourceId)
        .eq('targetId', targetId);
  }

  void _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: BasicAppbar(
        color: Colors.white,
        isHideBackButton: false,
        action: Row(
          children: [
            GestureDetector(
              onTap: () => _makePhoneCall("0345664024"),
              child:
                  const Icon(Icons.phone, size: 27, color: AppColors.xanh_main),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ListTaskMessage()),
                );
              },
              child:
                  const Icon(Icons.info, size: 27, color: AppColors.xanh_main),
            ),
          ],
        ),
        isHavePadding: false,
        title: Row(
          children: [
            Container(
              width: 41,
              height: 41,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 1.0),
              ),
              child: FutureBuilder<String>(
                future:
                    _firebaseImageService.loadImage(widget.targetUser.avatar),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      snapshot.hasError ||
                      !snapshot.hasData) {
                    return SvgPicture.asset(
                      AppVectors.avatar,
                      width: 41.0,
                      height: 41.0,
                    );
                  }

                  return CachedNetworkImage(
                    imageUrl: snapshot.data!,
                    placeholder: (context, url) => SvgPicture.asset(
                      AppVectors.avatar,
                      width: 41.0,
                      height: 41.0,
                    ),
                    errorWidget: (context, url, error) => SvgPicture.asset(
                      AppVectors.avatar,
                      width: 41.0,
                      height: 41.0,
                    ),
                    imageBuilder: (context, imageProvider) => SvgPicture.asset(
                      AppVectors.avatar,
                      width: 41.0,
                      height: 41.0,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 10),
            Text(
              widget.targetUser.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
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
              IconButton(
                icon: const Icon(Icons.image_rounded,
                    size: 34, color: AppColors.xanh_main),
                onPressed: () {
                  print("Không chọn ảnh");
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
                icon: const Icon(Icons.send,
                    color: AppColors.xanh_main, size: 32),
                onPressed: () {
                  if (messageController.text.isNotEmpty) {
                    sendMessage(
                      messageController.text,
                      widget.sourseUser.id,
                      widget.targetUser.id,
                    );
                    messageController.clear();
                  }
                },
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppInfo.main_padding,
          vertical: AppInfo.main_padding,
        ),
        child: ListView.builder(
          controller: _scrollController,
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final message = messages[index];
            final isMe = curentUserId == message.sourceId;

            return _MessageCard(
              avatar:
                  isMe ? widget.sourseUser.avatar : widget.targetUser.avatar,
              isMe: isMe,
              message: message.content,
              time: DateFormat('dd-MM-yyyy HH:mm')
                  .format(DateTime.parse(message.createdAt).toLocal()),
            );
          },
        ),
      ),
    );
  }
}

class _MessageCard extends StatelessWidget {
  final String avatar;
  final bool isMe;
  final String message;
  final String time;

  const _MessageCard({
    required this.avatar,
    required this.isMe,
    required this.message,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 3),
          child: Text(
            time,
            style: const TextStyle(color: AppColors.xam72, fontSize: 12),
          ),
        ),
        Container(
          margin: isMe
              ? const EdgeInsets.only(top: 5, bottom: 5, left: 50)
              : const EdgeInsets.only(top: 5, bottom: 5, right: 50),
          child: Row(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (!isMe)
                CachedNetworkImage(
                  imageUrl: avatar,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => SvgPicture.asset(
                    AppVectors.avatar,
                    width: 32.0,
                    height: 32.0,
                  ),
                  imageBuilder: (context, imageProvider) => Container(
                    width: 32.0,
                    height: 32.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                ),
              const SizedBox(width: 10),
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
