import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../../../config/values/asset_image.dart';

class VerificationWaitingScreen extends StatelessWidget {
  const VerificationWaitingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text("Đang chờ xác minh"),
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
                Assets.waiting,
              ),
            ),
            Text(
              "Tài khoản của bạn đang chờ được xác minh, vui lòng quay lại sau.",
              textAlign: TextAlign.center,
              style: AppTextStyles.bold18,
            ),
          ],
        ),
      ),
    );
  }
}
