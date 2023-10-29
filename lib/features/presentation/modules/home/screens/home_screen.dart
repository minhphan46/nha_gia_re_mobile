import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/config/values/asset_image.dart';
import 'package:nhagiare_mobile/features/presentation/modules/home/widgets/button_home.dart';
import 'package:nhagiare_mobile/features/presentation/modules/home/widgets/home_appbar.dart';
import 'package:nhagiare_mobile/features/presentation/modules/home/widgets/nearby_location.dart';
import '../home_controller.dart';
import '../widgets/carousel_ad.dart';
import '../widgets/textfield_search.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController controller = Get.find<HomeController>();

  @override
  void initState() {
    print("asdlhadlahsdloasdhalskdjhasd");
    controller.onGetAllPosts();
    super.initState();
  }

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
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Btn Mua ban
                  ButtonHome(
                    title: "Mua bán",
                    icon: Assets.switchHorizon,
                    type: true,
                  ),
                  ButtonHome(
                    title: "Cho thuê",
                    icon: Assets.homeGreen,
                    type: false,
                  ),
                  ButtonHome(
                    title: "Đăng tin",
                    icon: Assets.pencil,
                    type: true,
                  ),
                ],
              ),
              // gan ban
              const SizedBox(height: 10),
              NearbyLocation(),
            ],
          ),
        ),
      ),
    );
  }
}
