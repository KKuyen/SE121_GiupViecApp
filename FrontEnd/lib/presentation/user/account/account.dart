import 'package:flutter/material.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/common/widgets/button/sizedbutton.dart';
import 'package:se121_giupviec_app/core/configs/assets/app_images.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_info.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:se121_giupviec_app/presentation/user/account/location.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
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
                  height: 130,
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
                    height: 300,
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
                                      builder: (context) =>
                                          const LocationPage()));
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
                            onTap: () {},
                          ),
                          const Divider(
                            height: 1,
                            thickness: 1,
                          ),
                          ListTile(
                            title: const Text('Danh sách chặn'),
                            leading: const Icon(Icons.block_outlined),
                            trailing: const Icon(Icons.navigate_next_rounded),
                            onTap: () {},
                          ),
                          const Divider(
                            height: 1,
                            thickness: 1,
                          ),
                          ListTile(
                            title: const Text('Ưu đãi của tôi'),
                            leading: const Icon(Icons.wallet_giftcard_sharp),
                            trailing: const Icon(Icons.navigate_next_rounded),
                            onTap: () {},
                          ),
                          const Divider(
                            height: 1,
                            thickness: 1,
                          ),
                          ListTile(
                            title: const Text('Chia sẻ'),
                            leading: const Icon(Icons.share_outlined),
                            trailing: const Icon(Icons.navigate_next_rounded),
                            onTap: () {},
                          ),
                          const Divider(
                            height: 1,
                            thickness: 1,
                          ),
                          ListTile(
                            title: const Text('Trợ giúp'),
                            leading: const Icon(Icons.help_outline_rounded),
                            trailing: const Icon(Icons.navigate_next_rounded),
                            onTap: () {},
                          ),
                          const Divider(
                            height: 1,
                            thickness: 1,
                          ),
                          ListTile(
                            title: const Text('Cài đặt'),
                            leading: const Icon(Icons.settings_outlined),
                            trailing: const Icon(Icons.navigate_next_rounded),
                            onTap: () {},
                          ),
                          const Divider(
                            height: 1,
                            thickness: 1,
                          ),
                          ListTile(
                            title: const Text('Đăng xuất'),
                            leading: const Icon(Icons.logout),
                            onTap: () {},
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
                          child: const CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage(AppImages.voucher1),
                          ),
                        ),
                        const SizedBox(height: 7),
                        const Text(
                          'Nguyễn Văn A',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          '0345678901',
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Sizedbutton(
                          onPressFun: () {},
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
