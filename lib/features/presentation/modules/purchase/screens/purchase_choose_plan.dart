import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/config/theme/app_color.dart';
import 'package:nhagiare_mobile/config/theme/text_styles.dart';
import 'package:nhagiare_mobile/core/extensions/integer_ex.dart';
import 'package:nhagiare_mobile/core/extensions/textstyle_ex.dart';
import 'package:nhagiare_mobile/features/domain/entities/purchase/membership_package.dart';
import 'package:nhagiare_mobile/features/presentation/modules/purchase/purchase_controller.dart';
import 'package:nhagiare_mobile/features/presentation/modules/purchase/screens/purchase_payment_result_screen.dart';

class PurchaseChoosePlanScreen extends StatelessWidget {
  final MembershipPackageEntity package = Get.arguments;

  PurchaseChoosePlanScreen({super.key});

  final PurchaseController controller = Get.find<PurchaseController>();
  final RxInt selectedRadio = (-1).obs;
  final RxBool isEnableButtom = true.obs;
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
                onPressed: (selectedRadio.value != -1 && isEnableButtom.value)
                    ? () async {
                        CreateOrderResult res = await controller.createOrder(
                            package.id, months[selectedRadio.value]);
                        isEnableButtom.value = false;
                        if (res.isCreateSuccess) {
                          Get.to(() => const PurchasePaymentResultScreen(),
                              arguments: res.appTransId);
                        } else {
                          Get.snackbar(
                            "Lỗi",
                            res.message!,
                            backgroundColor: AppColors.red,
                            colorText: AppColors.white,
                          );
                          isEnableButtom.value = true;
                        }
                      }
                    : null,
                child: const Text(
                  "Mua ngay",
                  style: TextStyle(color: AppColors.white),
                ),
              )),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: months.length,
                itemBuilder: (context, index) {
                  return Obx(() {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                      child: ListTile(
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
                      ),
                    );
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: "Mã giảm giá",
                          labelStyle: AppTextStyles.regular14,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        // Code xử lý khi nút "Áp dụng" được nhấn
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.green,
                      ),
                      child: const Text(
                        "Áp dụng",
                        style: TextStyle(color: AppColors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
