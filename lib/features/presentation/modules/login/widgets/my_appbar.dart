import 'package:flutter/material.dart';
import '../../../../../config/theme/app_color.dart';
class MyAppbar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppbar({required this.title, super.key});

  final String title;
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      title: Text(title),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0.0),
        child: Container(
          color: AppColor.black,
          height: 1.0,
        ),
      ),
      // leading: IconButton(
      //   icon: const Icon(Icons.close),
      //   color: AppColor.black,
      //   onPressed: () {

      //   },
      // ),
      // actions: [
      //   TextButton(
      //     onPressed: () {
      //       // deletefilter
      //       searchController.deleteFilter();
      //     },
      //     child: Text(
      //       "Đặt lại",
      //       style: AppTextStyles.roboto16semiBold
      //           .copyWith(color: AppColors.primaryColor),
      //     ),
      //   ),
      // ],
    );
  }
}
