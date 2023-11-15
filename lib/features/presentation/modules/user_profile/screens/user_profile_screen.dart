import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nhagiare_mobile/config/theme/app_color.dart';
import 'package:nhagiare_mobile/config/theme/text_styles.dart';
import 'package:nhagiare_mobile/core/extensions/integer_ex.dart';
import 'package:nhagiare_mobile/core/extensions/textstyle_ex.dart';
import 'package:nhagiare_mobile/features/presentation/global_widgets/my_appbar.dart';
import 'package:nhagiare_mobile/features/presentation/modules/user_profile/user_profile_controller.dart';
import 'package:nhagiare_mobile/features/presentation/modules/user_profile/widgets/button_follow.dart';

import '../../../../../config/values/asset_image.dart';

class UserProfileScreen extends StatelessWidget {
  UserProfileScreen({super.key});

  final UserProfileController controller = UserProfileController();

  @override
  Widget build(BuildContext context) {
    double sizeImage = 22.wp;
    return Scaffold(
      appBar: MyAppbar(
          title: '${controller.user!.firstName} ${controller.user!.lastName!}'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
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
                    SizedBox(
                      width: 68.wp,
                      child: Column(
                        children: [
                          // info
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Bai viet
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      controller.numberPost.toString(),
                                      style: AppTextStyles.semiBold16
                                          .colorEx(AppColors.grey700),
                                    ),
                                    Text(
                                      "Bài viết",
                                      style: AppTextStyles.medium12
                                          .colorEx(AppColors.grey700),
                                    ),
                                  ],
                                ),
                                // Người theo dõi
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      controller.numberFollower.toString(),
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      controller.numberFollowing.toString(),
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
                            ),
                          ),
                          const SizedBox(height: 5),
                          // button follow
                          const ButtonFollow(
                            isFollow: true,
                            isMe: false,
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
