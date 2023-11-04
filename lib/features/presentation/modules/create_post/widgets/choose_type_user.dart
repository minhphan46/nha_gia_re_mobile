import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/core/extensions/textstyle_ex.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../create_post_controller.dart';

class ChooseTypeUserCard extends StatelessWidget {
  ChooseTypeUserCard({super.key});
  final CreatePostController controller = Get.find<CreatePostController>();

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: controller.selectedPropertyType != null ? true : false,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: const BoxDecoration(
          color: AppColors.grey100,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Bạn là",
              style: AppTextStyles.bold14.colorEx(Colors.black),
            ),
            const SizedBox(height: 8),

            /// can ban/ cho thue

            Row(
              children: [
                Obx(
                  () => GestureDetector(
                    onTap: () {
                      controller.setRole(true);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: controller.isPersonal.value == true
                            ? AppColors.greenLight
                            : AppColors.grey200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "Cá nhân",
                        style: AppTextStyles.medium14.copyWith(
                          color: controller.isPersonal.value == true
                              ? AppColors.green
                              : AppColors.grey600,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Obx(
                  () => GestureDetector(
                    onTap: () {
                      controller.setRole(false);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: controller.isPersonal.value != true
                            ? AppColors.greenLight
                            : AppColors.grey200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "Môi giới",
                        style: AppTextStyles.medium14.copyWith(
                          color: controller.isPersonal.value != true
                              ? AppColors.green
                              : AppColors.grey600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
