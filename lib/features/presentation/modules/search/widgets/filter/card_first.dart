import 'package:flutter/material.dart';
import '../../../../../../config/theme/app_color.dart';
import '../../../../../../core/utils/filter_values.dart';
import '../../../../../../injection_container.dart';
import '../../search_controller.dart';
import 'category_box_radio.dart';
import 'range_slider_custom.dart';

class CardFirst extends StatelessWidget {
  final MySearchController searchController;
  const CardFirst(this.searchController, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CategoryBoxRadio(
            title: "Danh mục",
            categorys: searchController.radioCategory.values,
            selected: searchController.radioCategory.selectedValue,
            onChanged: searchController.radioCategory.onChange,
          ),
          const SizedBox(height: 20),
          RangeSliderCustom(
            title: 'Giá từ ',
            unit: "đ",
            lower: sl.get<FilterValues>().lowerPrice,
            upper: sl.get<FilterValues>().upperPrice,
            lowerValue: searchController.lowerPriceValue,
            upperValue: searchController.upperPriceValue,
            stepValue: 1000000,
            onChangeValue: searchController.changeValuePrice,
          ),
          RangeSliderCustom(
            title: 'Diện tích ',
            unit: "m2",
            lower: sl.get<FilterValues>().lowerArea,
            upper: sl.get<FilterValues>().upperArea,
            lowerValue: searchController.lowerAreaValue,
            upperValue: searchController.upperAreaValue,
            stepValue: 5,
            onChangeValue: searchController.changeAreaValue,
          ),
        ],
      ),
    );
  }
}
