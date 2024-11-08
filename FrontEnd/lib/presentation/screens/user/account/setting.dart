import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/common/widgets/button/sizedbutton.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:se121_giupviec_app/data/models/setting_model.dart';
import 'package:se121_giupviec_app/data/models/simpleRes_model.dart';
import 'package:se121_giupviec_app/presentation/bloc/Setting/Setting_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/Setting/Setting_state.dart';
import 'package:se121_giupviec_app/presentation/bloc/tasker/tasker_cubit.dart';
import 'package:se121_giupviec_app/presentation/screens/user/activities/newReview.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool isExpanded = false;
  late int _selectedRadio; // Biến lưu trạng thái của radio button
  final int _selectedNumber = 1; // Biến lưu giá trị số từ 1 đến 5
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // Variables to control password visibility
  bool _isOldPasswordVisible = false;
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  late bool autoAcceptStatus;
  late bool loveTaskerOnly;
  late int upperStar;
  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    SettingModel sm = await BlocProvider.of<SettingCubit>(context).Success(1);
    setState(() {
      autoAcceptStatus = sm.autoAcceptStatus;
      loveTaskerOnly = sm.loveTaskerOnly;
      upperStar = sm.upperStar;
      if (loveTaskerOnly) {
        _selectedRadio = 1;
      } else {
        _selectedRadio = 2;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingCubit, SettingState>(
      builder: (context, state) {
        if (state is SettingLoading) {
          return Center(
            child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                ),
                child: Center(
                    child: SizedBox(
                        height: 40,
                        width: 40,
                        child: const CircularProgressIndicator()))),
          );
        } else if (state is SettingSuccess) {
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
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ExpansionTile(
                        title: Row(
                          children: [
                            Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: AppColors.xanh_main, width: 1.5),
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
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
                                        _confirmPasswordController
                                            .text.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          backgroundColor: AppColors.do_main,
                                          content: Text(
                                              'Vui lòng nhập đầy đủ thông tin'),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    } else if (_newPasswordController
                                                .text.length <
                                            6 ||
                                        _confirmPasswordController.text.length <
                                            6) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          backgroundColor: AppColors.do_main,
                                          content: Text(
                                              'Mật khẩu phải có độ dài lớn hơn hoặc bằng 6 ký tự'),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    } else if (_newPasswordController.text !=
                                        _confirmPasswordController.text) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          backgroundColor: AppColors.do_main,
                                          content:
                                              Text('Mật khẩu mới không khớp'),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    } else {
                                      SimpleResModel sr = await context
                                          .read<SettingCubit>()
                                          .changePassword(
                                              1,
                                              _oldPasswordController.text,
                                              _newPasswordController.text);
                                      print(sr.message);

                                      if (sr.message == "Ok") {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            backgroundColor:
                                                AppColors.xanh_main,
                                            content:
                                                Text('Đổi mật khẩu thành công'),
                                            duration: Duration(seconds: 2),
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            backgroundColor: AppColors.do_main,
                                            content:
                                                Text('Mật khẩu cũ không đúng'),
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
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: Divider(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: AppColors.xanh_main, width: 1.5),
                                  ),
                                  child: const Icon(
                                    Icons.auto_awesome,
                                    color: AppColors.xanh_main,
                                    size: 30,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  'Tự động duyệt',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const Spacer(), // Đẩy `Switch` về bên phải

                                Switch(
                                  value: autoAcceptStatus,
                                  activeColor: AppColors.xanh_main,
                                  activeTrackColor:
                                      AppColors.xanh_main.withOpacity(0.5),
                                  inactiveThumbColor: AppColors.xam72,
                                  inactiveTrackColor: Colors.transparent,
                                  onChanged: (value) async {
                                    setState(() {
                                      autoAcceptStatus = value;
                                    });
                                    await context.read<SettingCubit>().setting(
                                          1,
                                          autoAcceptStatus,
                                          (_selectedRadio == 1),
                                          upperStar,
                                        );
                                  },
                                ),
                              ],
                            ),
                            if (autoAcceptStatus)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Column(
                                  children: [
                                    RadioListTile(
                                      activeColor: AppColors.xanh_main,
                                      title: const Text(
                                          'Chỉ nhận tasker yêu thích'),
                                      value: 1,
                                      groupValue: _selectedRadio,
                                      onChanged: (value) async {
                                        setState(() {
                                          _selectedRadio = value!;
                                        });
                                        await context
                                            .read<SettingCubit>()
                                            .setting(
                                              1,
                                              autoAcceptStatus,
                                              (_selectedRadio == 1),
                                              upperStar,
                                            );
                                      },
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      child: Divider(),
                                    ),
                                    RadioListTile(
                                      activeColor: AppColors.xanh_main,
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('Chỉ nhận trên'),
                                          // Slider để chọn số từ 1 đến 5
                                          Row(
                                            children: [
                                              Column(
                                                children: [
                                                  IconButton(
                                                    icon: const Icon(
                                                        FontAwesomeIcons
                                                            .angleUp),
                                                    iconSize: 15,
                                                    onPressed: () async {
                                                      setState(() {
                                                        if (upperStar < 4) {
                                                          upperStar++;
                                                        }
                                                      });
                                                      await context
                                                          .read<SettingCubit>()
                                                          .setting(
                                                            1,
                                                            autoAcceptStatus,
                                                            (_selectedRadio ==
                                                                1),
                                                            upperStar,
                                                          );
                                                    },
                                                  ),
                                                  IconButton(
                                                    icon: const Icon(
                                                        FontAwesomeIcons
                                                            .angleDown,
                                                        size: 15),
                                                    onPressed: () async {
                                                      setState(() {
                                                        if (upperStar > 0) {
                                                          upperStar--;
                                                        }
                                                      });
                                                      await context
                                                          .read<SettingCubit>()
                                                          .setting(
                                                            1,
                                                            autoAcceptStatus,
                                                            (_selectedRadio ==
                                                                1),
                                                            upperStar,
                                                          );
                                                    },
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                    color: AppColors.xam72,
                                                    width: 1.0,
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 10,
                                                    vertical: 1,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                          upperStar.toString()),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      const Icon(
                                                        FontAwesomeIcons
                                                            .solidStar,
                                                        color: Colors.amber,
                                                        size: 15,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ), // Hiển thị số đã chọn
                                            ],
                                          ),
                                        ],
                                      ),
                                      value: 2,
                                      groupValue: _selectedRadio,
                                      onChanged: (value) async {
                                        setState(() {
                                          _selectedRadio = value!;
                                        });
                                        await context
                                            .read<SettingCubit>()
                                            .setting(
                                              1,
                                              autoAcceptStatus,
                                              (_selectedRadio == 1),
                                              upperStar,
                                            );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      )
                    ]),
              ));
        } else if (state is SettingError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
