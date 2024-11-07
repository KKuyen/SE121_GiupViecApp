import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/common/widgets/button/sizedbutton.dart';
import 'package:se121_giupviec_app/core/configs/assets/app_images.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_info.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:se121_giupviec_app/presentation/bloc/Location/location_cubit.dart';
import 'package:se121_giupviec_app/presentation/screens/user/account/addLocation.dart';

import '../../../../common/helpers/SecureStorage.dart';
import '../../../../domain/entities/location.dart';
import '../../../bloc/Location/delete_location_cubit.dart';
import '../../../bloc/Location/location_state.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  SecureStorage secureStorage = SecureStorage();
  Future<Map<String, String>> _fetchUserData() async {
    String name = await secureStorage.readName();
    String phoneNumber = await secureStorage.readPhoneNumber();
    return {'name': name, 'phoneNumber': phoneNumber};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: const BasicAppbar(
        isHideBackButton: false,
        isHavePadding: false,
        title: Text('Địa chỉ',
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
                    height: 130,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: AppInfo.main_padding),
                          child: Text(
                            'Vị trí đã lưu',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => const DiscoveryPage()),
                              // );
                            },
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AddLocationPage()),
                                );
                              },
                              child: const Text(
                                '+ Thêm địa chỉ',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.cam_main),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const listLocation(),
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
                      ]),
                ))
          ],
        ),
      ),
    );
  }
}

class listLocation extends StatefulWidget {
  const listLocation({
    super.key,
  });

  @override
  State<listLocation> createState() => _listLocationState();
}

class _listLocationState extends State<listLocation> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<LocationCubit>(context).getMyLocation(1);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, state) {
        if (state is LocationLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is LocationSuccess) {
          final locations = state.locations;
          return Container(
              height: MediaQuery.of(context).size.height - 400,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: locations.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        _addressCard(location: locations[index]),
                        const Divider(
                          height: 1,
                          thickness: 1,
                        ),
                      ],
                    );
                  }));
        } else if (state is LocationError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const Center(child: Text('Không tìm thấy địa chỉ'));
        }
      },
    );
  }
}

class _addressCard extends StatelessWidget {
  Location location;
  _addressCard({
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        location.ownerName,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              "${location.map}, ${location.detailAddress}, ${location.district}, ${location.province}, ${location.country}"),
          Text(location.ownerPhoneNumber),
        ],
      ),
      trailing: const Icon(
        FontAwesomeIcons.trashAlt,
        color: AppColors.do_main,
      ),
      onTap: () {
        _showDialog(context, location.id);
      },
    );
  }

  void _showDialog(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Xác nhận'),
          content: const Text('Bạn muốn xóa địa chỉ này?'),
          actions: <Widget>[
            Sizedbutton(
              onPressFun: () {
                Navigator.of(context).pop(); // Đóng dialog
              },
              text: 'Hủy',
              backgroundColor: Colors.white,
              StrokeColor: AppColors.do_main,
              isStroke: true,
              textColor: AppColors.do_main,
            ),
            Sizedbutton(
              onPressFun: () {
                context
                    .read<DeleteLocationCubit>()
                    .deleteLocation(id); // Gọi hàm deleteLocation
                Navigator.of(context).pop(); // Đóng dialog
                Navigator.of(context).pop();
                Future.delayed(const Duration(seconds: 2));
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LocationPage()),
                );
              },
              text: 'Xóa',
              backgroundColor: AppColors.do_main,
            ),
          ],
        );
      },
    );
  }
}
