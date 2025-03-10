import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:se121_giupviec_app/core/configs/assets/app_vectors.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';

import 'package:se121_giupviec_app/presentation/screens/user/account/account.dart';
import 'package:se121_giupviec_app/presentation/screens/user/home/home.dart';
import 'package:se121_giupviec_app/presentation/screens/user/activities/activity.dart';
import 'package:se121_giupviec_app/presentation/screens/user/message/message.dart';

import '../../../common/helpers/SecureStorage.dart';

class Navigation extends StatefulWidget {
  final int? tab;
  final int? userId;
  const Navigation({super.key, this.tab, this.userId});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int userId = 0;
  String Useravatar = "";
  Future<void> userID() async {
    final id = await SecureStorage().readId();
    final avatar = await SecureStorage().readAvatar();
    print("id nef");
    print(id);
    setState(() {
      userId = int.parse(id);
      Useravatar = avatar;
    });
  }

  int currentPageIndex = 0;
  @override
  void initState() {
    super.initState();
    userId = widget.userId ?? 0;
    userID();
    currentPageIndex = widget.tab ?? 0;
  }

  SecureStorage secureStorage = SecureStorage();
  void _printUser() async {
    String? id = await secureStorage.readId();
    String? email = await secureStorage.readEmail();
    String? Rpoints = await secureStorage.readRpoints();
    String? name = await secureStorage.readName();
    String? avatar = await secureStorage.readAvatar();

    print("Data from local: ${id}");
    print("Data from local: ${email}");
    print("Data from local: ${Rpoints}");
    print("Data from local: ${name}");
    print("Data from local: ${avatar}");
  }

  @override
  Widget build(BuildContext context) {
    print(" trước khi  print userId");
    print(userId);
    _printUser();
    return Scaffold(
        bottomNavigationBar: _navigationBar(),
        body: [
          HomePage(
            accountId: userId,
            userAvatar: Useravatar,
          ),
          ActivityPage(
            allUserId: userId,
          ),
          const MessagePage(),
          AccountPage(
            userId: userId,
            Useravatar: Useravatar,
          ),
        ][currentPageIndex]);
  }

  Widget _navigationBar() {
    return NavigationBar(
      onDestinationSelected: (int index) {
        setState(() {
          currentPageIndex = index;
        });
      },
      height: 56,
      backgroundColor: Colors.white,
      indicatorColor: Colors.transparent,
      // indicatorShape: const Border(
      //   top: BorderSide(
      //     color: AppColors.xanh_main,
      //     width: 4,
      //   ),
      // ),
      destinations: [
        NavigationDestination(
          selectedIcon: Padding(
            padding: const EdgeInsets.only(top: 3),
            child: SvgPicture.asset(
              AppVectors.navi_home_icon_selected,
              height: 40,
              width: 41,
            ),
          ),
          icon: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: SvgPicture.asset(
              AppVectors.navi_home_icon,
              height: 23,
              width: 23,
            ),
          ),
          label: '',
        ),
        NavigationDestination(
          selectedIcon: Padding(
            padding: const EdgeInsets.only(top: 3),
            child: SvgPicture.asset(
              AppVectors.navi_activity_icon_selected,
              color: AppColors.xanh_main,
              height: 40,
              width: 41,
            ),
          ),
          icon: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: SvgPicture.asset(
              AppVectors.navi_activity_icon,
              height: 23,
              width: 23,
            ),
          ),
          label: '',
        ),
        NavigationDestination(
          selectedIcon: Padding(
            padding: const EdgeInsets.only(top: 3),
            child: SvgPicture.asset(
              AppVectors.navi_message_icon_selected,
              color: AppColors.xanh_main,
              height: 40,
              width: 41,
            ),
          ),
          icon: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: SvgPicture.asset(
              AppVectors.navi_message_icon,
              height: 23,
              width: 23,
            ),
          ),
          label: '',
        ),
        NavigationDestination(
          selectedIcon: Padding(
            padding: const EdgeInsets.only(top: 3),
            child: SvgPicture.asset(
              AppVectors.navi_profile_icon_selected,
              color: AppColors.xanh_main,
              height: 40,
              width: 41,
            ),
          ),
          icon: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: SvgPicture.asset(
              AppVectors.navi_profile_icon,
              height: 23,
              width: 23,
            ),
          ),
          label: '',
        ),
      ],
      selectedIndex: currentPageIndex,
    );
  }
}
