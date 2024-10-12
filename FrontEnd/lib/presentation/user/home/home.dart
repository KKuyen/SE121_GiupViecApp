import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/common/widgets/voucher/voucherList.dart';
import 'package:se121_giupviec_app/core/configs/assets/app_images.dart';
import 'package:se121_giupviec_app/core/configs/assets/app_vectors.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_info.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:se121_giupviec_app/presentation/user/home/discovery.dart';

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
          height: 20,
        ),
        isHideBackButton: true,
        action: IconButton(
          icon: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.05), shape: BoxShape.circle),
            child: const Icon(
              FontAwesomeIcons.solidBell,
              size: 25,
              color: AppColors.cam_main,
            ),
          ),
          onPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const _position(),
              const _search(),
              const _banner(),
              const SizedBox(
                height: 16,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: AppInfo.main_padding),
                  child: Text(
                    'Dịch vụ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const _services(),
              const SizedBox(
                height: 19,
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: AppInfo.main_padding),
                    child: Text(
                      'Ưu đãi',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DiscoveryPage()),
                        );
                      },
                      child: const Text(
                        'Khám phá',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.cam_main),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppInfo.main_padding),
                child: Vouchers(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _services extends StatelessWidget {
  const _services({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: AppInfo.main_padding),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _serviceItem(
              icon: FontAwesomeIcons.solidClock,
              title: 'Giúp việc theo giờ',
              color: AppColors.cam_main,
            ),
            _serviceItem(
              icon: FontAwesomeIcons.solidCalendarCheck,
              title: 'Giúp việc định kì',
              color: AppColors.xanh_main,
            ),
            _serviceItem(
              icon: FontAwesomeIcons.babyCarriage,
              title: 'Trông trẻ',
              color: AppColors.do_main,
            ),
            _serviceItem(
              icon: FontAwesomeIcons.broom,
              title: 'Dọn nhà',
              color: Color(0xff4B9DCB),
            ),
            _serviceItem(
              icon: FontAwesomeIcons.faucet,
              title: 'Sửa ống nước',
              color: AppColors.cam_main,
            ),
          ],
        ),
      ),
    );
  }
}

class _serviceItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  const _serviceItem({
    required this.icon,
    required this.title,
    required this.color,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        height: 90,
        width: 80,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 13),
          child: Column(
            children: [
              Icon(icon, size: 25, color: Colors.white),
              const SizedBox(
                height: 8,
              ),
              Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 13),
                softWrap: true,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _banner extends StatelessWidget {
  const _banner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(height: 150.0, autoPlay: true),
      items: [1, 2, 3, 4, 5].map((index) {
        final String img = 'assets/images/album${index}.jpg';
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(img), fit: BoxFit.cover),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
            );
          },
        );
      }).toList(),
    );
  }
}

class _search extends StatelessWidget {
  const _search({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(
        left: AppInfo.main_padding,
        right: AppInfo.main_padding,
        bottom: 17,
      ),
      child: TextField(
        decoration: InputDecoration(
            hintText: 'Tìm kiếm dịch vụ',
            prefixIcon: Icon(
              CupertinoIcons.search,
              color: AppColors.xanh_main,
              size: 30,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            )),
      ),
    );
  }
}

class _position extends StatelessWidget {
  const _position({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
          height: 47,
          width: 47,
          decoration: const BoxDecoration(
              color: AppColors.xanh_main, shape: BoxShape.circle),
          child: const Icon(
            Icons.location_on,
            color: Colors.white,
            size: 27,
          )),
      title: const Text(
        'TP. Hồ  Chí Minh',
        style: TextStyle(fontSize: 15),
      ),
      subtitle:
          const Text('BTM Layout, 500628', style: TextStyle(fontSize: 13)),
      trailing: const Icon(
        Icons.navigate_next_outlined,
      ),
    );
  }
}
