import 'package:flutter/material.dart';
import 'package:nhagiare_mobile/config/theme/app_color.dart';
import 'package:nhagiare_mobile/config/theme/text_styles.dart';
import 'package:nhagiare_mobile/core/extensions/textstyle_ex.dart';

ThemeData appTheme() {
  return ThemeData(
    scaffoldBackgroundColor: AppColor.white,
    //fontFamily: 'Muli',
    appBarTheme: appBarTheme(),
    colorScheme: ColorScheme.fromSeed(seedColor: AppColor.green),
    useMaterial3: true,
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    iconTheme: const IconThemeData(color: AppColor.black),
    titleTextStyle: AppTextStyles.semiBold18.colorEx(AppColor.green),
  );
}
