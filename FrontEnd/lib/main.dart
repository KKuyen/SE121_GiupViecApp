import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_links/uni_links.dart';
import 'dart:async';

import 'package:se121_giupviec_app/presentation/bloc/Voucher/delete_my_voucher_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/newTask2/newTask2_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/notification/notification_cubit.dart';
import 'package:se121_giupviec_app/presentation/screens/auth/splash.dart';
import 'package:se121_giupviec_app/presentation/bloc/Setting/Setting_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/blockTasker/blockTaskers_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/loveTasker/loveTaskers_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/newTask1/newTask1_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/review/aReview_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/review/allReview_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/task/a_task_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/task/approveWidget_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/task/get_all_task_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/task/tasker/tasker_find_task_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/task/tasker/tasker_get_all_task_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/tasker/tasker_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/tasker_list/taskerlist_cubit.dart';

import 'core/injection/injection_container.dart' as di;
import 'presentation/bloc/Auth/auth_cubit.dart';
import 'presentation/bloc/Location/add_location_cubit.dart';
import 'presentation/bloc/Location/default_location_cubit.dart';
import 'presentation/bloc/Location/delete_location_cubit.dart';
import 'presentation/bloc/Location/location_cubit.dart';
import 'presentation/bloc/Message/message_cubit.dart';
import 'presentation/bloc/Message/message_review_cubit.dart';
import 'presentation/bloc/TaskType/get_all_tasktype_cubit.dart';
import 'presentation/bloc/Voucher/claim_voucher_cubit.dart';
import 'presentation/bloc/Voucher/voucher_cubit.dart';
import 'presentation/screens/navigation/navigation.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyB8JQVfpVOpmb-c7M-7wvkjRd8Qf1pBjqM",
            authDomain: "se100-af7bc.firebaseapp.com",
            projectId: "se100-af7bc",
            storageBucket: "se100-af7bc.appspot.com",
            messagingSenderId: "464358819305",
            appId: "1:464358819305:web:39d8f0c730192b28ecb778",
            measurementId: "G-1LZYHKS59L"));
  } else {
    await Firebase.initializeApp();
  }

  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription? _sub;

  @override
  void initState() {
    super.initState();
    _initUniLinks();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  Future<void> _initUniLinks() async {
    _sub = uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        // Handle the incoming link here
        print('Received URI: $uri');
        if (uri.scheme == 'myapp' && uri.host == 'callback') {
          // Navigate to the Navigation screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  Navigation(tab: 1, userId: 1 /* pass the userId here */),
            ),
          );
        }
      }
    }, onError: (err) {
      // Handle error
    });
  }

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
        BlocProvider(
          create: (context) => di.sl<TaskTypeCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<ATaskCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<AWCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<TaskerlistCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<TaskerCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<allReviewCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<LoveTaskersCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<BlockTaskersCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<NewTask1Cubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<VoucherCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<ClaimVoucherCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<LocationCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<AddLocationCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<DeleteLocationCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<DefaultLocationCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<DeleteMyVoucherCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<MessageCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<NewTask2Cubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<AReviewCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<SettingCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<TaskerTaskCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<TaskerFindTaskCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<MessageReviewCubit>(),
        ),
        BlocProvider(
          create: (context) => di.sl<allNotificationCubit>(),
        ),
      ],
      child: MaterialApp(
        title: 'TaskMate',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 255, 255, 255)),
          useMaterial3: true,
        ),
        home: SplashPage(),
        debugShowCheckedModeBanner: false, // Bỏ nhãn DEBUG
      ),
    );
  }
}
