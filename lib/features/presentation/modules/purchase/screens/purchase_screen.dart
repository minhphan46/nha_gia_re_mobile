import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/features/presentation/global_widgets/my_appbar.dart';
import 'package:nhagiare_mobile/features/presentation/modules/purchase/purchase_controller.dart';

class PurchaseScreen extends StatelessWidget {
  PurchaseScreen({super.key});
  final PurchaseController controller = Get.find<PurchaseController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(title: "Gói dịch vụ"),
      body: const Center(
        child: Text('Purchase Screen'),
      ),
    );
  }
}
