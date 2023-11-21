import 'package:flutter/material.dart';
import 'package:nhagiare_mobile/core/extensions/textstyle_ex.dart';

import '../../../config/theme/app_color.dart';
import '../../../config/theme/text_styles.dart';

class BaseDropdownButton extends StatelessWidget {
  const BaseDropdownButton({
    this.title,
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.onSaved,
    super.key,
  });

  final Object? value;
  final List<DropdownMenuItem<Object>>? items;
  final String? title;
  final String hint;
  final Function(Object?)? onChanged;
  final Function(Object?)? onSaved;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          borderSide: BorderSide(color: AppColors.green),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        filled: true,
        fillColor: AppColors.white,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: title,
      ),
      style: AppTextStyles.regular14.colorEx(Colors.black),
      dropdownColor: AppColors.white,
      value: value,
      hint: Text(hint),
      items: items,
      onChanged: onChanged,
      onSaved: onSaved,
    );
  }
}
