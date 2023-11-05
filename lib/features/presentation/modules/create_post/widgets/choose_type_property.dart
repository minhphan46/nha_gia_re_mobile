import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/config/theme/app_color.dart';
import 'package:nhagiare_mobile/config/theme/text_styles.dart';
import 'package:nhagiare_mobile/features/domain/enums/property_types.dart';
import 'package:nhagiare_mobile/features/presentation/global_widgets/base_dropdown_button.dart';
import 'package:nhagiare_mobile/features/presentation/modules/create_post/create_post_controller.dart';

class ChooseTypePropertyCard extends StatelessWidget {
  ChooseTypePropertyCard({super.key});

  final CreatePostController controller = Get.find<CreatePostController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BaseDropdownButton(
          hint: "Loại bất động sản",
          value: controller.selectedPropertyType!.value,
          items: PropertyTypes.toMap().entries.map((entry) {
            return DropdownMenuItem(
              value: entry.key,
              child: Text(entry.value),
            );
          }).toList(),
          onChanged: controller.isReachLimitPost
              ? null
              : (value) {
                  if (value != null) {
                    controller.setVisibility(value as PropertyTypes);
                  }
                },
          onSaved: (value) {
            if (value == null) return;
            print("Save DropDown Fied$value");
          },
        ),

        const SizedBox(height: 10),

        /// can ban/ cho thue
        Obx(() => Visibility(
              visible: controller.selectedPropertyType!.value !=
                          PropertyTypes.motel &&
                      controller.selectedPropertyType != null
                  ? true
                  : false,
              child: Row(
                children: [
                  Obx(
                    () => GestureDetector(
                      onTap: () {
                        controller.setWork(true);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: controller.isShowSale.value == true
                              ? AppColors.greenLight
                              : AppColors.grey200,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Cần bán",
                          style: AppTextStyles.medium14.copyWith(
                            color: controller.isShowSale.value == true
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
                        controller.setWork(false);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: controller.isShowSale.value != true
                              ? AppColors.greenLight
                              : AppColors.grey200,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Cho thuê",
                          style: AppTextStyles.medium14.copyWith(
                            color: controller.isShowSale.value != true
                                ? AppColors.green
                                : AppColors.grey600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
