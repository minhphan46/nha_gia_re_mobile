import 'package:flutter/material.dart';
import 'package:nhagiare_mobile/config/values/asset_image.dart';
import 'package:nhagiare_mobile/features/domain/entities/posts/real_estate_post.dart';
import 'package:nhagiare_mobile/features/presentation/modules/user_profile/widgets/user_posts.dart';

import '../../../../../config/theme/app_color.dart';
import '../user_profile_controller.dart';

class TabProfile extends StatefulWidget {
  final List<RealEstatePostEntity>? data;
  const TabProfile({super.key, required this.data});
  @override
  State<TabProfile> createState() => _TabProfileState();
}

class _TabProfileState extends State<TabProfile> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              controller: _tabController,
              indicatorColor: AppColors.green,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: [
                Tab(
                  icon: Image.asset(
                    Assets.grid,
                    width: 20,
                    height: 20,
                    color: _tabController.index == 0 ? AppColors.green : null,
                  ),
                ),
                Tab(
                  icon: Image.asset(
                    Assets.chat,
                    width: 20,
                    height: 20,
                    color: _tabController.index == 1 ? AppColors.green : null,
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: [
                  widget.data == null
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : widget.data!.isEmpty
                          ? const Center(
                              child: Text('Chưa có bài viết'),
                            )
                          : UserPosts(data: widget.data!), // posts
                  const Scaffold(
                    body: Center(
                      child: Text('Chưa có tin nhắn'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
