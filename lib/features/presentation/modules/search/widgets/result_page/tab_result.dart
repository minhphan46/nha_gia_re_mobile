import 'package:flutter/material.dart';
import 'package:nhagiare_mobile/features/presentation/modules/search/widgets/result_page/finded_post_list.dart';

import '../../../../../../config/theme/app_color.dart';

class TabResult extends StatelessWidget {
  const TabResult({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: DefaultTabController(
        length: 2,
        child: Column(
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
