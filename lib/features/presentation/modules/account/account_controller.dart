import 'package:get/get.dart';
import 'package:nhagiare_mobile/config/routes/app_routes.dart';

class AccountController extends GetxController {
  bool isIdentity = true;

  int servicePack = 1;

  void changeServicePack(int value) {
    servicePack = value;
    update();
  }

  void navToPurchase() {
    Get.toNamed(AppRoutes.purchase);
  }
}
