import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:se121_giupviec_app/common/helpers/SecureStorage.dart';
import 'package:se121_giupviec_app/core/configs/assets/app_vectors.dart';
import 'package:se121_giupviec_app/presentation/screens/auth/signin-page.dart';
import 'package:se121_giupviec_app/presentation/screens/navigation/navigation.dart';
import 'package:se121_giupviec_app/presentation/screens/navigation/tasker_navigation.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    redirect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: logo(),
    );
  }

  Future<void> redirect() async {
    await Future.delayed(const Duration(seconds: 3));
    bool storageCheck = await _checkStorageWithTimeout();

    if (storageCheck) {
      String role = await secureStorage.readRole();
      if (role == "R1") {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const Navigation()));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => TaskerNavigation()));
      }
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const SignInPage()));
    }
  }

  Future<bool> _checkStorageWithTimeout() async {
    final completer = Completer<bool>();

    _checkStorage().then((result) {
      if (!completer.isCompleted) {
        completer.complete(result);
      }
    }).catchError((error) {
      if (!completer.isCompleted) {
        completer.complete(false);
      }
    });

    Future.delayed(const Duration(seconds: 3)).then((_) {
      if (!completer.isCompleted) {
        completer.complete(false);
      }
    });

    return completer.future;
  }

  SecureStorage secureStorage = SecureStorage();
  Future<bool> _checkStorage() async {
    String? id = await secureStorage.readId();
    String? email = await secureStorage.readEmail();
    String? Rpoints = await secureStorage.readRpoints();
    String? name = await secureStorage.readName();
    String? avatar = await secureStorage.readAvatar();
    if (id != null &&
        email != null &&
        Rpoints != null &&
        name != null &&
        avatar != null) {
      return true;
    }
    return false;
  }

  Center logo() {
    return Center(
      child: SvgPicture.asset(
        AppVectors.logo,
        height: 30,
      ),
    );
  }
}
