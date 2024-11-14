import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/common/widgets/button/sizedbutton.dart';
import 'package:se121_giupviec_app/core/configs/assets/app_vectors.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_info.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:se121_giupviec_app/presentation/screens/auth/signup_page.dart';
import 'package:se121_giupviec_app/presentation/screens/navigation/navigation.dart';

import 'package:se121_giupviec_app/presentation/screens/navigation/tasker_navigation.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/helpers/SecureStorage.dart';
import '../../bloc/Auth/auth_cubit.dart';
import '../../bloc/Auth/auth_state.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  String _otp = '';
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _phoneDialogController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _obscureText = true;
  bool isShowErrText = false;
  SecureStorage secureStorage = SecureStorage();
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) async {
        if (state is AuthLoading) {
          // Show loading dialog
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          // Hide loading dialog
          Navigator.of(context).pop();

          if (state is AuthSuccess) {
            await secureStorage.writeUserInfo(
                state.user, state.user.access_token);
            // Navigate to home
            if ((state.user.user as Map<String, dynamic>)['role'].toString() ==
                "R2") {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => TaskerNavigation(
                          userId:
                              (state.user.user as Map<String, dynamic>)['id'],
                        )),
              );
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Navigation()),
              );
            }
          } else if (state is AuthError) {
            // Show error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(state.message),
                  backgroundColor: AppColors.do_main),
            );
          }
        }
      },
      child: Scaffold(
          appBar: BasicAppbar(
            title: SvgPicture.asset(
              AppVectors.logo,
              height: 22,
            ),
            isHideBackButton: true,
            isCenter: true,
          ),
          bottomNavigationBar: _bottomText(context),
          body: Padding(
            padding: const EdgeInsets.all(AppInfo.main_padding),
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  _registerText(),
                  const SizedBox(height: 20),
                  _supportText(),
                  const SizedBox(height: 25),
                  _buildFormLogin(),
                  const SizedBox(height: 40),
                  _dividerWithText('hoặc'),
                  const SizedBox(height: 40),
                  _iconGroup(context),
                ],
              ),
            ),
          )),
    );
  }

  Widget _buildFormLogin() {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            _userNameField(context),
            const SizedBox(height: 15),
            _passField(context),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () async {
                    _showForgotPasswordBottomSheet(context);
                  },
                  child: const Text(
                    'Quên mật khẩu',
                    style: TextStyle(
                        color: AppColors.cam_main, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity, // Chiều rộng bằng chiều rộng màn hình
              child: Sizedbutton(
                  text: 'Đăng nhập',
                  onPressFun: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<AuthCubit>().login(
                            _email.text,
                            _password.text,
                          );
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (BuildContext context) =>
                      //             const Navigation()));
                    }
                  }),
            ),
          ],
        ));
  }

  Widget _dividerWithText(String text) {
    return Row(
      children: [
        Expanded(child: _fadingDivider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Text(text),
        ),
        Expanded(child: _fadingDivider2()),
      ],
    );
  }

  Widget _fadingDivider() {
    return Container(
      height: 1,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.grey, Colors.transparent],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
    );
  }

  Widget _fadingDivider2() {
    return Container(
      height: 1,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.transparent, Colors.grey],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
    );
  }

  Widget _registerText() {
    return const Text(
      'Đăng nhập',
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _supportText() {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            const TextSpan(
              text: 'Nếu bạn cần hỗ trợ, vui lòng liên hệ  ',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            WidgetSpan(
              child: GestureDetector(
                onTap: () async {
                  const url = 'https://flutter.dev/';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                child: const Text(
                  'Tại đây',
                  style: TextStyle(
                      color: AppColors.cam_main, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bottomText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Bạn chưa có tài khoản?'),
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => SignUpPage()));
              },
              child: const Text(
                'Đăng kí ngay',
                style: TextStyle(
                  color: AppColors.cam_main,
                ),
              )),
        ],
      ),
    );
  }

  Widget _userNameField(BuildContext context) {
    return TextFormField(
      controller: _email,
      decoration: const InputDecoration(
          labelText: 'Số điện thoại',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          )),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Vui lòng nhập số điện thoại';
        }
        bool emailValid = RegExp(r'^\+?[0-9]{10,15}$').hasMatch(value);
        if (!emailValid) {
          return 'Vui lòng nhập đúng định dạng';
        }
        return null;
      },
    );
  }

  Widget _passField(BuildContext context) {
    return TextFormField(
      controller: _password,
      decoration: InputDecoration(
          labelText: 'Mật khẩu',
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: const Color.fromARGB(255, 63, 63, 63),
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          )),
      obscureText: _obscureText,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Vui lòng nhập mật khẩu';
        }
        if (value.length < 6) {
          return 'Mật khẩu phải có ít nhất 6 ký tự';
        }
        return null;
      },
    );
  }

  Widget _iconGroup(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(AppVectors.google, height: 35),
        const SizedBox(
          width: 50,
        ),
        SvgPicture.asset(AppVectors.facebook, height: 35),
      ],
    );
  }

  void _showForgotPasswordBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Cho phép BottomSheet cuộn
      builder: (BuildContext context) {
        return BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthLoading) {
              // Show loading dialog
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              // Hide loading dialog
              Navigator.of(context).pop();

              if (state is AuthResponseSuccess) {
                // Navigation to OTP
                Navigator.pop(context); // Đóng BottomSheet hiện tại
                _showOtpBottomSheet(context);
              } else if (state is AuthError) {
                // Show error message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(state.message),
                      backgroundColor: AppColors.do_main),
                );
              }
            }
          },
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context)
                  .viewInsets
                  .bottom, // Lấy khoảng trống của bàn phím
              left: 25.0,
              right: 25.0,
              top: 25.0,
            ),
            child: SingleChildScrollView(
              // Bao bọc nội dung để cho phép cuộn
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 100,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Quên mật khẩu',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Vui lòng nhập số điện thoại của bạn để nhận OTP đặt lại mật khẩu.',
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _phoneDialogController,
                    decoration: const InputDecoration(
                      labelText: 'Số điện thoại',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Sizedbutton(
                    onPressFun: () {
                      context.read<AuthCubit>().sendOTP(
                            _phoneDialogController.text,
                          );
                    },
                    text: 'Gửi OTP',
                    width: double.infinity,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  final bool _isOtpError = false;
  void _showOtpBottomSheet(BuildContext context) {
    final TextEditingController OTPController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Cho phép BottomSheet cuộn
      builder: (BuildContext context) {
        bool isOtpError = false;

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return BlocListener<AuthCubit, AuthState>(
              listener: (context, state) async {
                if (state is AuthLoading) {
                  // Show loading dialog
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  // Hide loading dialog
                  Navigator.of(context).pop();

                  if (state is AuthResponseSuccess) {
                    // Reset error flag
                    setState(() {
                      isOtpError = false;
                    });
                    // Show Thành công message after dialog is dismissed
                    await Future.delayed(Duration.zero);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Thành công"),
                          backgroundColor: AppColors.xanh_main),
                    );
                    // Navigation to OTP
                    Navigator.pop(context); // Đóng BottomSheet hiện tại
                    _showChangePasswordBottomSheet(context);
                  } else if (state is AuthError) {
                    // Set error flag
                    setState(() {
                      isOtpError = true;
                    });
                  }
                }
              },
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context)
                      .viewInsets
                      .bottom, // Lấy khoảng trống của bàn phím
                  left: 25.0,
                  right: 25.0,
                  top: 25.0,
                ),
                child: SingleChildScrollView(
                  // Bao bọc nội dung để cho phép cuộn
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 100,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        'Nhập OTP',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Vui lòng nhập số mã OTP đã được gửi đến số điện thoại của bạn.',
                      ),
                      const SizedBox(height: 20),
                      PinCodeTextField(
                        appContext: context,
                        controller: OTPController,
                        length: 6,
                        onChanged: (value) {
                          setState(() {
                            _otp = value;
                          });
                        },
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 50,
                          fieldWidth: 40,
                          activeFillColor: Colors.white,
                          inactiveFillColor: Colors.white,
                          selectedFillColor: Colors.white,
                          activeColor: AppColors
                              .xanh_main, // Màu viền khi ô nhập đang được chọn
                          inactiveColor: Colors
                              .grey, // Màu viền khi ô nhập không được chọn
                          selectedColor: AppColors.cam_main,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Visibility(
                        visible: isOtpError,
                        child: const Text(
                          "OTP không hợp lệ hoặc hết hạn",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Sizedbutton(
                        onPressFun: () {
                          context.read<AuthCubit>().verifyOTP(
                                _phoneDialogController.text,
                                OTPController.text,
                              );
                        },
                        text: 'Tiếp tục',
                        width: double.infinity,
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showChangePasswordBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Cho phép BottomSheet cuộn
      builder: (BuildContext context) {
        bool obscureText = true;
        bool isOtpError = false;
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              print("state: $state");
              if (state is AuthLoading) {
                print("state is AuthLoading");
                // Show loading dialog
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                print("state is not AuthLoading");
                // Hide loading dialog
                //Navigator.of(context).pop();

                if (state is AuthResponseSuccess) {
                  print("state is AuthResponseSuccess");
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Thành công"),
                      duration: Duration(seconds: 3),
                      backgroundColor: AppColors.xanh_main,
                    ),
                  );
                  // Navigator.pop(context); // Đóng BottomSheet hiện tại
                } else if (state is AuthError) {
                  // Show error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(state.message),
                        backgroundColor: AppColors.do_main),
                  );
                  Navigator.pop(context); // Đóng BottomSheet hiện tại
                }
              }
            },
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context)
                    .viewInsets
                    .bottom, // Lấy khoảng trống của bàn phím
                left: 25.0,
                right: 25.0,
                top: 25.0,
              ),
              child: SingleChildScrollView(
                // Bao bọc nội dung để cho phép cuộn
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 100,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Cập nhật mật khẩu',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Vui lòng nhập mật khẩu mới của bạn.',
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _newPasswordController,
                      decoration: InputDecoration(
                          labelText: 'Mật khẩu mới',
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: const Color.fromARGB(255, 63, 63, 63),
                            ),
                            onPressed: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                          )),
                      obscureText: obscureText,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập mật khẩu';
                        }
                        if (value.length < 6) {
                          return 'Mật khẩu phải có ít nhất 6 ký tự';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(
                          labelText: 'Xác nhận mật khẩu mới',
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: const Color.fromARGB(255, 63, 63, 63),
                            ),
                            onPressed: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                          )),
                      obscureText: obscureText,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập mật khẩu';
                        }
                        if (value.length < 6) {
                          return 'Mật khẩu phải có ít nhất 6 ký tự';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    Visibility(
                      visible: isOtpError,
                      child: const Text(
                        "Mật khẩu không khớp",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Sizedbutton(
                      onPressFun: () {
                        // Xử lý đổi mật khẩu ở đây
                        String newPassword = _newPasswordController.text;
                        String confirmPassword =
                            _confirmPasswordController.text;
                        if (newPassword == confirmPassword) {
                          //Navigator.pop(context); // Đóng BottomSheet

                          context.read<AuthCubit>().forgetPassword(
                                _phoneDialogController.text,
                                newPassword,
                              );
                        } else {
                          setState(() {
                            isOtpError = true;
                          });
                        }
                      },
                      text: 'Cập nhật mật khẩu',
                      width: double.infinity,
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
