import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:get/get.dart';
import '../../../../../../config/theme/app_color.dart';
import '../../../../../../config/theme/text_styles.dart';
import '../../../../../../config/values/app_values.dart';

// ignore: must_be_immutable
class RangeSliderCustom extends StatelessWidget {
  final String title;
  final String unit;
  final double lower;
  final double upper;
  final RxDouble lowerValue;
  final RxDouble upperValue;
  final double stepValue;
  final Function onChangeValue;

  RangeSliderCustom({
    required this.title,
    required this.unit,
    required this.lower,
    required this.upper,
    required this.lowerValue,
    required this.upperValue,
    required this.stepValue,
    required this.onChangeValue,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Obx(
            () => RichText(
              text: TextSpan(children: [
                TextSpan(text: title, style: nomalText),
                TextSpan(
                    text:
                        '${FormatNum.formatter.format(lowerValue.value.toInt())}$unit',
                    style: highlightText),
                TextSpan(text: ' đến ', style: nomalText),
                TextSpan(
                    text:
                        '${FormatNum.formatter.format(upperValue.value.toInt())}$unit',
                    style: highlightText),
              ]),
            ),
          ),
        ),
        Obx(
          () => FlutterSlider(
            values: [lowerValue.value, upperValue.value],
            rangeSlider: true,
            max: upper,
            min: lower,
            step: FlutterSliderStep(step: stepValue),
            jump: true,
            trackBar: FlutterSliderTrackBar(
              activeTrackBarHeight: 5,
              activeTrackBar: const BoxDecoration(color: AppColors.green),
              inactiveTrackBarHeight: 5,
              inactiveTrackBar: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.white,
                border: Border.all(width: 0.5, color: AppColors.grey500),
              ),
            ),
            tooltip: FlutterSliderTooltip(
              disabled: true,
            ),
            handler: handlerStyle,
            rightHandler: handlerStyle,
            disabled: false,
            onDragging: (handlerIndex, lower, upper) {
              onChangeValue(lower, upper);
            },
          ),
        ),
      ],
    );
  }

  TextStyle nomalText = AppTextStyles.regular14.copyWith(
    color: AppColors.black,
  );

  TextStyle highlightText = AppTextStyles.semiBold14.copyWith(
    color: AppColors.green,
  );

  FlutterSliderHandler handlerStyle = FlutterSliderHandler(
    decoration: const BoxDecoration(),
    child: Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(width: 1, color: AppColors.grey500),
        borderRadius: BorderRadius.circular(25),
      ),
    ),
  );
}
