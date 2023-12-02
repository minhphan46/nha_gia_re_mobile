import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/features/domain/entities/posts/real_estate_post.dart';

import '../../../../../../config/theme/app_color.dart';
import '../../../../../../config/theme/text_styles.dart';
import '../../search_controller.dart';
import 'item_product.dart';

class FindedPostList extends StatefulWidget {
  final bool isLease;
  const FindedPostList({required this.isLease, super.key});

  @override
  State<FindedPostList> createState() => _FindedPostListState();
}

class _FindedPostListState extends State<FindedPostList> {
  final MySearchController searchController = Get.find<MySearchController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: searchController.initPosts(widget.isLease),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (snapshot.error != null) {
            return const Center(
              child: Text('An error occured'),
            );
          } else {
            return Container(
              color: AppColors.white,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Obx(
                () => searchController.searchPosts.isEmpty
                    ? Center(
                        child: Text(
                          "Không tìm thấy bài đăng nào",
                          style: AppTextStyles.bold20
                              .copyWith(color: AppColors.green),
                        ),
                      )
                    : ListView.builder(
                        itemCount: searchController.searchPosts.length,
                        itemBuilder: (_, i) {
                          RealEstatePostEntity prod =
                              searchController.searchPosts[i];
                          return ItemProduct(
                            post: prod,
                            isFavourited: prod.isFavorite ?? false,
                            onTap: searchController.navigateToDetailSceen,
                          );
                        },
                      ),
              ),
            );
          }
        }
      },
    );
  }
}
