import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se121_giupviec_app/presentation/bloc/get_all_task_cubit.dart';
import 'package:se121_giupviec_app/presentation/screens/auth/signin-page.dart';
import 'package:se121_giupviec_app/presentation/screens/auth/splash.dart';
import 'package:se121_giupviec_app/presentation/screens/navigation/navigation.dart';
import 'package:se121_giupviec_app/presentation/screens/user/home/home.dart';
import 'core/injection/injection_container.dart' as di;
import 'presentation/bloc/auth_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init(); // Initialize dependencies

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<AuthCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<TaskCubit>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SignInPage(),
        debugShowCheckedModeBanner: false, // Bỏ nhãn DEBUG
      ),
    );
  }
}
