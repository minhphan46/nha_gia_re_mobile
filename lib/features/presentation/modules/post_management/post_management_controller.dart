import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/features/domain/entities/posts/real_estate_post.dart';
import 'package:nhagiare_mobile/features/domain/usecases/post/remote/delete_post.dart';
import 'package:nhagiare_mobile/features/domain/usecases/post/remote/get_posts_approved.dart';
import 'package:nhagiare_mobile/features/domain/usecases/post/remote/get_posts_expired.dart';
import 'package:nhagiare_mobile/features/domain/usecases/post/remote/get_posts_hided.dart';
import 'package:nhagiare_mobile/features/domain/usecases/post/remote/get_posts_pending.dart';
import 'package:nhagiare_mobile/features/domain/usecases/post/remote/get_posts_rejected.dart';
import 'package:nhagiare_mobile/features/domain/usecases/post/remote/hide_post.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../config/theme/app_color.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../core/resources/pair.dart';
import '../../../../injection_container.dart';

class PostManagementController extends GetxController {
  RxList<RealEstatePostEntity> pendingPosts = <RealEstatePostEntity>[].obs;
  RxList<RealEstatePostEntity> approvedPosts = <RealEstatePostEntity>[].obs;
  RxList<RealEstatePostEntity> rejectedPosts = <RealEstatePostEntity>[].obs;
  RxList<RealEstatePostEntity> hidedPosts = <RealEstatePostEntity>[].obs;
  RxList<RealEstatePostEntity> expiredPosts = <RealEstatePostEntity>[].obs;

  List<String> typePosts = [
    "Đã đăng",
    "Chờ duyệt",
    "Bị từ chối",
    "Đã ẩn",
    "Hết hạn",
  ];

  // get all posts

  final GetPostsApprovedUseCase _getPostsApprovedUseCase =
      sl<GetPostsApprovedUseCase>();
  final GetPostsPendingUseCase _getPostsPendingUseCase =
      sl<GetPostsPendingUseCase>();
  final GetPostsExpiredUseCase _getPostsExpiredUseCase =
      sl<GetPostsExpiredUseCase>();
  final GetPostsRejectUseCase _getPostsRejectUseCase =
      sl<GetPostsRejectUseCase>();
  final GetPostsHidedUseCase _getPostsHidedUseCase = sl<GetPostsHidedUseCase>();

  Future<Pair<int, List<RealEstatePostEntity>>> getPostsApproved(
      {int? page = 1}) async {
    final dataState = await _getPostsApprovedUseCase(params: page);
    if (dataState is DataSuccess && dataState.data!.second.isNotEmpty) {
      return dataState.data!;
    } else {
      return Pair(1, []);
    }
  }

  Future<Pair<int, List<RealEstatePostEntity>>> getPostsPending(
      {int? page = 1}) async {
    final dataState = await _getPostsPendingUseCase(params: page);
    if (dataState is DataSuccess && dataState.data!.second.isNotEmpty) {
      pendingPosts.value = dataState.data!.second;
      return dataState.data!;
    } else {
      return Pair(1, []);
    }
  }

  Future<Pair<int, List<RealEstatePostEntity>>> getPostsExpired(
      {int? page = 1}) async {
    final dataState = await _getPostsExpiredUseCase(params: page);
    if (dataState is DataSuccess && dataState.data!.second.isNotEmpty) {
      return dataState.data!;
    } else {
      return Pair(1, []);
    }
  }

  Future<Pair<int, List<RealEstatePostEntity>>> getPostsRejected(
      {int? page = 1}) async {
    final dataState = await _getPostsRejectUseCase(params: page);
    if (dataState is DataSuccess && dataState.data!.second.isNotEmpty) {
      return dataState.data!;
    } else {
      return Pair(1, []);
    }
  }

  Future<Pair<int, List<RealEstatePostEntity>>> getPostsHided(
      {int? page = 1}) async {
    final dataState = await _getPostsHidedUseCase(params: page);
    if (dataState is DataSuccess && dataState.data!.second.isNotEmpty) {
      return dataState.data!;
    } else {
      return Pair(1, []);
    }
  }

  Future<void> getPostsInit() async {
    getPostsApproved();
    getPostsPending();
    getPostsExpired();
    getPostsRejected();
    getPostsHided();
  }

  void navigateToDetailSceen(RealEstatePostEntity post) {
    Get.toNamed(AppRoutes.postDetail, arguments: post);
  }

  void showPost(RealEstatePostEntity post) async {
    HidePostsUseCase hidePostsUseCase = sl<HidePostsUseCase>();
    final dataState = await hidePostsUseCase(params: Pair(post, true));
    if (dataState is DataSuccess) {
      await getPostsInit();
      Get.snackbar(
        'Cập nhập',
        'Hiện bài thành công',
        backgroundColor: AppColors.green,
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        'Cập nhập',
        'Hiện bài thất bại',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void hidePost(RealEstatePostEntity post) async {
    HidePostsUseCase hidePostsUseCase = sl<HidePostsUseCase>();
    final dataState = await hidePostsUseCase(params: Pair(post, false));
    if (dataState is DataSuccess) {
      await getPostsInit();
      Get.snackbar(
        'Cập nhập',
        'Ẩn bài thành công',
        backgroundColor: AppColors.green,
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        'Cập nhập',
        'Ẩn bài thất bại',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void editPost(RealEstatePostEntity post) async {
    Get.toNamed(AppRoutes.createPost, arguments: post);
  }

  void deletePost(RealEstatePostEntity post) async {
    DeletePostUseCase deletePostUseCase = sl<DeletePostUseCase>();
    final dataState = await deletePostUseCase(params: post.id);
    if (dataState is DataSuccess) {
      await getPostsInit();
      Get.snackbar(
        'Cập nhập',
        'Xóa bài thành công',
        backgroundColor: AppColors.green,
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        'Cập nhập',
        'Xóa bài thất bại',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void extensionPost(RealEstatePostEntity post) async {
    //await repository.extendPostExpiryDate(post.id, true);
    await getPostsInit();
  }
}
