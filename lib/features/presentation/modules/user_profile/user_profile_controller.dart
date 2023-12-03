import 'package:get/get.dart';
import 'package:nhagiare_mobile/core/resources/pair.dart';
import 'package:nhagiare_mobile/features/domain/entities/user/user.dart';
import 'package:nhagiare_mobile/features/domain/usecases/user/GetFollowersAndFollowingsCount.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/resources/pair.dart';
import '../../../../injection_container.dart';
import '../../../domain/entities/posts/real_estate_post.dart';
import '../../../domain/usecases/post/remote/get_posts.dart';

class UserProfileController extends GetxController {
  UserEntity? user = Get.arguments;
  bool isFollow = false;

  RxString numOfPosts = "-".obs;

  // get all posts
  final GetPostsUseCase _getPostsUseCase = sl<GetPostsUseCase>();
  Future<List<RealEstatePostEntity>> getAllPosts({int? page = 1}) async {
    final dataState = await _getPostsUseCase(
      params: Pair(user!.id, page),
    );

    if (dataState is DataSuccess && dataState.data!.second.isNotEmpty) {
      numOfPosts.value = dataState.data!.second.length.toString();
      return dataState.data!.second;
    } else if (dataState is DataFailed) {
      return [];
    } else {
      return [];
    }
  }

  Future<void> followOrUnfollowUser() async {
    // final dataState = await _followOrUnfollowUserUseCase(params: user!.id);
    // if (dataState is DataSuccess) {
    //   isFollow = dataState.data!;
    //   update();
    // }
  }

  final GetFollowersAndFollowingsCount _getFollowersAndFollowingsCountUseCase =
      sl<GetFollowersAndFollowingsCount>();

  Future<Pair<int, int>> getFollowersAndFollowingsCount() async {
    try {
      final data =
          await _getFollowersAndFollowingsCountUseCase(params: user!.id!);
      return data;
    } catch (e) {
      Get.snackbar("Lỗi", "Lỗi khi lấy dữ liệu");
      return Pair(0, 0);
    }
  }
}
