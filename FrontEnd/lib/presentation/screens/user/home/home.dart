import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/common/widgets/search/search.dart';
import 'package:se121_giupviec_app/common/widgets/voucher/voucherList.dart';
import 'package:se121_giupviec_app/core/configs/assets/app_vectors.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_info.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:se121_giupviec_app/presentation/bloc/TaskType/get_all_tasktype_cubit.dart';
import 'package:se121_giupviec_app/presentation/screens/user/home/discovery.dart';

import '../../../../common/widgets/location/default_location.dart';
import '../../../bloc/TaskType/get_all_tasktype_state.dart';
import '../account/location.dart';

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
    final taskTypeCubit =
        BlocProvider.of<TaskTypeCubit>(context).getAllTypeTasks();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
              GestureDetector(
                  onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LocationPage()),
                        )
                      },
                  child: const position()),
              const Padding(
                padding: EdgeInsets.only(
                  left: AppInfo.main_padding,
                  right: AppInfo.main_padding,
                  bottom: 17,
                ),
                child: Search(),
              ),
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
              const SizedBox(
                  height: 95,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: AppInfo.main_padding),
                    child: _services(),
                  )),
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
              const SizedBox(
                  height: 170,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: AppInfo.main_padding),
                    child: Vouchers(),
                  )),
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
    final List<Color> colors = [
      AppColors.cam_main,
      AppColors.xanh_main,
      AppColors.do_main,
      const Color(0xff4B9DCB),
    ];
    return BlocBuilder<TaskTypeCubit, TaskTypeState>(
      builder: (context, state) {
        if (state is TaskLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TaskSuccess) {
          final tasks = state.tasks;
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return _serviceItem(
                  icon: getIcon(task.avatar),
                  title: task.name,
                  color: colors[index % colors.length]);
            },
          );
        } else if (state is TaskError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const Center(child: Text('Không tìm thấy dịch vụ'));
        }
      },
    );
  }

  IconData getIcon(String name) {
    switch (name) {
      case 'broom':
        return FontAwesomeIcons.broom;
      case 'dry_cleaning_rounded':
        return Icons.dry_cleaning_rounded;
      case 'cutlery':
        return FontAwesomeIcons.cutlery;
      case 'local_florist_rounded':
        return Icons.local_florist_rounded;
      case 'bagShopping':
        return FontAwesomeIcons.bagShopping;
      default:
        return Icons.more_horiz;
    }
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
