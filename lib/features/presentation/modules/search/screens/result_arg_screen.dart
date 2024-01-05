import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/features/presentation/global_widgets/my_appbar.dart';

import '../search_controller.dart';
import 'result_page.dart';

class ResultArgScreen extends StatefulWidget {
  const ResultArgScreen({super.key});

  @override
  State<ResultArgScreen> createState() => _ResultArgScreenState();
}

class _ResultArgScreenState extends State<ResultArgScreen> {
  final MySearchController searchController = Get.find<MySearchController>();

  final String title = Get.arguments['title'];

  @override
  void initState() {
    searchController.setTypeResult(Get.arguments['type']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(title: title, isShowBack: true),
      body: ResultPage(),
    );
  }
}
