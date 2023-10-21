import 'package:flutter/material.dart';
import 'package:nhagiare_mobile/config/theme/app_color.dart';

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
  return const AppBarTheme(
    color: Colors.white,
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: Color(0XFF8B8B8B)),
    titleTextStyle: TextStyle(color: Color(0XFF8B8B8B), fontSize: 18),
  );
}
