import 'package:flutter/material.dart';
import 'package:nhagiare_mobile/core/extensions/textstyle_ex.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';

class ButtonFollow extends StatelessWidget {
  const ButtonFollow({required this.isFollow, required this.isMe, super.key});

  final bool isFollow;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isFollow ? AppColors.grey300 : AppColors.green,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isFollow
                    ? Icons.remove_circle_outline_rounded
                    : Icons.add_circle_outline_rounded,
                color: isFollow ? AppColors.black : AppColors.white,
                size: 20,
              ),
              const SizedBox(width: 4),
              Text(
                isFollow ? 'Bỏ theo dõi' : 'Theo dõi',
                style: AppTextStyles.medium14
                    .colorEx(isFollow ? AppColors.black : AppColors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}