import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/common/widgets/button/sizedbutton.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_info.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:se121_giupviec_app/presentation/bloc/Auth/auth_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/Auth/auth_state.dart';
import 'package:se121_giupviec_app/presentation/screens/tasker/account/account.dart';

import '../../../../common/helpers/SecureStorage.dart';
import '../../../../core/configs/assets/app_images.dart';

class EditAccountTaskerPage extends StatefulWidget {
  final AccountTaskerPage parrent;
  EditAccountTaskerPage({required this.parrent, super.key});

  @override
  State<EditAccountTaskerPage> createState() => _EditAccountTaskerPageState();
}

class _EditAccountTaskerPageState extends State<EditAccountTaskerPage> {
  final ImagePicker _picker = ImagePicker();
  SecureStorage secureStorage = SecureStorage();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _gioiThieuController = TextEditingController();

  TextEditingController _emailController = TextEditingController();
  String? _imagePath;
  int? userId;

  Future<Map<String, String>> _fetchUserData() async {
    String id = await secureStorage.readId();
    String name = await secureStorage.readName();
    String phoneNumber = await secureStorage.readPhoneNumber();
    String email = await secureStorage.readEmail();
    String avatar = await secureStorage.readAvatar();
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'avatar': avatar
    };
  }

  Future<void> _openCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imagePath = image.path;
      });
    }
  }

  @override
  void initState() {
    _fetchUserData().then((value) {
      userId = int.parse(value['id']!);
      _nameController.text = value['name']!;
      _phoneNumberController.text = value['phoneNumber']!;
      _emailController.text = value['email']!;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(
        isHideBackButton: false,
        isHavePadding: false,
        title: Text('Cập nhật hồ sơ',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppInfo.main_padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          Positioned(
                            child: Container(
                              width:
                                  130, // Kích thước của Container bao quanh CircleAvatar
                              height: 130,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.grey, // Màu viền
                                  width: 3.0, // Độ dày của viền
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage: _imagePath != null
                                    ? FileImage(File(_imagePath!))
                                    : const AssetImage(AppImages.voucher1)
                                        as ImageProvider,
                                onBackgroundImageError: (_, __) {
                                  // setState(() {
                                  //   _imagePath = null;
                                  // });
                                },
                              ),
                            ),
                          ),
                          Positioned(
                              child: Container(
                            margin: const EdgeInsets.only(top: 90, left: 90),
                            child: GestureDetector(
                              onTap: () {
                                _openCamera();
                              },
                              child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.grey, // Màu viền
                                    width: 1.0, // Độ dày của viền
                                  ),
                                ),
                                child: const Icon(
                                  Icons.camera_alt,
                                  color: AppColors.xanh_main,
                                ),
                              ),
                            ),
                          )),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Giới thiệu',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      decoration: const InputDecoration(
                        hintText: "Giới thiệu",
                        border: InputBorder.none,
                      ),
                      controller: _gioiThieuController,
                    ),
                    const Divider(
                      height: 1,
                      thickness: 1,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Họ và tên',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      decoration: const InputDecoration(
                        hintText: "Họ và tên",
                        border: InputBorder.none,
                      ),
                      controller: _nameController,
                    ),
                    const Divider(
                      height: 1,
                      thickness: 1,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Số điện thoại',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      decoration: const InputDecoration(
                        hintText: "Số điện thoại",
                        border: InputBorder.none,
                      ),
                      controller: _phoneNumberController,
                    ),
                    const Divider(
                      height: 1,
                      thickness: 1,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      decoration: const InputDecoration(
                        hintText: "Email",
                        border: InputBorder.none,
                      ),
                      controller: _emailController,
                    ),
                    const Divider(
                      height: 1,
                      thickness: 1,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text(
                          'Công việc',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Chọn công việc'),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          CheckboxListTile(
                                            title: const Text('Lau nhà'),
                                            value: false,
                                            onChanged: (bool? value) {
                                              // Handle change
                                            },
                                          ),
                                          CheckboxListTile(
                                            title: const Text('Nấu ăn'),
                                            value: false,
                                            onChanged: (bool? value) {
                                              // Handle change
                                            },
                                          ),
                                          CheckboxListTile(
                                            title: const Text('Lau nhà'),
                                            value: false,
                                            onChanged: (bool? value) {
                                              // Handle change
                                            },
                                          ),
                                          CheckboxListTile(
                                            title: const Text('Nấu ăn'),
                                            value: false,
                                            onChanged: (bool? value) {
                                              // Handle change
                                            },
                                          ),
                                          CheckboxListTile(
                                            title: const Text('Lau nhà'),
                                            value: false,
                                            onChanged: (bool? value) {
                                              // Handle change
                                            },
                                          ),
                                          CheckboxListTile(
                                            title: const Text('Nấu ăn'),
                                            value: false,
                                            onChanged: (bool? value) {
                                              // Handle change
                                            },
                                          ),
                                          // Add more CheckboxListTile as needed
                                        ],
                                      ),
                                    ),
                                    actions: <Widget>[
                                      Sizedbutton(
                                        onPressFun: () {
                                          Navigator.of(context).pop();
                                        },
                                        text: "Hủy",
                                        isStroke: true,
                                        textColor: AppColors.cam_main,
                                        StrokeColor: AppColors.cam_main,
                                        backgroundColor: Colors.white,
                                      ),
                                      Sizedbutton(
                                        onPressFun: () {
                                          Navigator.of(context).pop();
                                        },
                                        text: "Xác nhận",
                                        backgroundColor: AppColors.cam_main,
                                        textColor: Colors.white,
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                            child: const Text(
                              'Chỉnh sửa',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.cam_main),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const _congViecList(),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                BlocListener<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthResponseSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Cập nhật thành công'),
                          backgroundColor: AppColors.xanh_main,
                        ),
                      );
                      secureStorage.writeName(_nameController.text);
                      secureStorage
                          .writePhoneNumber(_phoneNumberController.text);
                      secureStorage.writeEmail(_emailController.text);
                    } else if (state is AuthError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                          backgroundColor: AppColors.do_main,
                        ),
                      );
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                      color: AppColors.cam_main,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextButton(
                      onPressed: () {
                        BlocProvider.of<AuthCubit>(context).editProfile(
                          userId!,
                          _nameController.text,
                          _emailController.text,
                          _phoneNumberController.text,
                          'avatar',
                        );
                      },
                      child: const Text(
                        'Cập nhật',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _congViecList extends StatelessWidget {
  const _congViecList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      children: [
        _congViecCard(title: "Lau nhà"),
        _congViecCard(title: "Lau nhà"),
        _congViecCard(title: "Lau nhà"),
        _congViecCard(title: "Lau nhà"),
        _congViecCard(title: "Lau nhà"),
        _congViecCard(title: "Lau nhà"),
        _congViecCard(title: "Lau nhà"),
        _congViecCard(title: "Lau nhà"),
        _congViecCard(title: "Lau nhà"),
      ],
    );
  }
}

class _congViecCard extends StatelessWidget {
  final String title;
  const _congViecCard({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 6, bottom: 8),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(title,
              style: const TextStyle(fontSize: 16, color: AppColors.cam_main)),
        ),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.cam_main),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
