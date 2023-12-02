import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/core/extensions/date_ex.dart';
import 'package:nhagiare_mobile/features/domain/entities/posts/real_estate_post.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../../domain/enums/post_status_management.dart';
import '../post_management_controller.dart';
import 'item_post.dart';

class ListPostsPosted extends StatefulWidget {
  const ListPostsPosted({super.key});

  @override
  State<ListPostsPosted> createState() => _ListPostsPostedState();
}

class _ListPostsPostedState extends State<ListPostsPosted> {
  RxBool isLoading = false.obs;
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

  @override
  void initState() {
    refresh();
    super.initState();
  }

  Future refresh() async {
    isLoading.value = true;
    await controller.getPostsApproved();
    isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refresh,
      child: Obx(
        () => isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : controller.approvedPosts.isEmpty
                ? Center(
                    child: Text(
                      "Chưa có tin đã đăng",
                      style:
                          AppTextStyles.bold20.copyWith(color: AppColors.green),
                    ),
                  )
                : ListView.builder(
                    itemCount: controller.approvedPosts.length,
                    itemBuilder: (context, index) {
                      return ItemPost(
                        statusCode: PostStatusManagement.approved,
                        status:
                            "Hiển thị đến ${controller.approvedPosts[index].expiryDate?.toHMDMYString()}",
                        post: controller.approvedPosts[index],
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
                    },
                  ),
      ),
    );
  }
}
