import 'package:flutter/material.dart';
import 'package:easy_stepper/easy_stepper.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';

class StepperIdentify extends StatelessWidget {
  final int value;
  const StepperIdentify(this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return EasyStepper(
      activeStep: value,
      lineLength: 100,
      lineSpace: 5,
      lineType: LineType.dotted,
      defaultLineColor: AppColors.grey600,
      finishedLineColor: AppColors.green,
      activeStepTextColor: Colors.black87,
      finishedStepTextColor: Colors.black87,
      internalPadding: 2,
      stepRadius: 9,
      showLoadingAnimation: false,
      showStepBorder: false,
      steps: [
        EasyStep(
          customStep: CircleAvatar(
            radius: 9,
            backgroundColor: value >= 0 ? AppColors.green : Colors.black87,
            child: CircleAvatar(
              radius: 8,
              backgroundColor: value >= 0 ? AppColors.green : Colors.white,
              child: const Icon(
                Icons.done,
                size: 15,
                color: Colors.white,
              ),
            ),
          ),
          customTitle: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              'Giấy tờ tùy thân',
              textAlign: TextAlign.center,
              style: AppTextStyles.regular12.copyWith(
                color: value >= 0 ? AppColors.green : Colors.black87,
              ),
            ),
          ),
        ),
        EasyStep(
          customStep: CircleAvatar(
            radius: 9,
            backgroundColor: value >= 1 ? AppColors.green : Colors.black87,
            child: CircleAvatar(
              radius: 8,
              backgroundColor: value >= 1 ? AppColors.green : Colors.white,
              child: const Icon(
                Icons.done,
                size: 15,
                color: Colors.white,
              ),
            ),
          ),
          customTitle: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              'Ảnh chân dung',
              textAlign: TextAlign.center,
              style: AppTextStyles.regular12.copyWith(
                color: value >= 1 ? AppColors.green : Colors.black87,
              ),
            ),
          ),
        ),
        EasyStep(
          customStep: CircleAvatar(
            radius: 9,
            backgroundColor: value >= 2 ? AppColors.green : Colors.black87,
            child: CircleAvatar(
              radius: 8,
              backgroundColor: value >= 2 ? AppColors.green : Colors.white,
              child: const Icon(
                Icons.done,
                size: 15,
                color: Colors.white,
              ),
            ),
          ),
          customTitle: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              'Thông tin cá nhân',
              textAlign: TextAlign.center,
              style: AppTextStyles.regular12.copyWith(
                color: value >= 2 ? AppColors.green : Colors.black87,
              ),
            ),
          ),
        ),
      ],
      onStepReached: (index) => {},
    );
  }
}
