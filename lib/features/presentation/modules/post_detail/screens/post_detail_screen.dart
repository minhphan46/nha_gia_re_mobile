import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/config/values/asset_image.dart';
import 'package:nhagiare_mobile/core/extensions/date_ex.dart';
import 'package:nhagiare_mobile/core/extensions/double_ex.dart';
import 'package:nhagiare_mobile/core/extensions/integer_ex.dart';
import 'package:nhagiare_mobile/core/extensions/textstyle_ex.dart';
import 'package:nhagiare_mobile/features/presentation/global_widgets/my_appbar.dart';
import 'package:nhagiare_mobile/features/presentation/modules/post_detail/post_detail_controller.dart';
import 'package:nhagiare_mobile/features/presentation/modules/post_detail/widgets/description_card.dart';
import 'package:nhagiare_mobile/features/presentation/modules/post_detail/widgets/user_card.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../global_widgets/image_card.dart';
import '../../../global_widgets/info_card_list.dart';
import '../widgets/expandable_container.dart';

class PostDetailScreen extends StatelessWidget {
  PostDetailScreen({super.key});

  final PostDetailController controller = Get.find<PostDetailController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(
        title: controller.post.title ?? "",
        actions: [
          IconButton(
            onPressed: () {
              controller.navToEditPost();
            },
            icon: Obx(() => controller.isYourPost.value
                ? const Icon(
                    Icons.edit_outlined,
                    color: AppColors.green,
                  )
                : const SizedBox()),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            // images
            const SizedBox(height: 10),
            ImageCard(images: controller.post.images ?? []),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // title
                  Text(
                    controller.post.title!,
                    style: AppTextStyles.semiBold18,
                  ),
                  // Price
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text.rich(
                        TextSpan(
                          text: double.parse(controller.post.price!)
                              .toFormattedMoney(),
                          style: AppTextStyles.semiBold14
                              .colorEx(AppColors.orange),
                          children: <InlineSpan>[
                            TextSpan(
                              text: " - ${controller.post.area!} m2",
                              style: AppTextStyles.medium14
                                  .colorEx(AppColors.grey500),
                            )
                          ],
                        ),
                      ),
                      Obx(
                        () => Visibility(
                          visible: true,
                          child: controller.isLoading.value
                              ? const SizedBox(
                                  width: 25,
                                  height: 25,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    controller.likePost();
                                  },
                                  child: SizedBox(
                                    child: controller.isLiked.value
                                        ? const Icon(
                                            Icons.favorite_sharp,
                                            color: AppColors.red,
                                          )
                                        : const Icon(
                                            Icons.favorite_border_rounded),
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                  // Address
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        Assets.home,
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 80.wp,
                        child: Text(
                          controller.post.address!.getDetailAddress(),
                          style:
                              AppTextStyles.medium14.colorEx(AppColors.grey500),
                        ),
                      )
                    ],
                  ),

                  // time
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        Assets.clock,
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Đăng ${controller.post.postedDate!.getTimeAgoVi()}",
                        style:
                            AppTextStyles.medium14.colorEx(AppColors.grey500),
                      )
                    ],
                  ),
                ],
              ),
            ),

            // Post's User
            const SizedBox(height: 20),
            UserCard(),
            // details
            const SizedBox(height: 20),
            ExpandableContainer(
              title: 'Chi tiết'.tr,
              //minHeight: 130,
              minHeight: (controller.getNumOfFeaturesNotNull() / 2) < 3
                  ? controller.getNumOfFeaturesNotNull() / 2 * 40
                  : 130,
              child: controller.getDetailCard(),
            ),
            // description
            const SizedBox(height: 20),
            DescriptionCard(
              description: controller.post.description ?? "",
            ),
            const SizedBox(height: 20),
            InforCardList(
              title: 'Liên quan',
              getListFunc: () => controller.getRelatePosts(),
              //list: data[1],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => (!controller.isYourPost.value)
            ? BottomAppBar(
                padding: const EdgeInsets.all(0),
                color: Colors.white,
                child: SizedBox(
                  child: Row(children: [
                    Expanded(
                        child: MaterialButton(
                            elevation: 0,
                            onPressed: controller.launchPhone,
                            color: AppColors.green,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.phone_in_talk_outlined,
                                    size: 24,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'Gọi điện'.tr,
                                    style: AppTextStyles.regular12
                                        .copyWith(color: Colors.white),
                                  )
                                ]))),
                    Expanded(
                        child: MaterialButton(
                            onPressed: controller.navToChat,
                            color: Colors.white,
                            elevation: 0,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    Assets.chatGreen,
                                    width: 24,
                                    color: AppColors.green,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'Nhắn tin'.tr,
                                    style: AppTextStyles.regular12
                                        .copyWith(color: AppColors.green),
                                  )
                                ]))),
                    Expanded(
                        child: MaterialButton(
                            onPressed: controller.launchSms,
                            color: Colors.white,
                            elevation: 0,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.sms_outlined,
                                    size: 24,
                                    color: AppColors.green,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'SMS'.tr,
                                    style: AppTextStyles.regular12
                                        .copyWith(color: AppColors.green),
                                  )
                                ])))
                  ]),
                ))
            : const SizedBox(),
      ),
    );
  }
}
