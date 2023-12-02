import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/core/extensions/date_ex.dart';
import 'package:nhagiare_mobile/features/domain/entities/posts/real_estate_post.dart';
import 'package:nhagiare_mobile/features/domain/enums/post_status_management.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../post_management_controller.dart';
import 'item_post.dart';

class ListPostsExpried extends StatefulWidget {
  const ListPostsExpried({super.key});

  @override
  State<ListPostsExpried> createState() => _ListPostsExpriedState();
}

class _ListPostsExpriedState extends State<ListPostsExpried> {
  final PostManagementController controller =
      Get.find<PostManagementController>();

  int page = 1;
  int numOfPage = 1;
  RxBool isLoading = false.obs;
  final scrollController = ScrollController();

  void onSelectedMenu(int i, RealEstatePostEntity post) {
    if (i == 0) {
      controller.deletePost(post);
    } else if (i == 1) {
      controller.extensionPost(post);
    }
  }

  @override
  void initState() {
    refresh();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {}
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future fetchMore() async {
    isLoading.value = true;
    await controller.getPostsExpired();
    isLoading.value = false;
  }

  Future refresh() async {
    isLoading.value = true;
    await controller.getPostsExpired();
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
            : controller.expiredPosts.isEmpty
                ? Center(
                    child: Text(
                      "Chưa có tin hết hạn",
                      style:
                          AppTextStyles.bold20.copyWith(color: AppColors.green),
                    ),
                  )
                : ListView.builder(
                    controller: scrollController,
                    itemCount: controller.expiredPosts.length,
                    itemBuilder: (context, index) {
                      return ItemPost(
                        statusCode: PostStatusManagement.exprired,
                        status:
                            "Tin đã hết hạn từ ${controller.expiredPosts[index].expiryDate?.toHMDMYString()}",
                        post: controller.expiredPosts[index],
                        funcs: const [
                          "Xóa tin",
                          "Gia hạn",
                        ],
                        iconFuncs: const [
                          Icons.delete_outline,
                          Icons.timer_outlined,
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
