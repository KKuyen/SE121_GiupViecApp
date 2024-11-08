import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:se121_giupviec_app/data/datasources/task_remote_datasource.dart';
import 'package:se121_giupviec_app/data/repository/get_task_impl.dart';
import 'package:se121_giupviec_app/data/repository/task_repository_impl.dart';
import 'package:se121_giupviec_app/domain/repository/a_task_repository.dart';
import 'package:se121_giupviec_app/domain/repository/task_repository.dart';
import 'package:se121_giupviec_app/domain/usecases/Auth/sendOTP.dart';
import 'package:se121_giupviec_app/domain/usecases/get_a_tasks_usercase.dart';
import 'package:se121_giupviec_app/presentation/bloc/Voucher/delete_my_voucher_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/a_task_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/approveWidget_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/get_all_task_cubit.dart';

import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/datasources/location_remote_datasource.dart';
import '../../data/datasources/message_remote_datasource.dart';
import '../../data/datasources/task_type_remote_datasourse.dart';
import '../../data/datasources/voucher_remote_datasourse.dart';
import '../../data/repository/auth_repository_impl.dart';
import '../../data/repository/location_repository_impl.dart';
import '../../data/repository/message_repository_impl.dart';
import '../../data/repository/task_type_repository_impl.dart';
import '../../data/repository/voucher_repository_impl.dart';
import '../../domain/repository/auth_repository.dart';
import '../../domain/repository/location_repository.dart';
import '../../domain/repository/message_repository.dart';
import '../../domain/repository/task_type_repository.dart';
import '../../domain/repository/voucher_repository.dart';
import '../../domain/usecases/Auth/edit_profile_usecase.dart';
import '../../domain/usecases/Auth/forget_pass_usecase.dart';
import '../../domain/usecases/Auth/login_usecase.dart';
import '../../domain/usecases/Auth/register_usecase.dart';
import '../../domain/usecases/Location/add_new_location_usecase.dart';
import '../../domain/usecases/Location/delete_location_usecase.dart';
import '../../domain/usecases/Location/get_my_default_location_usecase.dart';
import '../../domain/usecases/Location/get_my_location_usecase.dart';
import '../../domain/usecases/Message/get_messages_usecase.dart';
import '../../domain/usecases/TaskType/get_all_tasktype_usecase.dart';
import '../../domain/usecases/Voucher/claim_voucher_usecase.dart';
import '../../domain/usecases/Voucher/delete_my_voucher_usecase.dart';
import '../../domain/usecases/Voucher/get_all_vouchcer_usecase.dart';
import '../../domain/usecases/Voucher/get_my_voucher_usecase.dart';
import '../../domain/usecases/get_all_tasks_usecase.dart'; // Import GetAllTasksUseCase
import '../../domain/usecases/Auth/verifyOTP.dart';
import '../../presentation/bloc/Auth/auth_cubit.dart';

import '../../presentation/bloc/Location/add_location_cubit.dart';
import '../../presentation/bloc/Location/delete_location_cubit.dart';

import '../../presentation/bloc/Location/default_location_cubit.dart';
import '../../presentation/bloc/Location/location_cubit.dart';
import '../../presentation/bloc/Message/message_cubit.dart';
import '../../presentation/bloc/TaskType/get_all_tasktype_cubit.dart';
import '../../presentation/bloc/Voucher/claim_voucher_cubit.dart';
import '../../presentation/bloc/Voucher/voucher_cubit.dart';
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
      editProfileUsecase: sl(),
    ),
  );

  sl.registerFactory(
    () => TaskCubit(
      getAllTasksUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => TaskTypeCubit(
      getAllTasksTypeUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => ATaskCubit(
      getATasksUsercase: sl(),
    ),
  );
  sl.registerFactory(
    () => AWCubit(
      getATasksUsercase: sl(),
    ),
  );
  sl.registerFactory(
    () => VoucherCubit(
      getAllVoucherUseCase: sl(),
      getMyVoucherUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => ClaimVoucherCubit(
      claimVoucherUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => DeleteMyVoucherCubit(
      deleteMyVoucherUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => LocationCubit(
      getMyLocationUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => DeleteLocationCubit(
      deleteLocationUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => AddLocationCubit(
      addNewLocationUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => DefaultLocationCubit(
      getMyDefaultLocationUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => MessageCubit(
      getMyMessageUseCase: sl(),
    ),
  );
  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => GetAllTasksUseCase(sl()));
  sl.registerLazySingleton(() => SendOTPUseCase(sl()));
  sl.registerLazySingleton(() => VerifyOTPUseCase(sl()));
  sl.registerLazySingleton(() => ForgetPassUseCase(sl()));
  sl.registerLazySingleton(() => GetATasksUsecase(sl()));
  sl.registerLazySingleton(() => GetAllTasksTypeUseCase(sl()));
  sl.registerLazySingleton(() => GetAllVoucherUseCase(sl()));
  sl.registerLazySingleton(() => GetMyLocationUseCase(sl()));
  sl.registerLazySingleton(() => GetMyDefaultLocationUseCase(sl()));
  sl.registerLazySingleton(() => AddNewLocationUseCase(sl()));
  sl.registerLazySingleton(() => DeleteLocationUseCase(sl()));
  sl.registerLazySingleton(() => EditProfileUsecase(sl()));
  sl.registerLazySingleton(() => ClaimVoucherUseCase(sl()));
  sl.registerLazySingleton(() => GetMyVoucherUseCase(sl()));
  sl.registerLazySingleton(() => DeleteMyVoucherUseCase(sl()));
  sl.registerLazySingleton(() => GetMyMessageUseCase(sl()));
  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<ATaskRepository>(
    () => ATaskRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<TaskTypeRepository>(
    () => TaskTypeRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<VoucherRepository>(
    () => VoucherRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<LocationRepository>(
    () => LocationRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<MessageRepository>(
    () => MessageRepositoryImpl(sl()),
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
  sl.registerLazySingleton<TaskTypeRemoteDatasource>(
    () => TaskTypeRemoteDatasourceImpl(
      client: sl(),
      baseUrl: ApiConstants.baseUrl,
      apiVersion: ApiConstants.apiVersion,
    ),
  );
  sl.registerLazySingleton<VoucherRemoteDatasource>(
    () => VoucherRemoteDatasourceImpl(
      client: sl(),
      baseUrl: ApiConstants.baseUrl,
      apiVersion: ApiConstants.apiVersion,
    ),
  );
  sl.registerLazySingleton<LocationRemoteDatasource>(
    () => LocationRemoteDatasourceImpl(
      client: sl(),
      baseUrl: ApiConstants.baseUrl,
      apiVersion: ApiConstants.apiVersion,
    ),
  );
  sl.registerLazySingleton<MessageRemoteDatasource>(
    () => MessageRemoteDatasourceImpl(
      client: sl(),
      baseUrl: ApiConstants.baseUrl,
      apiVersion: ApiConstants.apiVersion,
    ),
  );
  // External
  sl.registerLazySingleton(() => http.Client());
}
