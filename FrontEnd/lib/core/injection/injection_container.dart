import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:se121_giupviec_app/data/datasources/task_remote_datasource.dart';
import 'package:se121_giupviec_app/data/repository/task_repository_impl.dart';
import 'package:se121_giupviec_app/domain/repository/task_repository.dart';
import 'package:se121_giupviec_app/domain/usecases/Auth/sendOTP.dart';
import 'package:se121_giupviec_app/presentation/bloc/get_all_task_cubit.dart';

import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/repository/auth_repository_impl.dart';
import '../../domain/repository/auth_repository.dart';
import '../../domain/usecases/Auth/forget_pass_usecase.dart';
import '../../domain/usecases/Auth/login_usecase.dart';
import '../../domain/usecases/Auth/register_usecase.dart';
import '../../domain/usecases/get_all_tasks_usecase.dart'; // Import GetAllTasksUseCase
import '../../domain/usecases/Auth/verifyOTP.dart';
import '../../presentation/bloc/auth_cubit.dart';

import '../configs/constants/api_constants.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Cubit
  sl.registerFactory(
    () => AuthCubit(
      loginUseCase: sl(),
      registerUseCase: sl(),
      sendOTPUseCase: sl(),
      verifyOTPUseCase: sl(),
      forgetPassUseCase: sl(),
    ),
  );

  sl.registerFactory(
    () => TaskCubit(
      getAllTasksUseCase: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => GetAllTasksUseCase(sl()));
  sl.registerLazySingleton(() => SendOTPUseCase(sl()));
  sl.registerLazySingleton(() => VerifyOTPUseCase(sl()));
  sl.registerLazySingleton(() => ForgetPassUseCase(sl()));
  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(sl()),
  );

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      client: sl(),
      baseUrl: ApiConstants.baseUrl,
      apiVersion: ApiConstants.apiVersion,
    ),
  );
  sl.registerLazySingleton<TaskRemoteDatasource>(
    () => TaskRemoteDataSourceImpl(
      client: sl(),
      baseUrl: ApiConstants.baseUrl,
      apiVersion: ApiConstants.apiVersion,
    ),
  );

  // External
  sl.registerLazySingleton(() => http.Client());
}
