import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/core/extensions/integer_ex.dart';
import 'package:nhagiare_mobile/core/extensions/textstyle_ex.dart';
import 'package:nhagiare_mobile/features/presentation/global_widgets/my_appbar.dart';

import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../global_widgets/base_card.dart';
import '../../../global_widgets/base_dropdown_button.dart';
import '../create_post_controller.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final CreatePostController controller = Get.find<CreatePostController>();

  @override
  void initState() {
    super.initState();
    controller.getProvinceNames();
  }

  List<DropdownMenuItem<String>>? getProvinceItems() {
    return controller.provinceNames.map((Map<String, dynamic> value) {
      return DropdownMenuItem<String>(
        value: value['name'],
        child: Text(
          value['name'],
          style: AppTextStyles.regular14.copyWith(color: AppColors.black),
        ),
      );
    }).toList();
  }

  List<DropdownMenuItem<String>>? getDistrictItems() {
    return controller.districtNames.map((Map<String, dynamic> value) {
      return DropdownMenuItem<String>(
        value: value['name'],
        child: Text(
          value['name'],
          style: AppTextStyles.regular14.copyWith(color: AppColors.black),
        ),
      );
    }).toList();
  }

  List<DropdownMenuItem<String>>? getWardItems() {
    return controller.wardNames.map((Map<String, dynamic> value) {
      return DropdownMenuItem<String>(
        value: value['name'],
        child: Text(
          value['name'],
          style: AppTextStyles.regular14.copyWith(color: AppColors.black),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(title: "Địa chỉ"),
      body: ListView(
        children: [
          BaseCard(
            title: "Chọn địa chỉ",
            isvisible: true,
            child: Column(
              children: [
                Obx(
                  () => BaseDropdownButton(
                    hint: "Tỉnh/Thành phố",
                    value: controller.selectedProvince.value,
                    items: getProvinceItems(),
                    onChanged: (value) {
                      // print type of value
                      controller.changeSelectedProvince(value as String);
                    },
                    onSaved: (value) {
                      controller.changeSelectedProvince(value as String);
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Obx(
                  () => BaseDropdownButton(
                    hint: "Huyện/Quận",
                    value: controller.selectedDistrict.value,
                    items: getDistrictItems(),
                    onChanged: (value) {
                      // print type of value
                      controller.changeSelectedDistrict(value as String);
                    },
                    onSaved: (value) {
                      controller.changeSelectedDistrict(value as String);
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Obx(
                  () => BaseDropdownButton(
                    hint: "Phường/Xã",
                    value: controller.selectedWard.value,
                    items: getWardItems(),
                    onChanged: (value) {
                      // print type of value
                      controller.changeSelectedWard(value as String);
                    },
                    onSaved: (value) {
                      controller.changeSelectedWard(value as String);
                    },
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: true,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ElevatedButton(
                onPressed: () {
                  controller.createAddress();
                  Get.back();
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
                child: Text(
                  'Hoàn tất'.tr,
                  style: AppTextStyles.bold14.colorEx(AppColors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
