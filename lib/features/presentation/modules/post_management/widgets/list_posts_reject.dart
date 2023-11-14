import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../../domain/entities/posts/real_estate_post.dart';
import '../../../../domain/enums/post_status_management.dart';
import '../post_management_controller.dart';
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

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.rejectedPosts.isEmpty
        ? Center(
            child: Text(
              "Chưa có tin bị từ chối",
              style: AppTextStyles.bold20.copyWith(color: AppColors.green),
            ),
          )
        : ListView.builder(
            itemCount: controller.rejectedPosts.length,
            itemBuilder: (context, i) {
              return ItemPost(
                statusCode: PostStatusManagement.rejected,
                status: controller.rejectedPosts[i].infoMessage!,
                post: controller.rejectedPosts[i],
                funcs: const [
                  "Xóa tin",
                ],
                iconFuncs: const [
                  Icons.delete_outline,
                ],
                onSelectedMenu: onSelectedMenu,
                onTap: (RealEstatePostEntity post) {},
              );
            },
          ));
  }
}