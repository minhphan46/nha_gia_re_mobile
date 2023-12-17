import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../domain/entities/posts/real_estate_post.dart';
import '../../../../domain/enums/post_status_management.dart';
import '../post_management_controller.dart';
import 'base_list_posts.dart';
import 'item_post.dart';

class ListPostsReject extends StatelessWidget {
  ListPostsReject({super.key});

  final PostManagementController controller =
      Get.find<PostManagementController>();

  void onSelectedMenu(int i, RealEstatePostEntity post) {
    if (i == 0) {
      controller.deletePost(post);
    }
  }

  ItemPost buildItem(RealEstatePostEntity post) {
    return ItemPost(
      statusCode: PostStatusManagement.rejected,
      status: post.infoMessage ?? "Bị từ chối",
      post: post,
      funcs: const [
        "Xóa tin",
      ],
      iconFuncs: const [
        Icons.delete_outline,
      ],
      onSelectedMenu: onSelectedMenu,
      onTap: controller.navigateToDetailSceen,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseListPosts(
      titleNull: "Chưa có tin bị từ chối",
      getPosts: controller.getPostsRejected,
      postsList: controller.rejectedPosts,
      buildItem: buildItem,
    );
  }
}
