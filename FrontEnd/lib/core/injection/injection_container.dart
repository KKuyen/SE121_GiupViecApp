import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:se121_giupviec_app/data/datasources/allReview_remote_datasource.dart';
import 'package:se121_giupviec_app/data/datasources/blockTaskers_remote_datasource.dart';
import 'package:se121_giupviec_app/data/datasources/loveTaskers_remote_datasource.dart';
import 'package:se121_giupviec_app/data/datasources/newTask1_remote_datasource.dart';
import 'package:se121_giupviec_app/data/datasources/setting_remote_datasource.dart';
import 'package:se121_giupviec_app/data/datasources/task_remote_datasource.dart';
import 'package:se121_giupviec_app/data/datasources/tasker_remote_datasource.dart';
import 'package:se121_giupviec_app/data/repository/allReview_repository_impl.dart';
import 'package:se121_giupviec_app/data/repository/blockTaskers_repository_impl.dart';
import 'package:se121_giupviec_app/data/repository/get_task_impl.dart';
import 'package:se121_giupviec_app/data/repository/loveTaskers_repository_impl.dart';
import 'package:se121_giupviec_app/data/repository/newtask1_repository_impl.dart';
import 'package:se121_giupviec_app/data/repository/setting_repository_impl.dart';
import 'package:se121_giupviec_app/data/repository/task_repository_impl.dart';
import 'package:se121_giupviec_app/data/repository/tasker_repository_impl.dart';
import 'package:se121_giupviec_app/domain/repository/BlockTaskers_repository.dart';
import 'package:se121_giupviec_app/domain/repository/a_task_repository.dart';
import 'package:se121_giupviec_app/domain/repository/allReview_repository.dart';
import 'package:se121_giupviec_app/domain/repository/loveTaskers_repository.dart';
import 'package:se121_giupviec_app/domain/repository/newTask1_repository.dart';
import 'package:se121_giupviec_app/domain/repository/setting_repository.dart';
import 'package:se121_giupviec_app/domain/repository/task_repository.dart';

import 'package:se121_giupviec_app/domain/repository/tasker_repository.dart';
import 'package:se121_giupviec_app/domain/usecases/Setting_usecaces.dart';
import 'package:se121_giupviec_app/domain/usecases/get_a_tasker_usercase.dart';

import 'package:se121_giupviec_app/domain/usecases/Auth/sendOTP.dart';

import 'package:se121_giupviec_app/domain/usecases/get_a_tasks_usercase.dart';

import 'package:se121_giupviec_app/presentation/bloc/Voucher/delete_my_voucher_cubit.dart';

import 'package:se121_giupviec_app/domain/usecases/get_all_block_taskers_usecase.dart';
import 'package:se121_giupviec_app/domain/usecases/get_all_love_taskers_usecase.dart';
import 'package:se121_giupviec_app/domain/usecases/get_all_reviews_usercase.dart';
import 'package:se121_giupviec_app/domain/usecases/new_task1_usecase.dart';
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
      SettingUsecase: sl(),
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
    () => TaskerlistCubit(
      getATasksUsercase: sl(),
    ),
  );
  sl.registerFactory(
    () => TaskerCubit(
      getATaskerUsercase: sl(),
    ),
  );
  sl.registerFactory(
    () => allReviewCubit(
      getAllReviewsUsercase: sl(),
    ),
  );
  sl.registerFactory(
    () => LoveTaskersCubit(
      getLoveTaskerssUsercase: sl(),
    ),
  );
  sl.registerFactory(
    () => BlockTaskersCubit(
      getBlockTaskerssUsercase: sl(),
    ),
  );
  sl.registerFactory(() => NewTask1Cubit(
        newTask1Usecase: sl(),
      ));

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

  sl.registerFactory(() => MessageCubit(
        getMyMessageUseCase: sl(),
      ));
  sl.registerFactory(
    () => NewTask2Cubit(
      NewTask2Usecase: sl(),
    ),
  );
  sl.registerFactory(
    () => AReviewCubit(
      getAReviewsUsercase: sl(),
    ),
  );
  sl.registerFactory(
    () => SettingCubit(
      SettingUsecase: sl(),
    ),
  );
  sl.registerFactory(
    () => TaskerTaskCubit(
      getAllTasksUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => TaskerFindTaskCubit(
      getAllTasksUseCase: sl(),
      getATaskerUsercase: sl(),
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

  sl.registerLazySingleton(() => GetATaskerUsercase(sl()));
  sl.registerLazySingleton(() => GetAllReviewsUsercase(sl()));
  sl.registerLazySingleton(() => GetAllLoveTaskersUsecase(sl()));
  sl.registerLazySingleton(() => GetAllBlockTaskersUsecase(sl()));
  sl.registerLazySingleton(() => NewTask1Usecase(sl()));

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

  sl.registerLazySingleton(() => SettingUsecaces(sl()));

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

  sl.registerLazySingleton<TaskerRepository>(
    () => TaskerRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<AllReviewRepository>(
    () => AllReviewRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<LoveTaskersRepository>(
    () => LoveTaskersRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<BlockTaskersRepository>(
    () => BlockTaskersRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<Newtask1Repository>(
    () => Newtask1RepositoryImpl(sl()),
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

  sl.registerLazySingleton<SettingRepository>(
    () => SettingRepositoryImpl(sl()),
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

  sl.registerLazySingleton<TaskerRemoteDataSourceImpl>(
    () => TaskerRemoteDataSourceImpl(
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

  sl.registerLazySingleton<AllReviewRemoteDatasource>(
    () => AllReviewRemoteDatasourceImpl(
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

  sl.registerLazySingleton<LoveTaskersRemoteDatasource>(
    () => LoveTaskersRemoteDatasourceImpl(
      client: sl(),
      baseUrl: ApiConstants.baseUrl,
      apiVersion: ApiConstants.apiVersion,
    ),
  );
  sl.registerLazySingleton<BlockTaskersRemoteDatasource>(
    () => BlockTaskersRemoteDatasourceImpl(
      client: sl(),
      baseUrl: ApiConstants.baseUrl,
      apiVersion: ApiConstants.apiVersion,
    ),
  );
  sl.registerLazySingleton<NewTask1RemoteDatasource>(
    () => NewTask1RemoteDatasourceImpl(
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
  sl.registerLazySingleton<SettingRemoteDatasource>(
    () => SettingRemoteDataSourceImpl(
      client: sl(),
      baseUrl: ApiConstants.baseUrl,
      apiVersion: ApiConstants.apiVersion,
    ),
  );
  // External
  sl.registerLazySingleton(() => http.Client());
}
