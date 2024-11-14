import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:se121_giupviec_app/core/configs/assets/app_vectors.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';

import 'package:se121_giupviec_app/presentation/screens/user/message/message.dart';
import 'package:se121_giupviec_app/presentation/screens/tasker/activities/activity.dart';
import 'package:se121_giupviec_app/presentation/screens/tasker/home/home.dart';

import '../../../common/helpers/SecureStorage.dart';
import '../tasker/account/account.dart';

class TaskerNavigation extends StatefulWidget {
  final int? tab;
  int? userId;

  TaskerNavigation({super.key, this.tab, this.userId});

  @override
  State<TaskerNavigation> createState() => _TaskerNavigationState();
}

class _TaskerNavigationState extends State<TaskerNavigation> {
  int currentPageIndex = 0;
  int userIdd = 0;
  String userAvatar = '';
  String userName = '';
  Future<void> userID() async {
    final id = await SecureStorage().readId();
    final name = await SecureStorage().readName();
    final avatar = await SecureStorage().readAvatar();

    setState(() async {
      userIdd = int.parse(id);
      userName = name;
      userAvatar = avatar;
    });
  }

  Future<void> fetchUserId() async {
    final id = await SecureStorage().readId();
    setState(() {
      userIdd = int.parse(id);
    });
  }

  @override
  void initState() {
    super.initState();

    userID();
    if (widget.userId == null) {
      widget.userId = userIdd;
    }

    currentPageIndex = widget.tab ?? 0;
  }

  SecureStorage secureStorage = SecureStorage();

  @override
  Widget build(BuildContext context) {
    print("trước khi vào");
    print(userIdd);
    return Scaffold(
        bottomNavigationBar: _navigationBar(),
        body: [
          TaskerHomePage(
            accountId: widget.userId!,
            accountName: userName,
          ),
          TaskerActivityPage(
            userId: widget.userId!,
          ),
          const MessagePage(),
          AccountTaskerPage(
            userId: widget.userId!,
            userAvatar: userAvatar,
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
              color: AppColors.cam_main,
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
              color: AppColors.cam_main,
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
              color: AppColors.cam_main,
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
              color: AppColors.cam_main,
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
