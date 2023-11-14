import 'package:get/get.dart';
import 'package:nhagiare_mobile/features/domain/entities/posts/real_estate_post.dart';
import '../../../../core/resources/data_state.dart';
import '../../../../injection_container.dart';
import '../../../domain/enums/post_status.dart';
import '../../../domain/usecases/post/remote/get_posts.dart';

class PostManagementController extends GetxController {
  List<RealEstatePostEntity> allPosts = [];
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
  final GetPostsUseCase _getPostsUseCase = sl<GetPostsUseCase>();
  Future<List<RealEstatePostEntity>> getAllPosts() async {
    final dataState = await _getPostsUseCase();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      allPosts = dataState.data!;
      return dataState.data!;
    } else {
      allPosts = [];
      return [];
    }
  }

  Future<void> getPostsInit() async {
    allPosts.clear();
    pendingPosts.clear();
    expiredPosts.clear();
    hidedPosts.clear();
    rejectedPosts.clear();
    approvedPosts.clear();
    pendingPosts.clear();
    allPosts = await getAllPosts();

    for (RealEstatePostEntity post in allPosts) {
      if (post.status == null) continue;
      switch (post.status ?? PostStatus.pending) {
        case PostStatus.approved:
          if (post.expiryDate!.isBefore(DateTime.now())) {
            expiredPosts.add(post);
          } else if (!post.isActive!) {
            hidedPosts.add(post);
          } else {
            approvedPosts.add(post);
          }
          break;
        case PostStatus.pending:
          pendingPosts.add(post);
          break;
        case PostStatus.rejected:
          rejectedPosts.add(post);
          break;
        case PostStatus.hided:
          hidedPosts.add(post);
          break;
      }
    }
  }

  void navigateToDetailSceen(RealEstatePostEntity post) {
    //Get.toNamed(AppRoutes.post_detail, arguments: post);
  }

  void showPost(RealEstatePostEntity post) async {
    //await repository.hideOrUnHidePost(post.id, false);
    await getPostsInit();
  }

  void hidePost(RealEstatePostEntity post) async {
    //await repository.hideOrUnHidePost(post.id, true);
    await getPostsInit();
  }

  void editPost(RealEstatePostEntity post) async {
    print("edit post");
    // edit post

    // Get.toNamed(AppRoutes.post, parameters: {
    //   "id": post.id,
    //   'type': post.type.toString(),
    // });
  }

  void deletePost(RealEstatePostEntity post) async {
    //await repository.deletePost(post.id);
    await getPostsInit();
  }

  void extensionPost(RealEstatePostEntity post) async {
    //await repository.extendPostExpiryDate(post.id, true);
    await getPostsInit();
  }
}
