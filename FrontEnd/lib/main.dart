import 'package:flutter/material.dart';
import 'package:se121_giupviec_app/presentation/auth/signin-page.dart';
import 'package:se121_giupviec_app/presentation/auth/splash.dart';
import 'package:se121_giupviec_app/presentation/navigation/navigation.dart';
import 'package:se121_giupviec_app/presentation/user/home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashPage(),
      debugShowCheckedModeBanner: false, // Bỏ nhãn DEBUG
    );
  }
}
