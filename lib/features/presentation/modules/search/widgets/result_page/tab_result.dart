import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/features/domain/enums/navigate_type.dart';
import 'package:nhagiare_mobile/features/presentation/modules/search/search_controller.dart';
import 'package:nhagiare_mobile/features/presentation/modules/search/widgets/result_page/finded_post_list.dart';

import '../../../../../../config/theme/app_color.dart';

class TabResult extends StatelessWidget {
  TabResult({super.key});

  final MySearchController searchController = Get.find<MySearchController>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DefaultTabController(
        length: 2,
        initialIndex:
            searchController.typeNavigate == TypeNavigate.rent ? 1 : 0,
        child: const Column(
          children: [
            TabBar(
              indicatorColor: AppColors.green,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: [
                Tab(
                  text: "Cần bán",
                ),
                Tab(
                  text: "Cho thuê",
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  FindedPostList(isLease: true),
                  FindedPostList(isLease: false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
