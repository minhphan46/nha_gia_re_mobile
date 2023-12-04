import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/core/extensions/date_ex.dart';
import 'package:nhagiare_mobile/features/domain/entities/posts/real_estate_post.dart';
import 'package:nhagiare_mobile/features/domain/enums/post_status_management.dart';
import '../post_management_controller.dart';
import 'base_list_posts.dart';
import 'item_post.dart';

class ListPostsExpried extends StatelessWidget {
  ListPostsExpried({super.key});

  final PostManagementController controller =
      Get.find<PostManagementController>();

  void onSelectedMenu(int i, RealEstatePostEntity post) {
    if (i == 0) {
      controller.deletePost(post);
    } else if (i == 1) {
      controller.extensionPost(post);
    }
  }

  ItemPost buildItem(RealEstatePostEntity post) {
    return ItemPost(
      statusCode: PostStatusManagement.exprired,
      status: "Tin đã hết hạn từ ${post.expiryDate?.toHMDMYString()}",
      post: post,
      funcs: const [
        "Xóa tin",
        "Gia hạn",
      ],
      iconFuncs: const [
        Icons.delete_outline,
        Icons.timer_outlined,
      ],
      onSelectedMenu: onSelectedMenu,
      onTap: controller.navigateToDetailSceen,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseListPosts(
      titleNull: "Chưa có tin hết hạn",
      getPosts: controller.getPostsExpired,
      postsList: controller.expiredPosts,
      buildItem: buildItem,
    );
  }
}
