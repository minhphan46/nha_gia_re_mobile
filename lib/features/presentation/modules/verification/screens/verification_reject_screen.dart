import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../../../config/values/asset_image.dart';
import '../verification_controller.dart';

class VerificationRejectScreen extends StatelessWidget {
  VerificationRejectScreen({super.key});
  final VerificationController _controller = Get.find<VerificationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text("Yêu cầu bị từ chối"),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
        padding: const EdgeInsets.symmetric(
          vertical: 40,
          horizontal: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Lottie.asset(
                Assets.cardReject,
              ),
            ),
            Text(
              "Tài khoản của bạn không được xác minh vì lý do ${Get.arguments}",
              textAlign: TextAlign.center,
              style: AppTextStyles.bold18,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 50,
        margin: const EdgeInsets.all(10),
        child: ElevatedButton(
          onPressed: _controller.navToVerification,
          child: Center(
            child: Text(
              "Định danh lại tài khoản",
              style: AppTextStyles.bold16,
            ),
          ),
        ),
      ),
    );
  }
}
