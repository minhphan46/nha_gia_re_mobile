import 'package:flutter/material.dart';
import 'package:flutter_zalopay_sdk/flutter_zalopay_sdk.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/config/theme/app_color.dart';
import 'package:nhagiare_mobile/config/theme/text_styles.dart';
import 'package:nhagiare_mobile/core/extensions/integer_ex.dart';
import 'package:nhagiare_mobile/core/extensions/textstyle_ex.dart';
import 'package:nhagiare_mobile/features/domain/entities/membership_package.dart';
import 'package:nhagiare_mobile/features/presentation/modules/purchase/purchase_controller.dart';

class PurchaseChoosePlanScreen extends StatelessWidget {
  final MembershipPackageEntity package = Get.arguments;

  PurchaseChoosePlanScreen({Key? key}) : super(key: key);

  final PurchaseController controller = Get.find<PurchaseController>();
  final RxInt selectedRadio = (-1).obs;
  final List<int> months = [1, 3, 6, 12];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(package.name),
      ),
      bottomSheet: FractionallySizedBox(
        widthFactor: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Obx(() => ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.green,
                ),
                onPressed: selectedRadio.value != -1
                    ? () {
                        FlutterZaloPaySdk.payOrder(
                            zpToken: 'AC4EID9new40bcbEYZShlfJQ');
                      }
                    : null,
                child: const Text(
                  "Mua ngay",
                  style: TextStyle(color: AppColors.white),
                ),
              )),
        ),
      ),
      body: ListView.builder(
        itemCount: months.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Obx(() {
              return ListTile(
                tileColor: selectedRadio.value == index
                    ? AppColors.green.withOpacity(0.15)
                    : null,
                onTap: () {
                  selectedRadio.value = index;
                },
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    color: AppColors.green,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                leading: Radio(
                  fillColor: MaterialStateProperty.resolveWith(
                    (states) => AppColors.green,
                  ),
                  value: index,
                  groupValue: selectedRadio.value,
                  onChanged: (val) {
                    selectedRadio.value = val as int;
                  },
                ),
                title: Text(
                  "Gói ${months[index]} tháng",
                  style: AppTextStyles.bold16.colorEx(AppColors.green),
                ),
                subtitle: Text(
                  "${(package.pricePerMonth * months[index]).toInt().formatNumberWithCommas}đ",
                  style: AppTextStyles.regular14,
                ),
              );
            }),
          );
        },
      ),
    );
  }
}