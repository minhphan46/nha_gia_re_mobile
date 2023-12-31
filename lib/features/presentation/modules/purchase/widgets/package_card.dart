import 'package:flutter/material.dart';
import 'package:nhagiare_mobile/config/theme/text_styles.dart';
import 'package:nhagiare_mobile/core/extensions/integer_ex.dart';
import 'package:nhagiare_mobile/core/extensions/textstyle_ex.dart';
import 'package:nhagiare_mobile/features/domain/entities/purchase/membership_package.dart';
import '../../../../../config/theme/app_color.dart';

class MembershipPackageCard extends StatelessWidget {
  final MembershipPackageEntity package;
  final bool isShowButton;
  final String buttonText;
  final Color? buttonColor;
  final Function(MembershipPackageEntity package)? onButtonClick;

  const MembershipPackageCard({
    required this.package,
    required this.buttonText,
    this.onButtonClick,
    this.isShowButton = true,
    this.buttonColor = AppColors.green,
    super.key,
  });

  Widget textWithCheckIcon(String text, bool isCheck) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            isCheck ? Icons.check : Icons.close,
            color: isCheck ? AppColors.green : AppColors.red,
          ),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.regular14,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            width: 2.0,
            color: AppColors.green,
          )),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              package.name,
              style: AppTextStyles.bold24,
            ),
            RichText(
              text: TextSpan(
                text: package.pricePerMonth.formatNumberWithCommas,
                style: AppTextStyles.semiBold36.colorEx(AppColors.green),
                children: const <TextSpan>[
                  TextSpan(
                    text: ' VND/THÁNG',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Text(
                package.description,
                style: AppTextStyles.light16,
              ),
            ),
            textWithCheckIcon("Huy hiệu xác minh", true),
            textWithCheckIcon(
                "${package.monthlyPostLimit} tin đăng/tháng (Hiển thị 14 ngày)",
                true),
            textWithCheckIcon(
                "Ưu tiên hiển thị tin", package.displayPriorityPoint > 0),
            textWithCheckIcon(
                "Ưu tiên duyệt tin", package.postApprovalPriorityPoint > 0),
            Visibility(
              visible: isShowButton,
              child: FractionallySizedBox(
                widthFactor: 1,
                child: ElevatedButton(
                  onPressed: onButtonClick != null
                      ? () => onButtonClick!(package)
                      : null,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)))),
                  child: Text(
                    buttonText,
                    style: AppTextStyles.bold16.colorEx(AppColors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
