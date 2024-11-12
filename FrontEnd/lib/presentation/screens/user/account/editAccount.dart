import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/common/widgets/button/sizedbutton.dart';
import 'package:se121_giupviec_app/core/configs/assets/app_images.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_info.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:se121_giupviec_app/presentation/bloc/Auth/auth_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/Auth/auth_state.dart';
import 'package:se121_giupviec_app/presentation/screens/user/account/account.dart';

import '../../../../common/helpers/SecureStorage.dart';
import '../../../../core/firebase/firebase_image.dart';
import '../../auth/signin-page.dart';

class EditAccountPage extends StatefulWidget {
  final AccountPage parrent;
  EditAccountPage({required this.parrent, super.key});

  @override
  State<EditAccountPage> createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
  SecureStorage secureStorage = SecureStorage();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  int? userId;
  File? image;
  //"assets/images/avatar.png"
  String pushImages = "";
  final ImagePicker _picker = ImagePicker(); // Khởi tạo ImagePicker

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

// Hàm chọn ảnh từ thư viện
  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        image = (File(pickedFile.path)); // Thêm ảnh vào danh sách
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
                    const SizedBox(height: 20),
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
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    500), // Bo góc cho ảnh
                                child: image != null
                                    ? Image.file(
                                        image!,
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit
                                            .cover, // Đảm bảo ảnh bao phủ toàn bộ container
                                      )
                                    : Image.asset(
                                        AppImages.avatar, // Placeholder image
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                          ),
                          Positioned(
                              child: Container(
                            margin: const EdgeInsets.only(top: 90, left: 90),
                            child: GestureDetector(
                              onTap: () {
                                _pickImage();
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
                    const SizedBox(height: 30),
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
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: AppColors.do_main,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          TextEditingController _passwordController =
                              TextEditingController();
                          return AlertDialog(
                            title: const Text('Xác nhận xóa tài khoản'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                    'Vui lòng nhập mật khẩu để xác nhận xóa tài khoản.'),
                                TextField(
                                  controller: _passwordController,
                                  decoration: const InputDecoration(
                                    hintText: 'Mật khẩu',
                                  ),
                                  obscureText: true,
                                ),
                              ],
                            ),
                            actions: [
                              Sizedbutton(
                                onPressFun: () {
                                  Navigator.of(context).pop();
                                },
                                text: "Hủy",
                                StrokeColor: AppColors.cam_main,
                                backgroundColor: Colors.white,
                                textColor: AppColors.cam_main,
                                isStroke: true,
                              ),
                              Sizedbutton(
                                onPressFun: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignInPage()));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text('Xóa tài khoản thành công'),
                                    backgroundColor: AppColors.xanh_main,
                                  ));
                                },
                                text: "Xác nhận",
                                backgroundColor: AppColors.do_main,
                              )
                            ],
                          );
                        },
                      );
                    },
                    child: const Text(
                      'Xóa tài khoản',
                      style: TextStyle(
                        color: AppColors.do_main,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
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
                      color: AppColors.xanh_main,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextButton(
                      onPressed: () async {
                        BlocProvider.of<AuthCubit>(context).editProfile(
                          userId!,
                          _nameController.text,
                          _emailController.text,
                          _phoneNumberController.text,
                          'avatar',
                        );
                        await FirebaseImageService().uploadImage(image!);
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
