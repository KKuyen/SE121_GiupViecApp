import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_info.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';

import '../../../core/configs/assets/app_images.dart';

class EditAccountPage extends StatefulWidget {
  const EditAccountPage({super.key});

  @override
  State<EditAccountPage> createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _openCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // Xử lý ảnh đã chụp
      print('Image path: ${image.path}');
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
                                  child: const CircleAvatar(
                                    radius: 50,
                    
                                    backgroundImage: AssetImage(AppImages.voucher1),
                                  ),
                                ),
                              ),
                              Positioned(child: Container(
                                margin: const EdgeInsets.only(top: 90, left: 90),
                                child: GestureDetector(
                                  onTap: () {_openCamera();},
                                  child: Container(
                                    width: 35,
                                    height: 35,
                                    decoration:  BoxDecoration(
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
                            fontSize:18,
                            fontWeight: FontWeight.bold,
                          ),
                    
                        ),
                        const TextField(
                          decoration: InputDecoration(
                            hintText: "Họ và tên",
                            border: InputBorder.none,
                          ),
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
                        const TextField(
                          decoration: InputDecoration(
                            hintText: "Số điện thoại",
                            border: InputBorder.none,
                          ),
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
                        const TextField(
                          decoration: InputDecoration(
                            hintText: "Email",
                            border: InputBorder.none,
                          ),
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
                  children: [ Container(
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
                      onPressed: () {},
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
                    Container(
                      width: double.infinity,
                      height: 45,
                      decoration: BoxDecoration(
                        color: AppColors.xanh_main,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Cập nhật',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),],
                )

              ],
            ),
        ),
      

    );
  }
}
