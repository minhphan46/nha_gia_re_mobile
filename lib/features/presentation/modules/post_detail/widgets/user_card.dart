import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/core/extensions/textstyle_ex.dart';

import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../../../config/values/asset_image.dart';
import '../post_detail_controller.dart';

class UserCard extends StatelessWidget {
  UserCard({super.key});

  final PostDetailController controller = Get.find<PostDetailController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: AppColor.grey100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // avatar
              const CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage(Assets.avatar2),
              ),
              const SizedBox(width: 10),
              // Name
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    //controller.post.title!,
                    "Phan Văn Minh",
                    style: AppTextStyles.semiBold14.colorEx(
                      AppColor.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    //controller.post.title!,
                    "Cá nhân",
                    style: AppTextStyles.regular14.colorEx(
                      AppColor.lightBlack,
                    ),
                  ),
                ],
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              //
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              textStyle: const TextStyle(color: AppColor.white),
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(
                    color: AppColor.green,
                    width: 1,
                  )),
            ),
            child: Text(
              "Xem hồ sơ",
              style: AppTextStyles.medium14.colorEx(
                AppColor.green,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
