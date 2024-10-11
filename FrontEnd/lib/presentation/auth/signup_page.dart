import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/common/widgets/button/sizedbutton.dart';
import 'package:se121_giupviec_app/core/configs/assets/app_vectors.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:se121_giupviec_app/presentation/auth/signin-page.dart';
import 'package:se121_giupviec_app/presentation/navigation/navigation.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _phone = TextEditingController();
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
                const SizedBox(height: 15),
                _registerText(),
                const SizedBox(height: 20),
                _supportText(),
                const SizedBox(height: 27),
                _nameField(context),
                const SizedBox(height: 15),
                _phoneField(context),
                const SizedBox(height: 15),
                _emailField(context),
                const SizedBox(height: 15),
                _passField(context),
                const SizedBox(height: 35),
                SizedBox(
                  width: double.infinity, // Chiều rộng bằng chiều rộng màn hình
                  child: GestureDetector(
                    child: const Sizedbutton(
                      text: 'Đăng kí',
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const Navigation()));
                    },
                  ),
                ),
                const SizedBox(height: 25),
                _dividerWithText('hoặc'),
                const SizedBox(height: 20),
                _iconGroup(context),
              ],
            ),
          ),
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
      'Đăng kí',
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
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Bạn đã có tài khoản?'),
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const SignInPage()));
              },
              child: const Text(
                'Đăng nhập',
                style: TextStyle(
                  color: AppColors.cam_main,
                ),
              )),
        ],
      ),
    );
  }

  Widget _nameField(BuildContext context) {
    return TextField(
      controller: _fullName,
      decoration: const InputDecoration(
          labelText: 'Họ và tên',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          )),
    );
  }

  Widget _phoneField(BuildContext context) {
    return TextField(
      controller: _phone,
      decoration: const InputDecoration(
          labelText: 'Số điện thoại',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          )),
    );
  }

  Widget _emailField(BuildContext context) {
    return TextField(
      controller: _email,
      decoration: const InputDecoration(
          labelText: 'Email',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          )),
    );
  }

  Widget _passField(BuildContext context) {
    return TextField(
      controller: _password,
      decoration: const InputDecoration(
          labelText: 'Mật khẩu',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          )),
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
