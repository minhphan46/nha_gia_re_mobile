import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../../domain/entities/posts/real_estate_post.dart';
import '../../../../domain/enums/post_status_management.dart';
import '../post_management_controller.dart';
import 'item_post.dart';

class ListPostsPendding extends StatefulWidget {
  const ListPostsPendding({super.key});

  @override
  State<ListPostsPendding> createState() => _ListPostsPenddingState();
}

class _ListPostsPenddingState extends State<ListPostsPendding> {
  RxBool isLoading = false.obs;
  final PostManagementController controller =
      Get.find<PostManagementController>();

  void onSelectedMenu(int i, RealEstatePostEntity post) {
    if (i == 0) {
      controller.editPost(post);
    } else if (i == 1) {
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
    await controller.getPostsPending();
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
            : controller.pendingPosts.isEmpty
                ? Center(
                    child: Text(
                      "Chưa có tin đang chờ duyệt",
                      style:
                          AppTextStyles.bold20.copyWith(color: AppColors.green),
                    ),
                  )
                : ListView.builder(
                    itemCount: controller.pendingPosts.length,
                    itemBuilder: (context, index) {
                      return ItemPost(
                        statusCode: PostStatusManagement.pending,
                        status: "Chờ duyệt",
                        post: controller.pendingPosts[index],
                        funcs: const [
                          "Chỉnh sửa",
                          "Xóa tin",
                        ],
                        iconFuncs: const [
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
