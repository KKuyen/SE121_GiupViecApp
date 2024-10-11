import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:se121_giupviec_app/core/configs/assets/app_vectors.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:se121_giupviec_app/presentation/user/home/home.dart';
import 'package:se121_giupviec_app/presentation/user/activities/activity.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: _navigationBar(),
        body: [
          const HomePage(),
          const ActivityPage(),
          // const MessagePage(),
          // const Profile(),
          Container(),
          Container(),
          Container(),
        ][currentPageIndex]);
  }

  Widget _navigationBar() {
    return NavigationBar(
      onDestinationSelected: (int index) {
        setState(() {
          currentPageIndex = index;
        });
      },
      height: 60,
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
              height: 44,
              width: 45,
            ),
          ),
          icon: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: SvgPicture.asset(
              AppVectors.navi_home_icon,
              height: 27,
              width: 27,
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
              height: 44,
              width: 45,
            ),
          ),
          icon: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: SvgPicture.asset(
              AppVectors.navi_activity_icon,
              height: 27,
              width: 27,
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
              height: 44,
              width: 45,
            ),
          ),
          icon: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: SvgPicture.asset(
              AppVectors.navi_message_icon,
              height: 27,
              width: 27,
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
              height: 44,
              width: 45,
            ),
          ),
          icon: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: SvgPicture.asset(
              AppVectors.navi_profile_icon,
              height: 27,
              width: 27,
            ),
          ),
          label: '',
        ),
      ],
      selectedIndex: currentPageIndex,
    );
  }
}
