import 'package:coupon_uikit/coupon_uikit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/config/theme/app_color.dart';
import 'package:nhagiare_mobile/config/theme/text_styles.dart';
import 'package:nhagiare_mobile/core/resources/pair.dart';
import 'package:nhagiare_mobile/features/domain/entities/purchase/discount_code.dart';
import 'package:nhagiare_mobile/features/presentation/modules/purchase/purchase_controller.dart';

class DiscountCard extends StatelessWidget {
  final String? currentSelectedDiscountCode;
  final DiscountCodeEntity discount;
  final Function(DiscountCodeEntity)? onSelected;

  const DiscountCard(
      {super.key,
      required this.discount,
      this.currentSelectedDiscountCode,
      this.onSelected});
  String calculateRemainingTime(DateTime expirationDate) {
    DateTime now = DateTime.now();
    Duration remainingDuration = expirationDate.difference(now);
    if (remainingDuration.inDays > 2) {
      return 'HSD: ${expirationDate.day}/${expirationDate.month}/${expirationDate.year}';
    } else if (remainingDuration.inDays > 1) {
      return 'Sắp hết hạn: ${remainingDuration.inDays} ngày';
    } else if (remainingDuration.inHours > 1) {
      return 'Sắp hết hạn: ${remainingDuration.inHours} giờ';
    } else {
      return 'Sắp hết hạn: ${remainingDuration.inMinutes} phút';
    }
  }

  @override
  Widget build(BuildContext context) {
    return CouponCard(
      border: const BorderSide(
        color: AppColors.grey100,
        width: 2,
      ),
      curveAxis: Axis.vertical,
      firstChild: Container(
        color: AppColors.green200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // Space between
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Center(
                child: Text(
                  '${(discount.discountPercent * 100).toInt()}%',
                  style: AppTextStyles.bold20.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
            const Divider(
              color: AppColors.green100,
              thickness: 1,
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    discount.description,
                    style: AppTextStyles.regular12.copyWith(
                      color: AppColors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      secondChild: Container(
        padding: const EdgeInsets.fromLTRB(10, 20, 5, 20),
        color: AppColors.green100,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Mã giảm giá',
                      style: AppTextStyles.semiBold12.copyWith(
                        color: AppColors.grey500,
                      )),
                  Text(
                    discount.code,
                    style: AppTextStyles.bold24.copyWith(
                      color: AppColors.green,
                    ),
                  ),
                  const Expanded(child: SizedBox.shrink()),
                  Text(
                    'Đăng ký tối thiểu ${discount.minSubscriptionMonths} tháng',
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.semiBold12.copyWith(
                      color: AppColors.grey500,
                    ),
                  ),
                  Text(
                    calculateRemainingTime(
                        DateTime.parse(discount.expirationDate)),
                    style: AppTextStyles.semiBold12.copyWith(
                      color: AppColors.grey500,
                    ),
                  ),
                ],
              ),
            ),

            // Radio button,
            Radio(
              fillColor: MaterialStateProperty.resolveWith(
                (states) => AppColors.green,
              ),
              value: discount.code,
              groupValue: currentSelectedDiscountCode,
              onChanged: (val) {
                onSelected?.call(discount);
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey,
    );
  }
}

class VoucherScreen extends StatefulWidget {
  String? currentSelectedDiscountCode;
  String packageId;

  VoucherScreen({
    super.key,
    this.currentSelectedDiscountCode,
    required this.packageId,
  });

  @override
  _VoucherScreenState createState() => _VoucherScreenState();
}

class _VoucherScreenState extends State<VoucherScreen> {
  final List<DiscountCodeEntity> discountList = [];
  final PurchaseController controller = Get.find<PurchaseController>();
  int currentPage = 1;
  int numOfPage = 1;
  bool isLoading = false;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(scrollListener);
    loadDiscountCodes();
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    super.dispose();
  }

  void scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (currentPage <= numOfPage) {
        // Reached the end of the list, load more data
        loadDiscountCodes();
      }
    }
  }

  Future<void> loadDiscountCodes() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      // Fetch data for the next page
      final Pair<int, List<DiscountCodeEntity>> result =
          await controller.getAllDiscountCodes(
        currentPage,
        widget.packageId,
      );

      setState(() {
        numOfPage = result.first;
        discountList.addAll(result.second);
        currentPage++;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mã giảm giá"),
        actions: [
          TextButton(
            onPressed: widget.currentSelectedDiscountCode == null
                ? null
                : () {
                    Navigator.pop(
                        context,
                        discountList.firstWhereOrNull((element) =>
                            element.code ==
                            widget.currentSelectedDiscountCode));
                  },
            child: Text(
              "Áp dụng",
              style: AppTextStyles.semiBold16.copyWith(
                color: widget.currentSelectedDiscountCode == null
                    ? AppColors.grey300
                    : AppColors.green,
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: discountList.length + 1,
        itemBuilder: (context, index) {
          if (index < discountList.length) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: DiscountCard(
                discount: discountList[index],
                currentSelectedDiscountCode: widget.currentSelectedDiscountCode,
                onSelected: (discount) {
                  setState(() {
                    widget.currentSelectedDiscountCode = discount.code;
                    print(widget.currentSelectedDiscountCode);
                  });
                },
              ),
            );
          } else {
            return !isLoading
                ? const SizedBox.shrink()
                : const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
          }
        },
        controller: scrollController,
      ),
    );
  }
}
