import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../verification_controller.dart';
import '../widgets/choose_image_portrait.dart';
import '../widgets/stepper_identify.dart';

class VerificationPortraitScreen extends StatelessWidget {
  VerificationPortraitScreen({super.key});
  final VerificationController _controller = Get.find<VerificationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text("Chụp ảnh chân dung"),
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
                  "Vui lòng cung cấp cho chúng tôi hình ảnh thật chân dung của bạn.",
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bold14,
                ),
                const SizedBox(height: 10),
                const StepperIdentify(1),
              ],
            ),
          ),
// change type identity documents
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 20,
            ),
            width: double.infinity,
            child: ChooseImagePortrait(_controller),
          ),
        ],
      ),

      // bottom button
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Obx(
        () => Container(
          height: 50,
          margin: const EdgeInsets.all(10),
          child: ElevatedButton(
            onPressed: _controller.isCanClickPortrait.value
                ? () {
                    _controller.navToInforScreen();
                  }
                : null,
            child: Center(
              child: Text(
                'Tiếp tục'.tr,
                style: AppTextStyles.bold16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
