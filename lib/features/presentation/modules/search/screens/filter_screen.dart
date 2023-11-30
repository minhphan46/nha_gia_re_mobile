import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/core/extensions/integer_ex.dart';
import 'package:nhagiare_mobile/core/extensions/textstyle_ex.dart';
import 'package:nhagiare_mobile/features/presentation/global_widgets/my_appbar.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../search_controller.dart';
import '../widgets/filter/card_apartment.dart';
import '../widgets/filter/card_first.dart';
import '../widgets/filter/card_house.dart';
import '../widgets/filter/card_land.dart';
import '../widgets/filter/card_office.dart';
import '../widgets/filter/card_posted_by.dart';
import '../widgets/filter/card_rent.dart';
import '../widgets/filter/card_sort_by.dart';

class FilterScreen extends StatelessWidget {
  FilterScreen({super.key});
  final MySearchController searchController = Get.find<MySearchController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey100,
// appbar
      appBar: MyAppbar(
        title: "Lọc kết quả",
        actions: [
          TextButton(
            onPressed: () {
              // deletefilter
              searchController.deleteFilter();
            },
            child: Text(
              "Đặt lại",
              style: AppTextStyles.semiBold16.copyWith(color: AppColors.black),
            ),
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.close),
          color: AppColors.black,
          onPressed: () {
            searchController.popScreen();
            searchController.deleteFilter();
          },
        ),
      ),
// body
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            children: [
              // cards
              CardFirst(searchController),
              if (searchController.radioCategory.selectedValue.value == 1)
                CardApartment(searchController),
              if (searchController.radioCategory.selectedValue.value == 2)
                CardHouse(searchController),
              if (searchController.radioCategory.selectedValue.value == 3)
                CardLand(searchController),
              if (searchController.radioCategory.selectedValue.value == 4)
                CardOffice(searchController),
              if (searchController.radioCategory.selectedValue.value == 5)
                CardRent(searchController),
              CardSortBy(searchController),
              CardPostedBy(searchController),

              // dang bai ============================================
              Obx(
                () => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: ElevatedButton(
                    onPressed: searchController.isLoadingFilter.value
                        ? null
                        : () {
                            searchController.applyFilter();
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.green,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      textStyle: const TextStyle(color: AppColors.white),
                      elevation: 10,
                      minimumSize: Size(100.wp, 55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: searchController.isLoadingFilter.value
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            'Áp dụng'.tr,
                            style:
                                AppTextStyles.bold14.colorEx(AppColors.white),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
