import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/config/theme/app_color.dart';
import 'package:nhagiare_mobile/config/theme/text_styles.dart';
import 'package:nhagiare_mobile/core/extensions/textstyle_ex.dart';
import 'package:nhagiare_mobile/features/domain/enums/property_types.dart';
import 'package:nhagiare_mobile/features/presentation/modules/create_post/create_post_controller.dart';

class ChooseTypePropertyCard extends StatelessWidget {
  ChooseTypePropertyCard({super.key});

  final CreatePostController controller = Get.find<CreatePostController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: const BoxDecoration(
          color: AppColors.grey100,
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Loại bất động sản",
            style: AppTextStyles.bold14.colorEx(Colors.black),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(color: AppColors.green),
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              filled: true,
              fillColor: AppColors.white,
            ),
            style: AppTextStyles.regular14.colorEx(Colors.black),
            dropdownColor: AppColors.white,
            value: controller.selectedPropertyType!.value,
            hint: const Text("Chọn loại bất động sản"),
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
      ),
    );
  }
}