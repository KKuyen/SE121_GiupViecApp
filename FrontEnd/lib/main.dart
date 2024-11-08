import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se121_giupviec_app/core/firebase/firebase_noti.dart';
import 'package:se121_giupviec_app/presentation/bloc/Setting/Setting_cubit.dart';

import 'package:se121_giupviec_app/presentation/bloc/blockTasker/blockTaskers_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/loveTasker/loveTaskers_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/newTask1/newTask1_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/newTask2/newTask2_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/review/aReview_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/review/allReview_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/task/a_task_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/task/approveWidget_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/task/get_all_task_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/task/tasker/tasker_find_task_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/task/tasker/tasker_get_all_task_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/tasker/tasker_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/tasker_list/taskerlist_cubit.dart';
import 'package:se121_giupviec_app/presentation/screens/navigation/navigation.dart';

import 'package:se121_giupviec_app/presentation/screens/navigation/tasker_navigation.dart';
import 'package:se121_giupviec_app/presentation/screens/user/activities/test.dart';
import 'core/injection/injection_container.dart' as di;
import 'presentation/bloc/Auth/auth_cubit.dart';
import 'presentation/bloc/Location/add_location_cubit.dart';
import 'presentation/bloc/Location/default_location_cubit.dart';
import 'presentation/bloc/Location/delete_location_cubit.dart';
import 'presentation/bloc/Location/location_cubit.dart';
import 'presentation/bloc/TaskType/get_all_tasktype_cubit.dart';
import 'presentation/bloc/Voucher/voucher_cubit.dart';
import 'package:firebase_storage/firebase_storage.dart'; // Thêm dòng này

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init(); // Initialize dependencies
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyB8JQVfpVOpmb-c7M-7wvkjRd8Qf1pBjqM",
            appId: "1:464358819305:web:39d8f0c730192b28ecb778",
            messagingSenderId: "464358819305",
            projectId: "se100-af7bc"));
  } else {
    await Firebase.initializeApp();
  }
  // await FirebaseNoti().initNotifications(); // Initialize Firebase Notifications

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 255, 255, 255)),
          useMaterial3: true,
        ),
        home: TaskerNavigation(),
        debugShowCheckedModeBanner: false, // Bỏ nhãn DEBUG
      ),
    );
  }
}
