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

  TextEditingController lowerValueController = TextEditingController();
  TextEditingController upperValueController = TextEditingController();

  FocusNode lowerValueFocusNode = FocusNode();
  FocusNode upperValueFocusNode = FocusNode();

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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 150,
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: lowerValueController,
                focusNode: lowerValueFocusNode,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: lower.toInt().toString(),
                  hintStyle: highlightText,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 10.0),
                  filled: true,
                  fillColor: AppColors.grey100,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                style: highlightText,
                onTapOutside: (event) {
                  lowerValueFocusNode.unfocus();
                },
                onChanged: (value) {
                  if (isValidValue(value)) {
                    lowerValue.value = double.parse(value);
                  }
                },
                onFieldSubmitted: (value) {
                  if (isValidValue(value)) {
                    lowerValue.value = double.parse(value);
                  }
                  lowerValueFocusNode.unfocus();
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Không rỗng';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Không hợp lệ';
                  }
                  if (double.parse(value) < lower) {
                    return 'Không nhỏ hơn $lower';
                  }
                  if (double.parse(value) > upper) {
                    return 'Không lớn hơn $upper';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                '-',
                style: highlightText.copyWith(fontSize: 20),
              ),
            ),
            SizedBox(
              width: 150,
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: upperValueController,
                focusNode: upperValueFocusNode,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: upper.toInt().toString(),
                  hintStyle: highlightText,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 10.0),
                  filled: true,
                  fillColor: AppColors.grey100,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                style: highlightText,
                onTapOutside: (event) {
                  upperValueFocusNode.unfocus();
                },
                onChanged: (value) {
                  if (isValidValue(value)) {
                    upperValue.value = double.parse(value);
                  }
                },
                onFieldSubmitted: (value) {
                  if (isValidValue(value)) {
                    upperValue.value = double.parse(value);
                  }
                  upperValueFocusNode.unfocus();
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Không rỗng';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Không hợp lệ';
                  }
                  if (double.parse(value) < lower) {
                    return 'Không nhỏ hơn $lower';
                  }
                  if (double.parse(value) > upper) {
                    return 'Không lớn hơn $upper';
                  }
                  return null;
                },
              ),
            ),
          ],
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
              lowerValueController.text = lowerValue.value.toInt().toString();
              upperValueController.text = upperValue.value.toInt().toString();
            },
          ),
        ),
      ],
    );
  }

  bool isValidValue(String value) {
    if (value.isEmpty) {
      return false;
    }
    if (double.tryParse(value) == null) {
      return false;
    }
    if (double.parse(value) < lower) {
      return false;
    }
    if (double.parse(value) > upper) {
      return false;
    }
    return true;
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
