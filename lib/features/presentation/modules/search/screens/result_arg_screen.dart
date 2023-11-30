import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/features/presentation/global_widgets/my_appbar.dart';

import '../search_controller.dart';
import 'result_page.dart';

class ResultArgScreen extends StatelessWidget {
  ResultArgScreen({super.key});

  final MySearchController searchController = Get.find<MySearchController>();
  final String title = Get.arguments['title'];

  @override
  Widget build(BuildContext context) {
    searchController.setTypeResult(Get.arguments['type']);
    return Scaffold(
      appBar: MyAppbar(title: title, isShowBack: true),
      body: ResultPage(),
    );
  }
}
