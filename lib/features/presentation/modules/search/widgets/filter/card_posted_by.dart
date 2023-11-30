import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_color.dart';
import '../../../../../../config/theme/text_styles.dart';
import '../../search_controller.dart';

class CardPostedBy extends StatelessWidget {
  final MySearchController searchController;
  const CardPostedBy(this.searchController, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      width: double.infinity,
      color: AppColors.white,
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              left: 16,
            ),
            child: Text(
              "Đăng bởi",
              style: AppTextStyles.semiBold16.copyWith(color: AppColors.black),
            ),
          ),
          Obx(() => ListTile(
                horizontalTitleGap: 2,
                title: Text(
                  searchController.radiopostedBy.values[0],
                  style:
                      AppTextStyles.regular14.copyWith(color: AppColors.black),
                ),
                leading: const Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.person_outline,
                    color: AppColors.black,
                  ),
                ),
                trailing: SizedBox(
                  width: 24,
                  child: Radio<int>(
                    value: 0,
                    groupValue:
                        searchController.radiopostedBy.selectedValue.value,
                    onChanged: (value) {
                      searchController.radiopostedBy.onChange(value);
                    },
                  ),
                ),
              )),
          Obx(() => ListTile(
                horizontalTitleGap: 2,
                title: Text(
                  searchController.radiopostedBy.values[1],
                  style:
                      AppTextStyles.regular14.copyWith(color: AppColors.black),
                ),
                leading: const Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.business_center_outlined,
                    color: AppColors.black,
                  ),
                ),
                trailing: SizedBox(
                  width: 24,
                  child: Radio<int>(
                    value: 1,
                    groupValue:
                        searchController.radiopostedBy.selectedValue.value,
                    onChanged: (value) {
                      searchController.radiopostedBy.onChange(value);
                    },
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
