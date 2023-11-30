import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../config/theme/app_color.dart';
import '../../../../../../config/theme/text_styles.dart';
import 'bottom_sheet_check_box.dart';

// ignore: must_be_immutable
class CategoryBoxCheck extends StatelessWidget {
  String title;
  List categorys;
  RxList<String> multipleSelected;
  Function onChanged;

  CategoryBoxCheck({
    required this.title,
    required this.categorys,
    required this.multipleSelected,
    required this.onChanged,
    super.key,
  });

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return BottomSheetCheckBox(
          checkListItems: [...categorys],
          onChanged: onChanged,
        );
      },
    );
  }

  String getTextSelecteds(List<String> selecteds) {
    if (selecteds.isEmpty) return "Tất cả";
    return selecteds.join(", ");
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // show bottomSheet to choose type
        showBottomSheet(context);
      },
      child: Container(
        width: double.infinity,
        height: 58,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: AppColors.grey500,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(right: 13.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.regular14
                          .copyWith(color: AppColors.black),
                    ),
                    const SizedBox(height: 5),
                    Obx(
                      () => Text(
                        getTextSelecteds(multipleSelected),
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.regular14
                            .copyWith(color: AppColors.green),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              child: Icon(
                Icons.arrow_forward_ios,
                color: AppColors.grey500,
                size: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}
