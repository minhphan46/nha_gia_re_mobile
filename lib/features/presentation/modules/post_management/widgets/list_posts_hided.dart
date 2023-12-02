import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/core/extensions/date_ex.dart';
import 'package:nhagiare_mobile/features/domain/enums/post_status_management.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../../domain/entities/posts/real_estate_post.dart';
import '../post_management_controller.dart';
import 'item_post.dart';

class ListPostsHided extends StatefulWidget {
  const ListPostsHided({super.key});

  @override
  State<ListPostsHided> createState() => _ListPostsHidedState();
}

class _ListPostsHidedState extends State<ListPostsHided> {
  RxBool isLoading = false.obs;
  final PostManagementController controller =
      Get.find<PostManagementController>();

  void onSelectedMenu(int i, RealEstatePostEntity post) {
    if (i == 0) {
      controller.showPost(post);
    } else if (i == 1) {
      controller.editPost(post);
    } else if (i == 2) {
      controller.deletePost(post);
    }
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  Future refresh() async {
    isLoading.value = true;
    await controller.getPostsHided();
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
            : controller.hidedPosts.isEmpty
                ? Center(
                    child: Text(
                      "Chưa có tin đã ẩn",
                      style:
                          AppTextStyles.bold20.copyWith(color: AppColors.green),
                    ),
                  )
                : ListView.builder(
                    itemCount: controller.hidedPosts.length,
                    itemBuilder: (context, index) {
                      return ItemPost(
                        statusCode: PostStatusManagement.hided,
                        status:
                            "Đã ẩn tin. Hết hạn sau ${controller.hidedPosts[index].expiryDate?.toHMDMYString()}",
                        post: controller.hidedPosts[index],
                        funcs: const [
                          "Hiện tin",
                          "Chỉnh sửa",
                          "Xóa tin",
                        ],
                        iconFuncs: const [
                          Icons.remove_red_eye_outlined,
                          Icons.edit,
                          Icons.delete_outline,
                        ],
                        onSelectedMenu: onSelectedMenu,
                        onTap: (RealEstatePostEntity post) {},
                      );
                    },
                  ),
      ),
    );
  }
}
