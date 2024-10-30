import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:se121_giupviec_app/data/datasources/allReview_remote_datasource.dart';
import 'package:se121_giupviec_app/data/datasources/blockTaskers_remote_datasource.dart';
import 'package:se121_giupviec_app/data/datasources/loveTaskers_remote_datasource.dart';
import 'package:se121_giupviec_app/data/datasources/newTask1_remote_datasource.dart';
import 'package:se121_giupviec_app/data/datasources/task_remote_datasource.dart';
import 'package:se121_giupviec_app/data/datasources/tasker_remote_datasource.dart';
import 'package:se121_giupviec_app/data/repository/allReview_repository_impl.dart';
import 'package:se121_giupviec_app/data/repository/blockTaskers_repository_impl.dart';
import 'package:se121_giupviec_app/data/repository/get_task_impl.dart';
import 'package:se121_giupviec_app/data/repository/loveTaskers_repository_impl.dart';
import 'package:se121_giupviec_app/data/repository/newtask1_repository_impl.dart';
import 'package:se121_giupviec_app/data/repository/task_repository_impl.dart';
import 'package:se121_giupviec_app/data/repository/tasker_repository_impl.dart';
import 'package:se121_giupviec_app/domain/repository/BlockTaskers_repository.dart';
import 'package:se121_giupviec_app/domain/repository/a_task_repository.dart';
import 'package:se121_giupviec_app/domain/repository/allReview_repository.dart';
import 'package:se121_giupviec_app/domain/repository/loveTaskers_repository.dart';
import 'package:se121_giupviec_app/domain/repository/newTask1_repository.dart';
import 'package:se121_giupviec_app/domain/repository/task_repository.dart';
import 'package:se121_giupviec_app/domain/repository/tasker_repository.dart';
import 'package:se121_giupviec_app/domain/usecases/get_a_tasker_usercase.dart';
import 'package:se121_giupviec_app/domain/usecases/get_a_tasks_usercase.dart';
import 'package:se121_giupviec_app/domain/usecases/get_all_block_taskers_usecase.dart';
import 'package:se121_giupviec_app/domain/usecases/get_all_love_taskers_usecase.dart';
import 'package:se121_giupviec_app/domain/usecases/get_all_reviews_usercase.dart';
import 'package:se121_giupviec_app/domain/usecases/new_task1_usecase.dart';
import 'package:se121_giupviec_app/presentation/bloc/blockTasker/blockTaskers_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/loveTasker/loveTaskers_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/newTask1/newTask1_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/review/allReview_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/task/a_task_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/task/approveWidget_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/task/get_all_task_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/tasker/tasker_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/tasker_list/taskerlist_cubit.dart';

import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/repository/auth_repository_impl.dart';
import '../../domain/repository/auth_repository.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../domain/usecases/get_all_tasks_usecase.dart'; // Import GetAllTasksUseCase
import '../../presentation/bloc/auth_cubit.dart';

import '../configs/constants/api_constants.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Cubit
  sl.registerFactory(
    () => AuthCubit(
      loginUseCase: sl(),
      registerUseCase: sl(),
    ),
  );

  sl.registerFactory(
    () => TaskCubit(
      getAllTasksUseCase: sl(),
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
  sl.registerFactory(
    () => NewTask1Cubit(
      newTask1Usecase: sl(),
    ),
  );
  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => GetAllTasksUseCase(sl()));
  sl.registerLazySingleton(() => GetATasksUsecase(sl()));
  sl.registerLazySingleton(() => GetATaskerUsercase(sl()));
  sl.registerLazySingleton(() => GetAllReviewsUsercase(sl()));
  sl.registerLazySingleton(() => GetAllLoveTaskersUsecase(sl()));
  sl.registerLazySingleton(() => GetAllBlockTaskersUsecase(sl()));
  sl.registerLazySingleton(() => NewTask1Usecase(sl()));

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
  sl.registerLazySingleton<AllReviewRemoteDatasource>(
    () => AllReviewRemoteDatasourceImpl(
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
  // External
  sl.registerLazySingleton(() => http.Client());
}
