import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/theme/app_color.dart';

class MyAppbar extends AppBar {
  MyAppbar({
    super.key,
    required String title,
    bool? isShowBack = true,
    List<Widget>? actions,
    Widget? leading,
    PreferredSizeWidget? bottom,
  }) : super(
          centerTitle: true,
          elevation: 0,
          title: Text(title),
          bottom: bottom ??
              PreferredSize(
                preferredSize: const Size.fromHeight(0.0),
                child: Container(
                  color: AppColors.black,
                  height: 1.0,
                ),
              ),
          leading: leading ??
              ((isShowBack == true)
                  ? Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          size: 20,
                        ),
                        color: AppColors.black,
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    )
                  : const SizedBox()),
          actions: actions,
        );
}
