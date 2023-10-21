import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController _controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Home Screen'),
      ),
    );
  }
}
