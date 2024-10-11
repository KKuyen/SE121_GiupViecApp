import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/core/configs/assets/app_vectors.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 22,
        ),
        isHideBackButton: true,
        action: IconButton(
          icon: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.05), shape: BoxShape.circle),
            child: const Icon(
              Icons.notifications,
              size: 25,
              color: AppColors.cam_main,
            ),
          ),
          onPressed: () {},
        ),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
