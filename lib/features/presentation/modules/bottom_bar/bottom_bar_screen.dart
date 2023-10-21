import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/features/presentation/modules/account/screens/account_screen.dart';
import 'package:nhagiare_mobile/features/presentation/modules/bottom_bar/bottom_bar_controller.dart';
import 'package:nhagiare_mobile/features/presentation/modules/notification/screens/notification_screen.dart';
import '../../../../config/theme/app_color.dart';
import '../../../../config/values/asset_image.dart';
import '../home/screens/home_screen.dart';
import '../post_management/screens/post_management_screen.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen>
    with SingleTickerProviderStateMixin {
  List<Widget> _pages = [];
  List<TabItem<dynamic>> _tab = [];
  final controller = Get.put(BottomBarController());

  @override
  void initState() {
    super.initState();

    _pages = [
      HomeScreen(),
      const PostManagementScreen(),
      const Scaffold(),
      const NotificationScreen(),
      const AccountScreen(),
    ];

    _tab = [
      TabItem(
        icon: Image.asset(Assets.home, color: AppColor.grey700),
        activeIcon: Image.asset(Assets.home, color: AppColor.green),
        title: "Trang chủ".tr,
      ),
      TabItem(
        icon: Image.asset(Assets.document),
        activeIcon: Image.asset(Assets.document, color: AppColor.green),
        title: 'Quản lý tin'.tr,
      ),
      TabItem(
        icon: CircleAvatar(
          backgroundColor: AppColor.green,
          child: Image.asset(
            Assets.pencil,
            width: 40,
          ),
        ),
      ),
      TabItem(
        icon: Image.asset(Assets.notification),
        activeIcon: Image.asset(Assets.notification, color: AppColor.green),
        title: 'Thông báo'.tr,
      ),
      TabItem(
        icon: Image.asset(Assets.user),
        activeIcon: Image.asset(Assets.user, color: AppColor.green),
        title: 'Tài khoản'.tr,
      ),
    ];
    controller.tabController = TabController(length: _tab.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomBarController>(
      builder: (_) {
        return Scaffold(
          body: TabBarView(
            controller: controller.tabController,
            children: _pages,
          ),
          bottomNavigationBar: ConvexAppBar(
            onTap: controller.changeTabIndex,
            backgroundColor: AppColor.white,
            color: AppColor.black,
            activeColor: AppColor.green,
            style: TabStyle.fixedCircle,
            curveSize: 75,
            top: -22,
            height: 55,
            items: _tab,
          ),
        );
      },
    );
  }
}
