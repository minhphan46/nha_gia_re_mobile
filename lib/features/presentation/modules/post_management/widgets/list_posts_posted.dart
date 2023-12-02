import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/core/extensions/date_ex.dart';
import 'package:nhagiare_mobile/features/domain/entities/posts/real_estate_post.dart';
import 'package:nhagiare_mobile/features/presentation/modules/post_management/widgets/base_list_posts.dart';
import '../../../../domain/enums/post_status_management.dart';
import '../post_management_controller.dart';
import 'item_post.dart';

class ListPostsPosted extends StatelessWidget {
  ListPostsPosted({super.key});

  final PostManagementController controller =
      Get.find<PostManagementController>();

  void onSelectedMenu(int i, RealEstatePostEntity post) {
    if (i == 0) {
      controller.hidePost(post);
    } else if (i == 1) {
      controller.editPost(post);
    } else if (i == 2) {
      controller.deletePost(post);
    } else if (i == 3) {
      controller.extensionPost(post);
    }
  }

  ItemPost buildItem(RealEstatePostEntity post) {
    return ItemPost(
      statusCode: PostStatusManagement.approved,
      status: "Hiển thị đến ${post.expiryDate?.toHMDMYString()}",
      post: post,
      funcs: const [
        "Ẩn tin",
        "Chỉnh sửa",
        "Xóa tin",
        "Gia hạn",
      ],
      iconFuncs: const [
        Icons.remove_red_eye_outlined,
        Icons.edit,
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
      titleNull: "Chưa có tin đã đăng",
      getPosts: controller.getPostsApproved,
      postsList: controller.approvedPosts,
      buildItem: buildItem,
    );
  }
}
