import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/core/extensions/date_ex.dart';
import 'package:nhagiare_mobile/core/utils/ansi_color.dart';
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
  final PostManagementController controller =
      Get.find<PostManagementController>();

  RxBool isLoading = false.obs;
  int page = 1;
  int numOfPage = 1;
  final scrollController = ScrollController();
  RxBool hasMore = true.obs;

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
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        fetchMore();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future fetchMore() async {
    page++;
    if (page <= numOfPage) {
      await controller.getPostsApproved(page: page).then((value) {
        numOfPage = value.first;
        final newPosts = value.second;
        controller.approvedPosts.addAll(newPosts);
      });
    } else {
      hasMore.value = false;
    }

    print(success(hasMore.value.toString()));
  }

  Future refresh() async {
    isLoading.value = true;
    page = 1;
    hasMore.value = true;
    await controller.getPostsApproved().then((value) {
      numOfPage = value.first;
      controller.approvedPosts.value = value.second;
    });
    isLoading.value = false;
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
                    controller: scrollController,
                    itemCount: controller.approvedPosts.length + 1,
                    itemBuilder: (context, index) {
                      if (index < controller.approvedPosts.length) {
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
                      } else {
                        return Obx(
                          () => hasMore.value
                              ? const Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : const SizedBox(height: 20),
                        );
                      }
                    },
                  ),
      ),
    );
  }
}
