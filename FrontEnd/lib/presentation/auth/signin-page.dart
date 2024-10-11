import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/common/widgets/button/sizedbutton.dart';
import 'package:se121_giupviec_app/core/configs/assets/app_vectors.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:se121_giupviec_app/presentation/auth/signup_page.dart';
import 'package:se121_giupviec_app/presentation/navigation/navigation.dart';
import 'package:url_launcher/url_launcher.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          padding: const EdgeInsets.all(30),
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
                _dividerWithText('or'),
                const SizedBox(height: 40),
                _iconGroup(context),
              ],
            ),
          ),
        ));
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
                  onTap: () async {},
                  child: const Text(
                    'Quên mật khẩu',
                    style: TextStyle(
                        color: AppColors.cam_main, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const Navigation()));
              },
              child: const SizedBox(
                width: double.infinity, // Chiều rộng bằng chiều rộng màn hình
                child: Sizedbutton(
                  text: 'Đăng nhập',
                ),
              ),
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
          labelText: 'Email',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          )),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Email is required';
        }
        bool emailValid =
            RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value);
        if (!emailValid) {
          return 'Please enter a valid email';
        }
        return null;
      },
    );
  }

  Widget _passField(BuildContext context) {
    return TextFormField(
      controller: _password,
      decoration: const InputDecoration(
          labelText: 'Mật khẩu',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          )),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Password is required';
        }
        if (value.length < 6) {
          return 'Password must be at least 6 characters';
        }
        return null;
      },
      obscureText: true,
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
}
