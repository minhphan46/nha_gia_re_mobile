import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:nhagiare_mobile/features/data/data_sources/remote/media_remote_date_source.dart';
import 'package:nhagiare_mobile/features/data/data_sources/remote/user_remote_date_source.dart';
import 'package:nhagiare_mobile/features/data/repository/user_respository_impl.dart';
import 'package:nhagiare_mobile/features/domain/usecases/address/get_district_names.dart';
import 'package:nhagiare_mobile/features/domain/usecases/address/get_ward_names.dart';
import 'package:nhagiare_mobile/features/domain/usecases/post/remote/delete_post.dart';
import 'package:nhagiare_mobile/features/domain/usecases/post/remote/hide_post.dart';
import 'package:nhagiare_mobile/features/domain/usecases/purchase/unsubcribe.dart';
import 'package:nhagiare_mobile/features/domain/usecases/user/GetFollowersAndFollowingsCount.dart';
import '../features/domain/usecases/authentication/get_me.dart';
import '../features/domain/usecases/post/remote/get_suggest_keywords_use_case.dart';
import '../features/domain/usecases/purchase/get_current_subscription.dart';
import '../core/utils/filter_values.dart';
import '../features/data/data_sources/remote/blog_data_source.dart';
import '../features/data/data_sources/remote/conversation_remote_data_source.dart';
import '../features/data/data_sources/remote/membership_package_data_source.dart';
import '../features/data/data_sources/remote/post_remote_data_sources.dart';
import 'features/data/data_sources/remote/transaction_remote_data_source.dart';
import '../features/data/repository/blog_repository_impl.dart';
import '../features/data/repository/membership_package_respository_impl.dart';
import '../features/data/repository/transaction_repository_impl.dart';
import '../features/domain/repository/blog_repository.dart';
import '../features/domain/repository/membership_package_repository.dart';
import '../features/domain/repository/post_repository.dart';
import '../features/domain/repository/transaction_repository.dart';
import '../features/domain/usecases/authentication/get_access_token.dart';
import '../features/domain/usecases/authentication/get_user_id.dart';
import '../features/domain/usecases/authentication/sign_up.dart';
import '../features/domain/usecases/blog/remote/get_all_blogs.dart';
import '../features/domain/usecases/address/get_address.dart';
import '../features/domain/usecases/address/get_province_names.dart';
import '../features/domain/usecases/post/remote/create_post.dart';
import '../features/domain/usecases/post/remote/get_post_search.dart';
import '../features/domain/usecases/post/remote/get_posts.dart';
import '../features/domain/usecases/post/remote/get_posts_approved.dart';
import '../features/domain/usecases/post/remote/get_posts_rejected.dart';
import '../features/domain/usecases/post/remote/upload_images.dart';
import '../features/domain/usecases/purchase/get_membership_package.dart';
import '../features/domain/usecases/purchase/get_order.dart';
import '../features/domain/usecases/purchase/get_transaction.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/data/data_sources/local/authentication_local_data_source.dart';
import 'features/data/data_sources/remote/authentication_remote_data_source.dart';
import 'features/data/repository/authentication_repository_impl.dart';
import 'features/data/repository/conversation_repository_impl.dart';
import 'features/data/repository/media_repository_impl.dart';
import 'features/data/repository/post_repository_impl.dart';
import 'features/data/repository/provinces_repository_impl.dart';
import 'features/domain/repository/authentication_repository.dart';
import 'features/domain/repository/conversation_repository.dart';
import 'features/domain/repository/media_repository.dart';
import 'features/domain/repository/provinces_repository.dart';
import 'features/domain/repository/user_repository.dart';
import 'features/domain/usecases/authentication/check_token.dart';
import 'features/domain/usecases/authentication/sign_in.dart';
import 'features/domain/usecases/authentication/sign_out.dart';
import 'features/domain/usecases/post/remote/get_posts_expired.dart';
import 'features/domain/usecases/post/remote/get_posts_hided.dart';
import 'features/domain/usecases/post/remote/get_posts_pending.dart';
import 'features/domain/usecases/purchase/get_all_transactions.dart';
import 'features/domain/usecases/user/FollowOrUnfollowUserUseCase.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<Dio>(Dio());
  // Filter
  sl.registerSingleton<FilterValues>(FilterValues());
  // Dio
  // Login =====================================================
  // datasource
  sl.registerSingleton<AuthenRemoteDataSrc>(
    AuthenRemoteDataSrcImpl(
      sl<Dio>(),
    ),
  );
  sl.registerSingleton<AuthenLocalDataSrc>(
    AuthenLocalDataSrcImpl(await SharedPreferences.getInstance()),
  );
  // repository
  sl.registerSingleton<AuthenticationRepository>(
    AuthenticationRepositoryImpl(
      sl<AuthenRemoteDataSrc>(),
      sl<AuthenLocalDataSrc>(),
    ),
  );
  // use cases

  sl.registerSingleton<GetUserIdUseCase>(
    GetUserIdUseCase(
      sl<AuthenticationRepository>(),
    ),
  );

  sl.registerSingleton<GetAccessTokenUseCase>(
    GetAccessTokenUseCase(
      sl<AuthenticationRepository>(),
    ),
  );

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

  sl.registerSingleton<CreatePostsUseCase>(
    CreatePostsUseCase(
      sl<PostRepository>(),
    ),
  );

  sl.registerSingleton<DeletePostUseCase>(
    DeletePostUseCase(
      sl<PostRepository>(),
    ),
  );

  sl.registerSingleton<HidePostsUseCase>(
    HidePostsUseCase(
      sl<PostRepository>(),
    ),
  );

  sl.registerSingleton<GetPostSearchsUseCase>(
    GetPostSearchsUseCase(
      sl<PostRepository>(),
    ),
  );

  sl.registerSingleton<UploadImagessUseCase>(
    UploadImagessUseCase(
      sl<PostRepository>(),
    ),
  );

  sl.registerSingleton(GetSuggestKeywordsUseCase(
    sl<PostRepository>(),
  ));
  //MembershipPackage=====================================================
  // datasource
  sl.registerSingleton<MembershipPackageRemoteDataSrc>(
    MembershipPackageRemoteDataSrcImpl(sl<Dio>(), sl<AuthenLocalDataSrc>()),
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
      sl<AuthenLocalDataSrc>().getAccessToken() ?? '',
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

  sl.registerSingleton(GetAllTransactionUseCase(
    sl<TransactionRepository>(),
  ));

  sl.registerSingleton<GetOrderMembershipPackageUseCase>(
    GetOrderMembershipPackageUseCase(
      sl<MembershipPackageRepository>(),
    ),
  );

  sl.registerSingleton(GetCurrentSubscriptionUseCase(
    sl<TransactionRepository>(),
  ));

  // Blog =====================================================
  // blog repository
  sl.registerSingleton<BlogRemoteDataSrc>(
    BlogRemoteDataSrcImpl(
      sl<Dio>(),
    ),
  );

  sl.registerSingleton<BlogRepository>(
    BlogRepositoryImpl(
      sl<BlogRemoteDataSrc>(),
    ),
  );

  sl.registerSingleton<GetBlogsUseCase>(
    GetBlogsUseCase(
      sl<BlogRepository>(),
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

  sl.registerSingleton<GetDistrictNamesUseCase>(
    GetDistrictNamesUseCase(
      sl<ProvincesRepository>(),
    ),
  );

  sl.registerSingleton<GetWardNamesUseCase>(
    GetWardNamesUseCase(
      sl<ProvincesRepository>(),
    ),
  );

  // Chat =====================================================
  sl.registerSingleton<ConversationRemoteDataSource>(
    ConversationRemoteDataSourceImpl(
      sl<Dio>(),
    ),
  );

  sl.registerSingleton<MediaRemoteDataSource>(
    MediaRemoteDataSourceImpl(
      sl<Dio>(),
    ),
  );

  sl.registerSingleton<MediaRepository>(
    MediaRepositoryImpl(
      mediaDataSource: sl<MediaRemoteDataSource>(),
    ),
  );

  sl.registerSingleton<ConversationRepository>(
    ConversationRepositoryImpl(
      sl<ConversationRemoteDataSource>(),
      sl<AuthenLocalDataSrc>(),
      sl<MediaRepository>(),
    ),
  );

  sl.registerSingleton<GetProvinceNamesUseCase>(
    GetProvinceNamesUseCase(
      sl<ProvincesRepository>(),
    ),
  );

  sl.registerSingleton<SignInUseCase>(
    SignInUseCase(
      sl<AuthenticationRepository>(),
      sl<ConversationRepository>(),
    ),
  );

  sl.registerSingleton<SignOutUseCase>(
    SignOutUseCase(
      sl<AuthenticationRepository>(),
      sl<ConversationRepository>(),
    ),
  );

  sl.registerSingleton<SignUpUseCase>(
    SignUpUseCase(
      sl<AuthenticationRepository>(),
      sl<ConversationRepository>(),
    ),
  );

  sl.registerSingleton<CheckTokenUseCase>(
    CheckTokenUseCase(
      sl<AuthenticationRepository>(),
      sl<ConversationRepository>(),
    ),
  );

  sl.registerSingleton(
      GetMeUseCase(repository: sl<AuthenticationRepository>()));

  sl.registerSingleton<UserRemoteDataSource>(
    UserRemoteDataSourceImpl(
      sl<Dio>(),
      sl<AuthenLocalDataSrc>(),
    ),
  );

  sl.registerSingleton<UserRepository>(
    UserRepositoryImpl(
      sl<UserRemoteDataSource>(),
    ),
  );

  sl.registerSingleton<GetFollowersAndFollowingsCount>(
    GetFollowersAndFollowingsCount(
      sl<UserRepository>(),
    ),
  );

  sl.registerSingleton<FollowOrUnfollowUserUseCase>(
    FollowOrUnfollowUserUseCase(
      sl<UserRepository>(),
    ),
  );

  sl.registerSingleton<UnsubscribeUseCase>(
    UnsubscribeUseCase(
      sl<MembershipPackageRepository>(),
    ),
  );
}
