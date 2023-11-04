import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/config/routes/app_routes.dart';
import 'package:nhagiare_mobile/config/values/asset_image.dart';
import 'package:nhagiare_mobile/core/extensions/double_ex.dart';
import 'package:nhagiare_mobile/core/extensions/integer_ex.dart';
import 'package:nhagiare_mobile/features/presentation/modules/home/widgets/icon_text.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../../../core/extensions/date_ex.dart';
import '../../domain/entities/posts/real_estate_post.dart';

class InforCard extends StatelessWidget {
  const InforCard({super.key, required this.post});

  final RealEstatePostEntity post;

  @override
  Widget build(BuildContext context) {
    double widthBox = 43.wp;

    return ZoomTapAnimation(
      child: InkWell(
        onTap: () {
          Get.toNamed(
            AppRoutes.getPostRoute(post.id!),
            arguments: post,
          );
        },
        splashColor: AppColors.green,
        child: Container(
          width: widthBox,
          height: 10.hp,
          decoration: BoxDecoration(
            color: AppColors.grey100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                child: CachedNetworkImage(
                  imageUrl: post.images!.first,
                  fit: BoxFit.fill,
                  height: 110,
                  width: widthBox,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.title!,
                      style: AppTextStyles.bold12,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    IconText(
                      icon: Assets.money,
                      text: double.parse(post.price!).toFormattedMoney(),
                      color: AppColors.orange,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    IconText(
                      icon: Assets.home,
                      text: post.address!.getDetailAddress(),
                      color: AppColors.grey500,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    IconText(
                      icon: Assets.clock,
                      text: post.postedDate!.getTimeAgo(),
                      color: AppColors.grey500,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
