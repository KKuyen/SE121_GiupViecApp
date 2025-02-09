import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/common/widgets/button/sizedbutton.dart';
import 'package:se121_giupviec_app/core/configs/assets/app_images.dart';
import 'package:se121_giupviec_app/core/configs/assets/app_vectors.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:se121_giupviec_app/presentation/bloc/tasker/tasker_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/tasker/tasker_state.dart';
import 'package:se121_giupviec_app/presentation/screens/auth/signin-page.dart';
import 'package:se121_giupviec_app/presentation/screens/tasker/account/editAccountTasker.dart';
import 'package:se121_giupviec_app/presentation/screens/tasker/account/setting.dart';
import 'package:se121_giupviec_app/presentation/screens/user/account/aboutUs.dart';
import 'package:se121_giupviec_app/presentation/screens/user/account/setting.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../common/helpers/SecureStorage.dart';
import '../../../../core/configs/assets/app_vectors.dart';
import '../../user/activities/allReview.dart';
import 'locationTasker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/firebase/firebase_image.dart';

class AccountTaskerPage extends StatefulWidget {
  final int userId;
  final String userAvatar;

  const AccountTaskerPage(
      {super.key, required this.userId, required this.userAvatar});

  @override
  State<AccountTaskerPage> createState() => _AccountTaskerPageState();
}

class _AccountTaskerPageState extends State<AccountTaskerPage> {
  SecureStorage secureStorage = SecureStorage();
  Future<Map<String, String>> _fetchUserData() async {
    String name = await secureStorage.readName();
    String phoneNumber = await secureStorage.readPhoneNumber();
    String avatar = await secureStorage.readAvatar();
    return {'name': name, 'phoneNumber': phoneNumber, 'avatar': avatar};
  }

  String avatar = '';

  FirebaseImageService _firebaseImageService = FirebaseImageService();

  Future<String> _fetchUserId() async {
    String id = await secureStorage.readId();
    return id;
  }

  int userIdd = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<TaskerCubit>(context).getATasker(1, widget.userId);
    _fetchUserId().then((value) {
      userIdd = (int.parse(value));
    });
    _fetchUserData().then((value) {
      avatar = value['avatar']!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: const BasicAppbar(
        isHideBackButton: true,
        isHavePadding: false,
        title: Text('Tài khoản',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
      ),
      body: Center(
        child: Stack(
          children: [
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 150,
                  decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage(AppImages.cover)),
                  ),
                )),
            Positioned(
              top: 130,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Container(
                    height: 190,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height - 490,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListTile(
                            title: const Text('Địa chỉ'),
                            leading: const Icon(Icons.location_on_outlined),
                            trailing: const Icon(Icons.navigate_next_rounded),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LocationTaskerPage(
                                          userAvatar: widget.userAvatar)));
                            },
                          ),
                          const Divider(
                            height: 1,
                            thickness: 1,
                          ),
                          ListTile(
                            title: const Text('Đánh giá'),
                            leading: const Icon(Icons.star_border_rounded),
                            trailing: const Icon(Icons.navigate_next_rounded),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Allreview(taskerId: userIdd)));
                            },
                          ),
                          const Divider(
                            height: 1,
                            thickness: 1,
                          ),
                          ListTile(
                            title: const Text('Chia sẻ'),
                            leading: const Icon(Icons.share_outlined),
                            trailing: const Icon(Icons.navigate_next_rounded),
                            onTap: () {
                              Share.share(
                                  'https://play.google.com/store/apps/details?id=com.se121_giupviec_app');
                            },
                          ),
                          const Divider(
                            height: 1,
                            thickness: 1,
                          ),
                          ListTile(
                            title: const Text('Trợ giúp'),
                            leading: const Icon(Icons.help_outline_rounded),
                            trailing: const Icon(Icons.navigate_next_rounded),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Aboutus()));
                            },
                          ),
                          const Divider(
                            height: 1,
                            thickness: 1,
                          ),
                          ListTile(
                            title: const Text('Cài đặt'),
                            leading: const Icon(Icons.settings_outlined),
                            trailing: const Icon(Icons.navigate_next_rounded),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TaskerSetting(
                                            accountId: widget.userId,
                                          )));
                            },
                          ),
                          const Divider(
                            height: 1,
                            thickness: 1,
                          ),
                          ListTile(
                            title: const Text('Đăng xuất'),
                            leading: const Icon(Icons.logout),
                            onTap: () {
                              secureStorage.deleteAll();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignInPage()));
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                top: 30,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width:
                              150, // Kích thước của Container bao quanh CircleAvatar
                          height: 150,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white, // Màu viền
                              width: 6.0, // Độ dày của viền
                            ),
                          ),
                          child: FutureBuilder<String>(
                            future: _firebaseImageService
                                .loadImage(widget.userAvatar),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return SvgPicture.asset(
                                  // Nếu có lỗi thì hiển thị icon mặc định
                                  AppVectors.avatar,
                                  width: 150.0,
                                  height: 150.0,
                                );
                              } else {
                                return CachedNetworkImage(
                                  imageUrl: snapshot.data!,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      SvgPicture.asset(
                                    AppVectors.avatar,
                                    width: 150.0,
                                    height: 150.0,
                                  ),
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.grey),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 7),
                        FutureBuilder<Map<String, String>>(
                          future: _fetchUserData(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              final userData = snapshot.data!;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userData['name']!,
                                    style: const TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    userData['phoneNumber']!,
                                    style: const TextStyle(
                                      fontSize: 17,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 10),
                        BlocBuilder<TaskerCubit, TaskerState>(
                          builder: (context, state) {
                            if (state is TaskerSuccess) {
                              return Sizedbutton(
                                onPressFun: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EditAccountTaskerPage(
                                                  parrent: widget,
                                                  tasker: state.tasker,
                                                  taskTypeList:
                                                      state.taskTypeList)));
                                },
                                text: 'Cập nhật hồ sơ',
                                backgroundColor: AppColors.cam_main,
                                textColor: Colors.white,
                                width: double.infinity,
                                height: 45,
                              );
                            }
                            return const CircularProgressIndicator();
                          },
                        )
                      ]),
                ))
          ],
        ),
      ),
    );
  }
}
