import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/config/theme/app_color.dart';
import 'package:nhagiare_mobile/config/theme/text_styles.dart';
import 'package:nhagiare_mobile/core/extensions/date_ex.dart';
import 'package:nhagiare_mobile/core/extensions/integer_ex.dart';
import 'package:nhagiare_mobile/core/extensions/textstyle_ex.dart';
import 'package:nhagiare_mobile/features/domain/entities/posts/real_estate_post.dart';
import 'package:nhagiare_mobile/features/presentation/global_widgets/my_appbar.dart';
import 'package:nhagiare_mobile/features/presentation/modules/user_profile/user_profile_controller.dart';
import 'package:nhagiare_mobile/features/presentation/modules/user_profile/widgets/button_follow.dart';
import 'package:nhagiare_mobile/features/presentation/modules/user_profile/widgets/tab_profile.dart';
import 'package:nhagiare_mobile/features/presentation/modules/user_profile/widgets/verify_component.dart';

import '../../../../../config/values/asset_image.dart';
import '../../../../../core/resources/pair.dart';

class UserProfileScreen extends StatelessWidget {
  UserProfileScreen({super.key});

  final UserProfileController controller = UserProfileController();
  @override
  Widget build(BuildContext context) {
    double sizeImage = 22.wp;
    return Scaffold(
      appBar: MyAppbar(title: controller.user!.fullName),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // avatar ========================================
                    if (controller.user!.avatar != null)
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: CachedNetworkImage(
                          imageUrl: controller.user!.avatar!,
                          fit: BoxFit.cover,
                          width: sizeImage,
                          errorWidget: (context, _, __) {
                            return CircleAvatar(
                              radius: sizeImage / 2,
                              backgroundImage: const AssetImage(Assets.avatar2),
                            );
                          },
                        ),
                      )
                    else
                      CircleAvatar(
                        radius: sizeImage / 2,
                        backgroundImage: const AssetImage(Assets.avatar2),
                      ),
                    const SizedBox(width: 10),
                    // info ========================================
                    Expanded(
                      child: Column(
                        children: [
                          // info
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: FutureBuilder<Pair<int, int>>(
                                future:
                                    controller.getFollowersAndFollowingsCount(),
                                builder: (context, snapshot) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Bai viet
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Obx(() => Text(
                                                controller.numOfPosts.value,
                                                style: AppTextStyles.semiBold16
                                                    .colorEx(AppColors.grey700),
                                              )),
                                          Text(
                                            "Bài viết",
                                            style: AppTextStyles.medium12
                                                .colorEx(AppColors.grey700),
                                          ),
                                        ],
                                      ),
                                      // Người theo dõi
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            snapshot.data?.first.toString() ??
                                                "-",
                                            style: AppTextStyles.semiBold16
                                                .colorEx(AppColors.grey700),
                                          ),
                                          Text(
                                            "Người theo dõi",
                                            style: AppTextStyles.medium12
                                                .colorEx(AppColors.grey700),
                                          ),
                                        ],
                                      ),
                                      // Đang theo dõi
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            snapshot.data?.second.toString() ??
                                                "-",
                                            style: AppTextStyles.semiBold16
                                                .colorEx(AppColors.grey700),
                                          ),
                                          Text(
                                            "Đang theo dõi",
                                            style: AppTextStyles.medium12
                                                .colorEx(AppColors.grey700),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                }),
                          ),
                          const SizedBox(height: 5),
                          // button follow
                          const ButtonFollow(
                            isFollow: false,
                            isMe: true,
                          )
                        ],
                      ),
                    )
                  ],
                ),

                // name ============================================
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      '${controller.user!.firstName} ${controller.user!.lastName!}',
                      style:
                          AppTextStyles.semiBold16.colorEx(AppColors.grey700),
                    ),
                    const SizedBox(width: 5),
                    const VerifyComponent(isVerify: true, isMe: true),
                  ],
                ),
                // location ========================================
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      Assets.location,
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      width: 80.wp,
                      child: Text(
                        controller.user!.address!.getDetailAddress(),
                        style:
                            AppTextStyles.medium14.colorEx(AppColors.grey500),
                      ),
                    )
                  ],
                ),
                // dateCreate ======================================
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      Assets.calendar,
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      width: 80.wp,
                      child: Text(
                        "Tham gia ngày ${controller.user!.createdAt!.toDMYString()}",
                        style:
                            AppTextStyles.medium14.colorEx(AppColors.grey500),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          // tab ==============================================
          FutureBuilder<List<RealEstatePostEntity>>(
              future: controller.getAllPosts(),
              builder: (context, snapshot) {
                return TabProfile(
                  data: snapshot.data,
                );
              }),
        ],
      ),
    );
  }
}
