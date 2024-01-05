import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/config/theme/app_color.dart';
import 'package:nhagiare_mobile/config/theme/text_styles.dart';
import 'package:nhagiare_mobile/core/extensions/integer_ex.dart';
import 'package:nhagiare_mobile/core/extensions/textstyle_ex.dart';
import 'package:nhagiare_mobile/features/domain/entities/purchase/discount_code.dart';
import 'package:nhagiare_mobile/features/domain/entities/purchase/membership_package.dart';
import 'package:nhagiare_mobile/features/presentation/modules/purchase/purchase_controller.dart';
import 'package:nhagiare_mobile/features/presentation/modules/purchase/screens/purchase_payment_result_screen.dart';
import 'package:nhagiare_mobile/features/presentation/modules/purchase/screens/voucher_screen.dart';

class MonthPackageWidget extends StatelessWidget {
  final int index;
  final int selectedRadio;
  final ValueChanged<int> onRadioChanged;
  final List<int> months;
  final MembershipPackageEntity package;
  final DiscountCodeEntity? selectedDiscountCode;
  MonthPackageWidget({
    required this.index,
    required this.selectedRadio,
    required this.onRadioChanged,
    required this.months,
    required this.package,
    this.selectedDiscountCode,
  });

  @override
  Widget build(BuildContext context) {
    bool isEnable = selectedDiscountCode != null &&
        selectedDiscountCode!.packageId == package.id &&
        selectedDiscountCode!.minSubscriptionMonths <= months[index];
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: ListTile(
        tileColor:
            selectedRadio == index ? AppColors.green.withOpacity(0.15) : null,
        onTap: () {
          onRadioChanged(index);
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
          groupValue: selectedRadio,
          onChanged: (val) {
            onRadioChanged(val as int);
          },
        ),
        title: Text(
          "Gói ${months[index]} tháng",
          style: AppTextStyles.bold16.colorEx(AppColors.green),
        ),
        subtitle: isEnable
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "${(package.pricePerMonth * months[index]).toInt().formatNumberWithCommas}đ",
                      style: AppTextStyles.regular14
                          .copyWith(decoration: TextDecoration.lineThrough)),
                  Text(
                    "${(package.pricePerMonth * months[index] * (1 - selectedDiscountCode!.discountPercent)).toInt().formatNumberWithCommas}đ",
                    style: AppTextStyles.regular14.colorEx(AppColors.green),
                  ),
                ],
              )
            : Text(
                "${(package.pricePerMonth * months[index]).toInt().formatNumberWithCommas}đ",
                style: AppTextStyles.regular14,
              ),
      ),
    );
  }
}

class PurchaseChoosePlanScreen extends StatelessWidget {
  final MembershipPackageEntity package = Get.arguments;
  final Rx<DiscountCodeEntity?> selectedDiscountCode = Rx(null);
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
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: AppColors.grey200,
              width: 1,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ListTile(
                title: Text(
                  "Mã giảm giá",
                  style: AppTextStyles.bold16.colorEx(AppColors.green),
                ),
                trailing: Text(
                  "Chọn mã giảm giá",
                  style: AppTextStyles.regular14.colorEx(AppColors.green),
                ),
                subtitle: Obx(() {
                  return selectedDiscountCode.value != null
                      ? Text(
                          "${(selectedDiscountCode.value!.discountPercent * 100).toInt()}% - ${selectedDiscountCode.value!.code}",
                          style:
                              AppTextStyles.regular14.colorEx(AppColors.green),
                        )
                      : Text(
                          "Không có",
                          style:
                              AppTextStyles.regular14.colorEx(AppColors.green),
                        );
                }),
                onTap: () {
                  Get.bottomSheet(
                    VoucherScreen(
                      packageId: package.id,
                    ),
                    isScrollControlled: true,
                    ignoreSafeArea: false,
                  ).then((value) {
                    if (value != null) {
                      selectedDiscountCode.value = value;
                    }
                  });
                },
              ),
              Obx(() => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.green,
                    ),
                    onPressed: (selectedRadio.value != -1 &&
                            isEnableButtom.value)
                        ? () async {
                            CreateOrderResult res =
                                await controller.createOrder(
                                    package.id,
                                    months[selectedRadio.value],
                                    selectedDiscountCode.value?.code);
                            isEnableButtom.value = false;
                            if (res.isCreateSuccess) {
                              Get.to(() => const PurchasePaymentResultScreen(),
                                  arguments: res.appTransId);
                            } else {
                              Get.snackbar(
                                "Thất bại",
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
            ],
          ),
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
                    return MonthPackageWidget(
                      selectedDiscountCode: selectedDiscountCode.value,
                      index: index,
                      selectedRadio: selectedRadio.value,
                      onRadioChanged: (val) {
                        selectedRadio.value = val;
                      },
                      months: months,
                      package: package,
                    );
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
