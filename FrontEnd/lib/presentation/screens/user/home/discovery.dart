import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/common/widgets/search/search.dart';
import 'package:se121_giupviec_app/common/widgets/voucher/voucherList.dart';
import 'package:se121_giupviec_app/core/configs/assets/app_images.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_info.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';

import '../../../../common/helpers/SecureStorage.dart';
import '../../../bloc/Voucher/voucher_cubit.dart';
import '../../../bloc/Voucher/voucher_state.dart';

class DiscoveryPage extends StatefulWidget {
  const DiscoveryPage({super.key});

  @override
  State<DiscoveryPage> createState() => _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    BlocProvider.of<VoucherCubit>(context).getAllVoucher(0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
      ),
      Container(
        height: 106,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppImages.discoveryBanner),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
      Scaffold(
        backgroundColor: Colors.transparent, // Đặt nền của Scaffold trong suốt

        appBar: BasicAppbar(
          otherBackButton: true,
          title: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 4, bottom: 4),
              child: Text('Khám phá',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ),
          isHideBackButton: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(AppInfo.main_padding),
          child: SingleChildScrollView(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _financeCard(),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Expanded(
                          child: Search(
                        hint: "Tìm kiếm ưu đãi",
                      )),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return SizedBox(
                                height: 150,
                                child: Padding(
                                  padding: const EdgeInsets.all(
                                      AppInfo.main_padding),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        ListTile(
                                          leading: const Icon(
                                            Icons.arrow_circle_up,
                                            color: AppColors.xanh_main,
                                          ),
                                          title: const Text(
                                              'Tăng dần theo RPoints'),
                                          onTap: () {
                                            BlocProvider.of<VoucherCubit>(
                                                    context)
                                                .getAllVoucher(1);
                                            Navigator.pop(context);
                                          },
                                        ),
                                        const Divider(),
                                        ListTile(
                                          leading: const Icon(
                                            Icons.arrow_circle_down,
                                            color: AppColors.xanh_main,
                                          ),
                                          title: const Text(
                                              'Giảm dần theo RPoints'),
                                          onTap: () {
                                            BlocProvider.of<VoucherCubit>(
                                                    context)
                                                .getAllVoucher(2);
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => FilterPage()));
                        },
                        child: const Icon(
                          Icons.filter_alt_rounded,
                          color: AppColors.xanh_main,
                          size: 35,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Ưu đãi',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  const SizedBox(
                      height: 170,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppInfo.main_padding),
                        child: Vouchers(),
                      )),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'Sắp hết hạn',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  const SizedBox(
                      height: 170,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppInfo.main_padding),
                        child: Vouchers(isNearToExpire: true),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}

class _financeCard extends StatefulWidget {
  const _financeCard();

  @override
  State<_financeCard> createState() => _financeCardState();
}

class _financeCardState extends State<_financeCard> {
  SecureStorage secureStorage = SecureStorage();
  Future<Map<String, String>> _fetchUserData() async {
    String Rpoints = await secureStorage.readRpoints();
    return {'Rpoints': Rpoints};
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FutureBuilder<Map<String, String>>(
            future: _fetchUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final userData = snapshot.data!;
                return _finaceChild(
                  icon: const Icon(
                    FontAwesomeIcons.coins,
                    color: AppColors.cam_main,
                    size: 25,
                  ),
                  title: 'RPoint',
                  value: int.parse(userData['Rpoints']!),
                );
              }
            },
          ),
          BlocBuilder<VoucherCubit, VoucherState>(
            builder: (context, state) {
              if (state is VoucherLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is VoucherSuccess) {
                final vouchers = state.vouchers;
                return _finaceChild(
                  icon: const Icon(
                    FontAwesomeIcons.gift,
                    color: AppColors.cam_main,
                    size: 25,
                  ),
                  title: 'Mã giảm giá',
                  value: vouchers.length,
                );
              } else if (state is VoucherError) {
                return Center(child: Text('Error: ${state.message}'));
              } else {
                return const Center(child: Text('Không tìm thấy voucher'));
              }

              // return const _finaceChild(
              //   icon: Icon(
              //     FontAwesomeIcons.gift,
              //     color: AppColors.cam_main,
              //     size: 25,
              //   ),
              //   title: 'Mã giảm giá',
              //   value: 100,
              // );
            },
          )
        ],
      ),
    );
  }
}

class _finaceChild extends StatelessWidget {
  final Icon icon;
  final String title;
  final int value;
  const _finaceChild({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                value.toString(),
                style: const TextStyle(
                  color: AppColors.cam_main,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
