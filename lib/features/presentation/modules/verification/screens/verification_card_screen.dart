import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/config/theme/text_styles.dart';
import 'package:nhagiare_mobile/core/extensions/integer_ex.dart';
import 'package:nhagiare_mobile/core/extensions/textstyle_ex.dart';
import 'package:nhagiare_mobile/features/presentation/modules/verification/verification_controller.dart';
import '../../../../../config/theme/app_color.dart';
import '../widgets/change_type_doc.dart';
import '../widgets/choose_image.dart';
import '../widgets/stepper_identify.dart';

class VerificationCardScreen extends StatelessWidget {
  VerificationCardScreen({super.key});

  final VerificationController _controller = Get.find<VerificationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text("Chụp ảnh giấy tờ tùy thân"),
      ),
      // body
      body: Column(
        children: [
// container steps
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.all(10),
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
            child: Column(
              children: [
                Text(
                  "Vui lòng gửi hình ảnh giấy tờ còn hạn, hình gốc không scan hay photocopy.",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bold14,
                ),
                const SizedBox(height: 10),
                const StepperIdentify(0),
              ],
            ),
          ),
// change type identity documents
          ChangeTypeDoc(_controller),
          // text chup 2 mat
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              children: [
                Text(
                  "Chụp 2 mặt của giấy tờ",
                  style: AppTextStyles.bold14,
                ),
              ],
            ),
          ),
          // 2 image
          Row(
            children: [
              ChooseImage(_controller, true), // mặt trước
              ChooseImage(_controller, false), // mặt sau
            ],
          ),
          const Expanded(child: SizedBox()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Obx(
              () => ElevatedButton(
                onPressed: _controller.isCanClickCard.value
                    ? () {
                        _controller.navToPortraitSceen();
                      }
                    : null,
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
                  'Tiếp tục'.tr,
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
