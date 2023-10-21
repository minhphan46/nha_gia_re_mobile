import 'package:get/get.dart';
import 'bottom_bar_controller.dart';

class BottomBarBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomBarController>(() => BottomBarController());
  }
}
