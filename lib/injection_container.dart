import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:nhagiare_mobile/features/data/data_sources/local/app_database.dart';
import 'package:nhagiare_mobile/features/data/data_sources/remote/membership_package_data_source.dart';
import 'package:nhagiare_mobile/features/data/data_sources/remote/new_api_service.dart';
import 'package:nhagiare_mobile/features/data/data_sources/remote/post_remote_data_sources.dart';
import 'package:nhagiare_mobile/features/data/data_sources/remote/transaction_data_source.dart';
import 'package:nhagiare_mobile/features/data/repository/membership_package_respository_impl.dart';
import 'package:nhagiare_mobile/features/data/repository/task_repository_impl.dart';
import 'package:nhagiare_mobile/features/data/repository/transaction_repository_impl.dart';
import 'package:nhagiare_mobile/features/domain/repository/membership_package_repository.dart';
import 'package:nhagiare_mobile/features/domain/repository/post_repository.dart';
import 'package:nhagiare_mobile/features/domain/repository/task_repository.dart';
import 'package:nhagiare_mobile/features/domain/repository/transaction_repository.dart';
import 'package:nhagiare_mobile/features/domain/usecases/post/remote/get_address.dart';
import 'package:nhagiare_mobile/features/domain/usecases/post/remote/get_posts.dart';
import 'package:nhagiare_mobile/features/domain/usecases/post/remote/get_posts_approved.dart';
import 'package:nhagiare_mobile/features/domain/usecases/post/remote/get_posts_rejected.dart';
import 'package:nhagiare_mobile/features/domain/usecases/purchase/get_membership_package.dart';
import 'package:nhagiare_mobile/features/domain/usecases/purchase/get_order.dart';
import 'package:nhagiare_mobile/features/domain/usecases/purchase/get_transaction.dart';
import 'package:nhagiare_mobile/features/domain/usecases/tasks/local/get_local_task.dart';
import 'package:nhagiare_mobile/features/domain/usecases/tasks/local/remove_task.dart';
import 'package:nhagiare_mobile/features/domain/usecases/tasks/local/save_local_task.dart';
import 'package:nhagiare_mobile/features/domain/usecases/tasks/remote/get_tasks.dart';
import 'package:nhagiare_mobile/features/domain/usecases/tasks/remote/remove_task.dart';
import 'package:nhagiare_mobile/features/domain/usecases/tasks/remote/save_task.dart';
import 'package:nhagiare_mobile/features/domain/usecases/tasks/remote/update_task.dart';
import 'features/data/repository/post_repository_impl.dart';
import 'features/data/repository/provinces_repository_impl.dart';
import 'features/domain/repository/provinces_repository.dart';
import 'features/domain/usecases/post/remote/get_posts_expired.dart';
import 'features/domain/usecases/post/remote/get_posts_hided.dart';
import 'features/domain/usecases/post/remote/get_posts_pending.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  final localDatabase =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  sl.registerSingleton<AppDatabase>(localDatabase);

  // Dio
  sl.registerSingleton<Dio>(Dio());

  // Dependencies Injection
  sl.registerSingleton<NewApiService>(NewApiService(sl<Dio>()));

  sl.registerSingleton<TaskRepository>(
    TaskRepositoryImpl(
      sl<NewApiService>(),
      sl<AppDatabase>(),
    ),
  );

  // use cases
  sl.registerSingleton<GetTasksUseCase>(
    GetTasksUseCase(
      sl<TaskRepository>(),
    ),
  );

  sl.registerSingleton<SaveTaskUseCase>(
    SaveTaskUseCase(
      sl<TaskRepository>(),
    ),
  );

  sl.registerSingleton<RemoveTaskUseCase>(
    RemoveTaskUseCase(
      sl<TaskRepository>(),
    ),
  );

  sl.registerSingleton<UpdateTaskUseCase>(
    UpdateTaskUseCase(
      sl<TaskRepository>(),
    ),
  );

  // use cases local
  sl.registerSingleton<GetLocalTasksUseCase>(
    GetLocalTasksUseCase(
      sl<TaskRepository>(),
    ),
  );

  sl.registerSingleton<SaveLocalTasksUseCase>(
    SaveLocalTasksUseCase(
      sl<TaskRepository>(),
    ),
  );

  sl.registerSingleton<RemoveLocalTasksUseCase>(
    RemoveLocalTasksUseCase(
      sl<TaskRepository>(),
    ),
  );

  // blocs
  // sl.registerFactory<RemoteTasksBloc>(() => RemoteTasksBloc(
  //       sl<GetTasksUseCase>(),
  //       sl<SaveTaskUseCase>(),
  //       sl<RemoveTaskUseCase>(),
  //       sl<UpdateTaskUseCase>(),
  //     ));

  // sl.registerFactory<LocalTasksBloc>(() => LocalTasksBloc(
  //       sl<GetLocalTasksUseCase>(),
  //       sl<SaveLocalTasksUseCase>(),
  //       sl<RemoveLocalTasksUseCase>(),
  //     ));

  //Post=====================================================
  // datasource
  sl.registerSingleton<PostRemoteDataSrc>(
    PostRemoteDataSrcImpl(
      sl<Dio>(),
    ),
  );
  // post repository
  sl.registerSingleton<PostRepository>(
    PostRepositoryImpl(
      sl<PostRemoteDataSrc>(),
    ),
  );

  // use cases
  sl.registerSingleton<GetPostsUseCase>(
    GetPostsUseCase(
      sl<PostRepository>(),
    ),
  );

  sl.registerSingleton<GetPostsApprovedUseCase>(
    GetPostsApprovedUseCase(
      sl<PostRepository>(),
    ),
  );

  sl.registerSingleton<GetPostsPendingUseCase>(
    GetPostsPendingUseCase(
      sl<PostRepository>(),
    ),
  );

  sl.registerSingleton<GetPostsRejectUseCase>(
    GetPostsRejectUseCase(
      sl<PostRepository>(),
    ),
  );

  sl.registerSingleton<GetPostsExpiredUseCase>(
    GetPostsExpiredUseCase(
      sl<PostRepository>(),
    ),
  );

  sl.registerSingleton<GetPostsHidedUseCase>(
    GetPostsHidedUseCase(
      sl<PostRepository>(),
    ),
  );

  //MembershipPackage=====================================================
  // datasource
  sl.registerSingleton<MembershipPackageRemoteDataSrc>(
    MembershipPackageRemoteDataSrcImpl(
      sl<Dio>(),
    ),
  );
  // membership package repository'
  sl.registerSingleton<MembershipPackageRepository>(
    MembershipPackageRepositoryImpl(
      sl<MembershipPackageRemoteDataSrc>(),
    ),
  );

  // use cases
  sl.registerSingleton<GetMembershipPackageUseCase>(
    GetMembershipPackageUseCase(
      sl<MembershipPackageRepository>(),
    ),
  );

  //Transaction=====================================================
  sl.registerSingleton<TransactionRemoteDataSrc>(
    TransactionRemoteDataSrcImpl(
      sl<Dio>(),
    ),
  );

  sl.registerSingleton<TransactionRepository>(
    TranstractionRepositoryImpl(
      sl<TransactionRemoteDataSrc>(),
    ),
  );

  // use cases
  sl.registerSingleton<GetTransactionUseCase>(
    GetTransactionUseCase(
      sl<TransactionRepository>(),
    ),
  );

  sl.registerSingleton<GetOrderMembershipPackageUseCase>(
    GetOrderMembershipPackageUseCase(
      sl<MembershipPackageRepository>(),
    ),
  );

  // Provinces =====================================================
  // provinces repository
  sl.registerSingleton<ProvincesRepository>(
    ProvincesRepositoryImpl(),
  );
  // use cases
  sl.registerSingleton<GetAddressUseCase>(
    GetAddressUseCase(
      sl<ProvincesRepository>(),
    ),
  );
}
