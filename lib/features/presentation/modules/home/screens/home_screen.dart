import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/config/values/asset_image.dart';
import 'package:nhagiare_mobile/features/presentation/modules/home/widgets/button_home.dart';
import 'package:nhagiare_mobile/features/presentation/modules/home/widgets/home_appbar.dart';
import 'package:nhagiare_mobile/features/presentation/modules/home/widgets/nearby_location.dart';
import '../../../global_widgets/info_card_list.dart';
import '../home_controller.dart';
import '../../../global_widgets/carousel_ad.dart';
import '../widgets/textfield_search.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              // Appbar
              HomeAppbar(),
              // search
              const SizedBox(height: 10),
              TextFiedSearch(),
              // CarouselAd
              const SizedBox(height: 10),
              CarouselAd(
                imgList: controller.imgList,
                aspectRatio: 2.59,
                indicatorSize: 6,
              ),
              // List Buttons
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Btn Mua ban
                  ButtonHome(
                    title: "Mua bán",
                    icon: Assets.switchHorizon,
                    type: true,
                    onTap: controller.navToSell,
                  ),
                  ButtonHome(
                    title: "Cho thuê",
                    icon: Assets.homeGreen,
                    type: false,
                    onTap: controller.navToRent,
                  ),
                  ButtonHome(
                    title: "Đăng tin",
                    icon: Assets.pencil,
                    type: true,
                    onTap: controller.navigateToCreatePostScreen,
                  ),
                ],
              ),
              // tinh thanh
              const SizedBox(height: 15),
              NearbyLocation(),

              // gan ban
              const SizedBox(height: 15),
              InforCardList(
                title: 'Gần bạn',
                getListFunc: () => controller.getPostsNearBy(),
                //list: data[1],
              ),
              const SizedBox(height: 15),

              // gmua ban
              const SizedBox(height: 15),
              InforCardList(
                title: 'Mua bán',
                getListFunc: () => controller.getPostsSell(),
                //list: data[1],
              ),
              const SizedBox(height: 15),

              // cho thuê
              const SizedBox(height: 15),
              InforCardList(
                title: 'Cho thuê',
                getListFunc: () => controller.getPostsRent(),
                //list: data[1],
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
