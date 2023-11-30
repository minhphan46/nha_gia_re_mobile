import 'package:flutter/material.dart';
import '../../../../../../config/theme/app_color.dart';
import '../../../../../../config/theme/text_styles.dart';
import '../../search_controller.dart';
import 'category_box_check.dart';
import 'category_box_radio.dart';

class CardApartment extends StatelessWidget {
  final MySearchController searchController;
  const CardApartment(this.searchController, {super.key});

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
              "Thông số kĩ thuật",
              style: AppTextStyles.semiBold16.copyWith(color: AppColors.black),
            ),
          ),
          const SizedBox(height: 10),
          CategoryBoxRadio(
            title: "Tình trạng",
            categorys: searchController.apartmentStatus.values,
            selected: searchController.apartmentStatus.selectedValue,
            onChanged: searchController.apartmentStatus.onChange,
          ),
          const SizedBox(height: 10),
          CategoryBoxCheck(
            title: "Loại hình căn hộ",
            categorys: searchController.apartmentTypes.checkListItems,
            multipleSelected: searchController.apartmentTypes.multipleSelected,
            onChanged: searchController.apartmentTypes.onChange,
          ),
          const SizedBox(height: 10),
          CategoryBoxRadio(
            title: "Đặc điểm căn hộ",
            categorys: searchController.apartmentCharacteristics.values,
            selected: searchController.apartmentCharacteristics.selectedValue,
            onChanged: searchController.apartmentCharacteristics.onChange,
          ),
          const SizedBox(height: 10),
          CategoryBoxCheck(
            title: "Số phòng ngủ",
            categorys: searchController.apartmentBedroomNumber.checkListItems,
            multipleSelected:
                searchController.apartmentBedroomNumber.multipleSelected,
            onChanged: searchController.apartmentBedroomNumber.onChange,
          ),
          const SizedBox(height: 10),
          CategoryBoxCheck(
            title: "Hướng cửa chính",
            categorys: searchController.apartmentMainDirection.checkListItems,
            multipleSelected:
                searchController.apartmentMainDirection.multipleSelected,
            onChanged: searchController.apartmentMainDirection.onChange,
          ),
          const SizedBox(height: 10),
          CategoryBoxCheck(
            title: "Hướng ban công",
            categorys:
                searchController.apartmentBalconyDirection.checkListItems,
            multipleSelected:
                searchController.apartmentBalconyDirection.multipleSelected,
            onChanged: searchController.apartmentBalconyDirection.onChange,
          ),
          const SizedBox(height: 10),
          CategoryBoxCheck(
            title: "Giấy tờ pháp lý",
            categorys: searchController.apartmentLegalDocuments.checkListItems,
            multipleSelected:
                searchController.apartmentLegalDocuments.multipleSelected,
            onChanged: searchController.apartmentLegalDocuments.onChange,
          ),
          const SizedBox(height: 10),
          CategoryBoxCheck(
            title: "Tình trạng nội thất",
            categorys: searchController.apartmentInteriorStatus.checkListItems,
            multipleSelected:
                searchController.apartmentInteriorStatus.multipleSelected,
            onChanged: searchController.apartmentInteriorStatus.onChange,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
