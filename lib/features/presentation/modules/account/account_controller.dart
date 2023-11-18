import 'package:get/get.dart';
import 'package:nhagiare_mobile/config/routes/app_routes.dart';
import 'package:nhagiare_mobile/core/resources/data_state.dart';
import 'package:nhagiare_mobile/features/domain/usecases/authentication/sign_out.dart';
import 'package:nhagiare_mobile/injection_container.dart';

class AccountController extends GetxController {
  bool isIdentity = true;
  RxBool isLoadingLogout = false.obs;
  int servicePack = 1;

  void changeServicePack(int value) {
    servicePack = value;
    update();
  }

  void navToPurchase() {
    Get.toNamed(AppRoutes.purchase);
  }

  Future<void> handleSignOut() async {
    isLoadingLogout.value = true;
    SignOutUseCase signOutUseCase = sl<SignOutUseCase>();
    final dataState = await signOutUseCase();
    isLoadingLogout.value = false;
    if (dataState is DataSuccess) {
      Get.offAllNamed(AppRoutes.login);
    } else {
      Get.snackbar("Lỗi", "Đăng xuất thất bại");
    }
  }
}
