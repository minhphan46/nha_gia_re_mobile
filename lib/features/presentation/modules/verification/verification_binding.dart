import 'package:get/get.dart';
import 'package:nhagiare_mobile/features/presentation/modules/verification/verification_controller.dart';

class VerificationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerificationController>(() => VerificationController());
  }
}
