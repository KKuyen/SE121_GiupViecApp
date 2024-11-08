import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/common/widgets/search/search.dart';

import 'package:se121_giupviec_app/core/configs/assets/app_vectors.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_info.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:se121_giupviec_app/data/models/User.dart';
import 'package:se121_giupviec_app/presentation/screens/user/message/detailMessage.dart';

import '../../../../common/helpers/SecureStorage.dart';
import '../../../bloc/Message/message_review_cubit.dart';
import '../../../bloc/Message/message_state.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  SecureStorage secureStorage = SecureStorage();
  Future<Map<String, String>> _fetchUserData() async {
    String name = await secureStorage.readName();
    String id = await secureStorage.readId();
    String avatar = await secureStorage.readAvatar();
    User user = User(id: int.parse(id), name: name, avatar: avatar);
    print("user" + user.id.toString());
    return {'id': id, 'name': name, 'avatar': avatar};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const BasicAppbar(
        isHideBackButton: true,
        isHavePadding: false,
        title: Text('Tin nhắn',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppInfo.main_padding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              const Search(
                hint: "Tìm kiếm tin nhắn",
              ),
              const SizedBox(
                height: 15,
              ),
              FutureBuilder<Map<String, String>>(
                future: _fetchUserData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Errorrrr: ${snapshot.error}');
                  } else {
                    final sourseUser = snapshot.data!;
                    User user = User(
                        id: int.parse(sourseUser['id']!),
                        name: sourseUser['name']!,
                        avatar: sourseUser['avatar']!);
                    return _listMessage(sourseUser: user);
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
  const _listMessage({
    super.key,
    required this.sourseUser,
  });

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
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is MessageReviewSuccess) {
          final messages = state.messageReviews;
          return Container(
              height: MediaQuery.of(context).size.height - 400,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final name = (messages[index].target
                        as Map<String, dynamic>)['name'];
                    return _messageCard(
                      id: messages[index].targetId,
                      avatar: AppVectors.google,
                      name: name,
                      message: messages[index].lastMessage,
                      time: messages[index].lastMessageTime,
                      isSeen: true,
                      sourseUser: widget.sourseUser,
                    );
                  }));
        } else if (state is MessageError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const Center(child: Text('Bạn chưa có tin nhắn nào!'));
        }
      },
    );
  }
}

class _messageCard extends StatelessWidget {
  final int id;
  final String avatar;
  final String name;
  final String message;
  final String time;
  final bool isSeen;
  final User? sourseUser;
  const _messageCard({
    this.avatar = AppVectors.facebook,
    this.name = 'Nguyễn Văn A',
    this.message = 'Mình chia tay đi',
    this.time = '12:00',
    this.isSeen = false,
    required this.id,
    this.sourseUser,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        try {
          User user = User(id: id, name: name, avatar: avatar);

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Detailmessage(
                      targetUser: user, sourseUser: sourseUser!)));
        } on Exception catch (e) {
          print("bbbbbbbbbbbb" + e.toString());
          // TODO
        }
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
