import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se121_giupviec_app/presentation/bloc/blockTasker/blockTaskers_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/loveTasker/loveTaskers_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/newTask1/newTask1_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/review/allReview_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/task/a_task_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/task/approveWidget_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/task/get_all_task_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/tasker/tasker_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/tasker_list/taskerlist_cubit.dart';
import 'package:se121_giupviec_app/presentation/screens/navigation/navigation.dart';

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
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 255, 255, 255)),
          useMaterial3: true,
        ),
        home: const Navigation(),
        debugShowCheckedModeBanner: false, // Bỏ nhãn DEBUG
      ),
    );
  }
}
