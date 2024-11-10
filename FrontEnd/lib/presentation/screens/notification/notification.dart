import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:se121_giupviec_app/core/firebase/firebase_image.dart';
import 'package:se121_giupviec_app/presentation/bloc/notification/notification_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/notification/notification_state.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NotificationScreen extends StatefulWidget {
  final int userId;
  const NotificationScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<allNotificationCubit>(context).getAllNotifications(1);
  }

  final FirebaseImageService _firebaseImageService = FirebaseImageService();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<allNotificationCubit, AllNotificationState>(
      builder: (context, state) {
        if (state is AllNotificationLoading) {
          return Center(
            child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                ),
                child: const Center(
                    child: SizedBox(
                        height: 40,
                        width: 40,
                        child: CircularProgressIndicator()))),
          );
        } else if (state is AllNotificationSuccess) {
          return Scaffold(
            appBar: const BasicAppbar(
              title: Text(
                'Thông báo',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              isHideBackButton: false,
              isHavePadding: true,
              color: Colors.white,
            ),
            body: ListView.builder(
              itemCount: state.NotificationLs.length,
              itemBuilder: (context, index) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Dismissible(
                        key: Key(state.NotificationLs[index].header!),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          BlocProvider.of<allNotificationCubit>(context)
                              .deleteANotification(
                                  state.NotificationLs[index].id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                              'Đã xóa thông báo',
                            )),
                          );
                        },
                        background: Container(color: Colors.transparent),
                        secondaryBackground: Container(
                          color: AppColors.do_main,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Icons.delete, color: Colors.white),
                              SizedBox(width: 20),
                            ],
                          ),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              leading: FutureBuilder<String>(
                                future: _firebaseImageService.loadImage(
                                    state.NotificationLs[index].image!),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Icon(Icons.error);
                                  } else if (snapshot.hasData) {
                                    return CachedNetworkImage(
                                      imageUrl: snapshot.data!,
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        width: 40.0,
                                        height: 40.0,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border:
                                              Border.all(color: Colors.grey),
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Icon(Icons.error);
                                  }
                                },
                              ),
                              title: Text(state.NotificationLs[index].header,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                              subtitle: Text(
                                state.NotificationLs[index].content!,
                                style: TextStyle(
                                  color: AppColors.xam72,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: const Divider(),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        } else if (state is AllNotificationError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const Center(child: Text('No tasks found'));
        }
      },
    );
  }
}
