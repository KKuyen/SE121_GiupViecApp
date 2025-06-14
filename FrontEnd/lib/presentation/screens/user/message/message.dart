import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/common/widgets/search/search.dart';
import 'package:se121_giupviec_app/core/configs/assets/app_images.dart';
import 'package:se121_giupviec_app/core/configs/assets/app_vectors.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_info.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:se121_giupviec_app/data/models/User.dart';
import 'package:se121_giupviec_app/presentation/screens/user/message/detailMessage.dart';
import '../../../../common/helpers/SecureStorage.dart';
import '../../../../core/firebase/firebase_image.dart';
import '../../../bloc/Message/message_review_cubit.dart';
import '../../../bloc/Message/message_state.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  SecureStorage secureStorage = SecureStorage();
  Future<Map<String, String>>? _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = _fetchUserData();
  }

  Future<Map<String, String>> _fetchUserData() async {
    String name = await secureStorage.readName();
    String id = await secureStorage.readId();
    String avatar = await secureStorage.readAvatar();
    return {'id': id, 'name': name, 'avatar': avatar};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const BasicAppbar(
        isHideBackButton: true,
        isHavePadding: false,
        title: Text(
          'Tin nhắn',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppInfo.main_padding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 5),
              const Search(hint: "Tìm kiếm tin nhắn"),
              const SizedBox(height: 15),
              FutureBuilder<Map<String, String>>(
                future: _userFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final sourseUser = snapshot.data!;
                    User user = User(
                      id: int.parse(sourseUser['id']!),
                      name: sourseUser['name']!,
                      avatar: sourseUser['avatar']!,
                    );
                    return _listMessage(sourseUser: user);
                  } else {
                    return const Text('Không có dữ liệu người dùng.');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _listMessage extends StatefulWidget {
  final User sourseUser;
  const _listMessage({required this.sourseUser});

  @override
  State<_listMessage> createState() => _listMessageState();
}

class _listMessageState extends State<_listMessage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MessageReviewCubit>(context)
        .getMyMessageReview(widget.sourseUser.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageReviewCubit, MessageState>(
      builder: (context, state) {
        if (state is MessageLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is MessageReviewSuccess) {
          final messages = state.messageReviews;
          return Container(
            height: MediaQuery.of(context).size.height - 400,
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final name =
                    (messages[index].target as Map<String, dynamic>)['name'];
                final avatar =
                    (messages[index].target as Map<String, dynamic>)['avatar'];
                return _messageCard(
                  id: messages[index].targetId,
                  avatar: avatar,
                  name: name,
                  message: messages[index].lastMessage,
                  time: messages[index].lastMessageTime,
                  isSeen: true,
                  sourseUser: widget.sourseUser,
                );
              },
            ),
          );
        } else if (state is MessageError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const Center(child: Text('Bạn chưa có tin nhắn nào!'));
        }
      },
    );
  }
}

class _messageCard extends StatefulWidget {
  final int id;
  final String avatar;
  final String name;
  final String message;
  final String time;
  final bool isSeen;
  final User? sourseUser;
  const _messageCard({
    required this.id,
    this.avatar = AppVectors.avatar,
    this.name = 'Nguyễn Văn A',
    this.message = 'Mình chia tay đi',
    this.time = '12:00',
    this.isSeen = false,
    this.sourseUser,
  });

  @override
  State<_messageCard> createState() => _messageCardState();
}

class _messageCardState extends State<_messageCard> {
  final FirebaseImageService _firebaseImageService = FirebaseImageService();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        User user = User(
          id: widget.id,
          name: widget.name,
          avatar: widget.avatar,
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Detailmessage(
              targetUser: user,
              sourseUser: widget.sourseUser!,
            ),
          ),
        );
      },
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Container(
          width: 41,
          height: 41,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 1.0),
          ),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 20.5,
            child: ClipOval(
              child: widget.avatar.contains('http')
                  ? CachedNetworkImage(
                      imageUrl: widget.avatar,
                      fit: BoxFit.cover,
                      width: 41,
                      height: 41,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => SvgPicture.asset(
                        AppVectors.avatar,
                        width: 41,
                        height: 41,
                      ),
                    )
                  : SvgPicture.asset(
                      AppVectors.avatar,
                      width: 41,
                      height: 41,
                    ),
            ),
          ),
        ),
        title: Text(
          widget.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          children: [
            Expanded(
              child: Text(
                widget.message,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: widget.isSeen ? Colors.grey : Colors.black,
                  fontWeight:
                      widget.isSeen ? FontWeight.normal : FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              widget.time,
              style: TextStyle(
                color: widget.isSeen ? Colors.grey : Colors.black,
                fontWeight: widget.isSeen ? FontWeight.normal : FontWeight.bold,
              ),
            ),
          ],
        ),
        trailing: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: widget.isSeen ? Colors.transparent : AppColors.cam_main,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
