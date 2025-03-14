import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/common/widgets/button/sizedbutton.dart';
import 'package:se121_giupviec_app/core/configs/assets/app_images.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:se121_giupviec_app/presentation/screens/auth/signin-page.dart';
import 'package:se121_giupviec_app/presentation/screens/tasker/account/setting.dart';
import 'package:se121_giupviec_app/presentation/screens/user/account/editAccount.dart';
import 'package:se121_giupviec_app/presentation/screens/user/account/location.dart';
import 'package:se121_giupviec_app/presentation/screens/user/account/report.dart';
import 'package:se121_giupviec_app/presentation/screens/user/home/myVoucher.dart';
import 'package:se121_giupviec_app/presentation/screens/user/account/aboutUs.dart';
import 'package:se121_giupviec_app/presentation/screens/user/account/blockTaskers.dart';
import 'package:se121_giupviec_app/presentation/screens/user/account/loveTaskers.dart';
import 'package:se121_giupviec_app/presentation/screens/user/account/setting.dart';
import 'package:share_plus/share_plus.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../common/helpers/SecureStorage.dart';
import '../../../../core/configs/assets/app_vectors.dart';
import '../../../../core/firebase/firebase_image.dart';

class AccountPage extends StatefulWidget {
  final int userId;
  final String Useravatar;

  const AccountPage(
      {super.key, required this.userId, required this.Useravatar});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  SecureStorage secureStorage = SecureStorage();
  Future<Map<String, String>> _fetchUserData() async {
    String name = await secureStorage.readName();
    String phoneNumber = await secureStorage.readPhoneNumber();
    String avatar = await secureStorage.readAvatar();
    return {'name': name, 'phoneNumber': phoneNumber, 'avatar': avatar};
  }

  String avatar = '';

  FirebaseImageService _firebaseImageService = FirebaseImageService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                                      builder: (context) => LocationPage(
                                            userAvatar: widget.Useravatar,
                                          )));
                            },
                          ),
                          const Divider(
                            height: 1,
                            thickness: 1,
                          ),
                          ListTile(
                            title: const Text('Tasker yêu thích'),
                            leading: const Icon(Icons.favorite_border_rounded),
                            trailing: const Icon(Icons.navigate_next_rounded),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Lovetaskers(userId: widget.userId)));
                            },
                          ),
                          const Divider(
                            height: 1,
                            thickness: 1,
                          ),
                          ListTile(
                            title: const Text('Danh sách chặn'),
                            leading: const Icon(Icons.block_outlined),
                            trailing: const Icon(Icons.navigate_next_rounded),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Blocktaskers(
                                            userId: widget.userId,
                                          )));
                            },
                          ),
                          const Divider(
                            height: 1,
                            thickness: 1,
                          ),
                          ListTile(
                            title: const Text('Ưu đãi của tôi'),
                            leading: const Icon(Icons.wallet_giftcard_sharp),
                            trailing: const Icon(Icons.navigate_next_rounded),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MyVoucherPage()));
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
                                      builder: (context) => Setting(
                                            accountId: widget.userId,
                                          )));
                            },
                          ),
                          const Divider(
                            height: 1,
                            thickness: 1,
                          ),
                          ListTile(
                            title: const Text('Khiếu nại'),
                            leading: const Icon(Icons.report_problem_outlined),
                            trailing: const Icon(Icons.navigate_next_rounded),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ReportScreen(
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
                                .loadImage(widget.Useravatar),
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
                              } else if (snapshot.hasData) {
                                return CachedNetworkImage(
                                  imageUrl: snapshot.data!,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      SvgPicture.asset(
                                    // Nếu có lỗi thì hiển thị icon mặc định
                                    AppVectors.avatar,
                                    width: 150.0,
                                    height: 150.0,
                                  ),
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    width: 150.0,
                                    height: 150.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.white, width: 6),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return SvgPicture.asset(
                                  // Nếu có lỗi thì hiển thị icon mặc định
                                  AppVectors.avatar,
                                  width: 150.0,
                                  height: 150.0,
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
                        Sizedbutton(
                          onPressFun: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditAccountPage(
                                          parrent: widget,
                                        )));
                          },
                          text: 'Cập nhật hồ sơ',
                          backgroundColor: AppColors.cam_main,
                          textColor: Colors.white,
                          width: double.infinity,
                          height: 45,
                        )
                      ]),
                ))
          ],
        ),
      ),
    );
  }
}
