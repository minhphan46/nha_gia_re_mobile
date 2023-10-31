import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/features/presentation/global_widgets/my_appbar.dart';
import 'package:nhagiare_mobile/features/presentation/modules/post_detail/post_detail_controller.dart';

import '../../../../../config/theme/text_styles.dart';
import '../../../global_widgets/carousel_ad.dart';

class PostDetailScreen extends StatelessWidget {
  PostDetailScreen({super.key});

  final PostDetailController controller = Get.find<PostDetailController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(title: controller.post.title ?? ""),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            // images
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CarouselAd(
                imgList: controller.post.images ?? [],
                aspectRatio: 1.72,
                indicatorSize: 8,
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // title
                  Text(
                    controller.post.title!,
                    style: AppTextStyles.semiBold18,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
