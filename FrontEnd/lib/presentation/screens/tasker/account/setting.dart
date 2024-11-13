import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/common/widgets/button/sizedbutton.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';

import 'package:se121_giupviec_app/data/models/simpleRes_model.dart';
import 'package:se121_giupviec_app/presentation/bloc/Setting/Setting_cubit.dart';

class TaskerSetting extends StatefulWidget {
  final int accountId;
  const TaskerSetting({super.key, required this.accountId});

  @override
  State<TaskerSetting> createState() => _SettingState();
}

class _SettingState extends State<TaskerSetting> {
  bool isExpanded = false;
  late int _selectedRadio; // Biến lưu trạng thái của radio button

  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // Variables to control password visibility
  bool _isOldPasswordVisible = false;
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const BasicAppbar(
          title: Text(
            'Cài đặt',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          isHideBackButton: false,
          isHavePadding: true,
          color: Colors.white,
        ),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ExpansionTile(
              title: Row(
                children: [
                  Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: AppColors.xanh_main, width: 1.5),
                      ),
                      child: const Icon(
                        Icons.key,
                        color: AppColors.xanh_main,
                        size: 30,
                      )),
                  const SizedBox(width: 10),
                  const Text(
                    'Đổi mật khẩu',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      // Old Password TextField with Eye Icon
                      TextField(
                        controller: _oldPasswordController,
                        obscureText: !_isOldPasswordVisible,
                        decoration: InputDecoration(
                          labelText: 'Mật khẩu cũ',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          suffixIcon: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: IconButton(
                              icon: Icon(
                                _isOldPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isOldPasswordVisible =
                                      !_isOldPasswordVisible;
                                });
                              },
                            ),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.xanh_main,
                              width: 2.0,
                            ),
                          ),
                          labelStyle: const TextStyle(
                            color: Colors.grey,
                          ),
                          floatingLabelStyle: const TextStyle(
                            color: AppColors.xanh_main,
                          ),
                          focusColor: AppColors.xanh_main,
                        ),
                        cursorColor: AppColors.xanh_main,
                      ),
                      const SizedBox(height: 15),

                      // New Password TextField with Eye Icon
                      TextField(
                        controller: _newPasswordController,
                        obscureText: !_isNewPasswordVisible,
                        decoration: InputDecoration(
                          labelText: 'Mật khẩu mới',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          suffixIcon: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: IconButton(
                              icon: Icon(
                                _isNewPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isNewPasswordVisible =
                                      !_isNewPasswordVisible;
                                });
                              },
                            ),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.xanh_main,
                              width: 2.0,
                            ),
                          ),
                          labelStyle: const TextStyle(
                            color: Colors.grey,
                          ),
                          floatingLabelStyle: const TextStyle(
                            color: AppColors.xanh_main,
                          ),
                          focusColor: AppColors.xanh_main,
                        ),
                        cursorColor: AppColors.xanh_main,
                      ),
                      const SizedBox(height: 15),

                      // Confirm New Password TextField with Eye Icon
                      TextField(
                        controller: _confirmPasswordController,
                        obscureText: !_isConfirmPasswordVisible,
                        decoration: InputDecoration(
                          labelText: 'Nhập lại mật khẩu mới',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          suffixIcon: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: IconButton(
                              icon: Icon(
                                _isConfirmPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isConfirmPasswordVisible =
                                      !_isConfirmPasswordVisible;
                                });
                              },
                            ),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.xanh_main,
                              width: 2.0,
                            ),
                          ),
                          labelStyle: const TextStyle(
                            color: Colors.grey,
                          ),
                          floatingLabelStyle: const TextStyle(
                            color: AppColors.xanh_main,
                          ),
                          focusColor: AppColors.xanh_main,
                        ),
                        cursorColor: AppColors.xanh_main,
                      ),
                      const SizedBox(height: 10),

                      Sizedbutton(
                        onPressFun: () async {
                          if (_oldPasswordController.text.isEmpty ||
                              _newPasswordController.text.isEmpty ||
                              _confirmPasswordController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: AppColors.cam_main,
                                content: Text('Vui lòng nhập đầy đủ thông tin'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          } else if (_newPasswordController.text.length < 6 ||
                              _confirmPasswordController.text.length < 6) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: AppColors.cam_main,
                                content: Text(
                                    'Mật khẩu phải có độ dài lớn hơn hoặc bằng 6 ký tự'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          } else if (_newPasswordController.text !=
                              _confirmPasswordController.text) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: AppColors.do_main,
                                content: Text('Mật khẩu mới không khớp'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          } else {
                            SimpleResModel sr = await context
                                .read<SettingCubit>()
                                .changePassword(
                                    widget.accountId,
                                    _oldPasswordController.text,
                                    _newPasswordController.text);
                            print(sr.message);

                            if (sr.message == "Ok") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: AppColors.xanh_main,
                                  content: Text('Đổi mật khẩu thành công'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: AppColors.do_main,
                                  content: Text('Mật khẩu cũ không đúng'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          }
                        },
                        height: 45,
                        text: 'Đổi mật khẩu',
                        width: MediaQuery.of(context).size.width,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ]),
        ));
  }
}
