import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/common/widgets/voucher/voucherList.dart';
import 'package:se121_giupviec_app/core/configs/assets/app_vectors.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_info.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:se121_giupviec_app/presentation/bloc/TaskType/get_all_tasktype_cubit.dart';
import 'package:se121_giupviec_app/presentation/screens/notification/notification.dart';
import 'package:se121_giupviec_app/presentation/screens/user/home/discovery.dart';

import '../../../../common/helpers/SecureStorage.dart';
import '../../../../common/widgets/location/default_location.dart';
import '../../../../domain/entities/location.dart';
import '../../../bloc/Location/location_cubit.dart';
import '../../../bloc/Location/location_state.dart';
import '../../../bloc/TaskType/get_all_tasktype_state.dart';
import '../../../bloc/Voucher/voucher_cubit.dart';
import '../account/location.dart';
import '../activities/newTaskStep1.dart';

class HomePage extends StatefulWidget {
  final int accountId;
  final String userAvatar;
  const HomePage(
      {super.key, required this.accountId, required this.userAvatar});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  SecureStorage secureStorage = SecureStorage();
  Future<String> _fetchUserId() async {
    String id = await secureStorage.readId();
    return id;
  }

  List<Location>? locations;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    BlocProvider.of<TaskTypeCubit>(context).getAllTypeTasks();
    BlocProvider.of<VoucherCubit>(context).getAllVoucher(0);
    _fetchUserId().then((value) {
      BlocProvider.of<LocationCubit>(context).getMyLocation(int.parse(value));
    });
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
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NotificationScreen(
                        userId: widget.accountId,
                      )),
            );
          },
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
                              builder: (context) => LocationPage(
                                    userAvatar: widget.userAvatar,
                                  )),
                        )
                      },
                  child: const position()),
              const SizedBox(
                height: 16,
              ),
              const _banner(),
              const SizedBox(
                height: 16,
              ),
              BlocBuilder<LocationCubit, LocationState>(
                builder: (context, state) {
                  if (state is LocationLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is LocationSuccess) {
                    locations = state.locations;
                    return const SizedBox();
                  } else if (state is LocationError) {
                    return const Center(child: SizedBox());
                  } else {
                    return const Center(child: SizedBox());
                  }
                },
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
              SizedBox(
                  height: 95,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppInfo.main_padding),
                    child: _services(locations: locations ?? []),
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

class _services extends StatefulWidget {
  final List<Location> locations;

  const _services({Key? key, required this.locations}) : super(key: key);

  @override
  State<_services> createState() => _servicesState();
}

class _servicesState extends State<_services> {
  SecureStorage secureStorage = SecureStorage();
  Future<String> _fetchUserId() async {
    String id = await secureStorage.readId();
    return id;
  }

  int? userId;
  @override
  void initState() {
    super.initState();
    _fetchUserId().then((value) {
      setState(() {
        userId = int.parse(value);
      });
    });
  }

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
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Newtaskstep1(
                              taskTypeId: task.id,
                              userId: userId!,
                            )),
                  );
                  // if (widget.locations.length > 0) {

                  // } else {
                  //   showDialog(
                  //       context: context,
                  //       builder: (BuildContext context) {
                  //         return AlertDialog(
                  //           title: Text('Thông báo'),
                  //           content: Text(
                  //               'Vui lòng thêm địa chỉ trước khi chọn dịch vụ'),
                  //           actions: <Widget>[
                  //             TextButton(
                  //               onPressed: () {
                  //                 Navigator.of(context).pop();
                  //               },
                  //               child: Text('OK'),
                  //             ),
                  //           ],
                  //         );
                  //       });
                  // }
                },
                child: _serviceItem(
                    icon: getIcon(task.avatar ?? ''),
                    title: task.name,
                    color: colors[index % colors.length]),
              );
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
  const _banner();

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(height: 150.0, autoPlay: true),
      items: [1, 2, 3, 4, 5].map((index) {
        final String img = 'assets/images/album$index.jpg';
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
