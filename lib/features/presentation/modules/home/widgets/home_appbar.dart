import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/config/theme/app_color.dart';
import 'package:nhagiare_mobile/config/theme/text_styles.dart';
import 'package:nhagiare_mobile/core/extensions/textstyle_ex.dart';
import '../../../../../config/values/asset_image.dart';
import '../home_controller.dart';
import 'package:badges/badges.dart' as badges;

class HomeAppbar extends StatelessWidget {
  HomeAppbar({super.key});
  final HomeController controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            // Sun
            Image.asset(
              Assets.sun,
              width: 30,
              height: 30,
            ),
            const SizedBox(width: 2),
            // Hello text
            Text(
              'Chào buổi sáng, ${controller.nameUser}!',
              style: AppTextStyles.bold14.colorEx(
                AppColors.green,
              ),
            ),
          ],
        ),
        // Icons
        Row(
          children: [
            Obx(
              () => controller.unreadMessCount.value == 0
                  ? GestureDetector(
                      onTap: () {
                        controller.navigateToChatScreen();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Image.asset(Assets.chat, width: 25),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        controller.navigateToChatScreen();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: badges.Badge(
                          position:
                              badges.BadgePosition.topStart(top: -8, start: 18),
                          badgeContent: Text(
                            controller.unreadMessCount.value.toString(),
                            style:
                                AppTextStyles.bold10.colorEx(AppColors.white),
                          ),
                          badgeStyle: const badges.BadgeStyle(
                            badgeColor: AppColors.green,
                          ),
                          child: Image.asset(Assets.chat, width: 25),
                        ),
                      ),
                    ),
            ),
            Obx(
              () => controller.unreadNotiCount.value == 0
                  ? GestureDetector(
                      onTap: () {
                        controller.navigateToNotificationScreen();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 0),
                        child: Image.asset(Assets.notification, width: 25),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(right: 0),
                      child: GestureDetector(
                        onTap: () {
                          controller.navigateToNotificationScreen();
                        },
                        child: badges.Badge(
                          position:
                              badges.BadgePosition.topStart(top: -8, start: 18),
                          badgeContent: Text(
                            controller.unreadNotiCount.value.toString(),
                            style:
                                AppTextStyles.bold10.colorEx(AppColors.white),
                          ),
                          badgeStyle: const badges.BadgeStyle(
                            badgeColor: AppColors.green,
                          ),
                          child: Image.asset(Assets.notification, width: 25),
                        ),
                      ),
                    ),
            ),
          ],
        )
      ],
    );
  }
}
