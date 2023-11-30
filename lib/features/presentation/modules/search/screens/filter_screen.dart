import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/core/extensions/integer_ex.dart';
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
              //searchController.deleteFilter();
            },
            child: Text(
              "Đặt lại",
              style: AppTextStyles.bold16.copyWith(color: AppColors.green),
            ),
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.close),
          color: AppColors.green,
          onPressed: () {
            searchController.popScreen();
            //searchController.deleteFilter();
          },
        ),
      ),
// body
      body: Column(
        children: [
          SizedBox(
            height: 83.hp,
            child: SingleChildScrollView(
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
                  ],
                ),
              ),
            ),
          ),
// apply button
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Material(
                color: AppColors.green,
                child: InkWell(
                  onTap: () async {
                    // Apply filter
                    //print("hafkjsfhasldfhak;asdasd");
                    //await searchController.applyFilter();
                  },
                  child: Container(
                    width: double.infinity,
                    color: Colors.transparent,
                    child: Center(
                      child: Text(
                        "ÁP DỤNG",
                        style: AppTextStyles.regular16
                            .copyWith(color: AppColors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
