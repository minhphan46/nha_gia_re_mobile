import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/features/presentation/global_widgets/my_appbar.dart';
import 'package:nhagiare_mobile/features/presentation/modules/setting/setting_controller.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});
  final SettingController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(title: "Cài đặt"),
      body: const Center(
        child: Text('Setting Screen'),
      ),
    );
  }
}
