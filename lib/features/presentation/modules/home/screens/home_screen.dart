import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/features/presentation/modules/home/widgets/home_appbar.dart';
import '../home_controller.dart';
import '../widgets/carousel_ad.dart';
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
            ],
          ),
        ),
      ),
    );
  }
}
