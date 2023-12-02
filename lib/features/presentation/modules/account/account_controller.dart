import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/config/routes/app_routes.dart';
import 'package:nhagiare_mobile/core/resources/data_state.dart';
import 'package:nhagiare_mobile/features/domain/entities/posts/address.dart';
import 'package:nhagiare_mobile/features/domain/entities/user/user.dart';
import 'package:nhagiare_mobile/features/domain/usecases/authentication/sign_out.dart';
import 'package:nhagiare_mobile/injection_container.dart';

import '../../../../config/theme/app_color.dart';

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
    try {
      isLoadingLogout.value = true;
      SignOutUseCase signOutUseCase = sl<SignOutUseCase>();
      final dataState = await signOutUseCase();
      isLoadingLogout.value = false;
      if (dataState is DataSuccess) {
        Get.offAllNamed(AppRoutes.login);
        Get.snackbar(
          'Thành công',
          'Đăng xuất thành công',
          backgroundColor: AppColors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Đăng xuất thất bại',
          (dataState as DataFailed).error.toString(),
          backgroundColor: AppColors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Đăng xuất thất bại',
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      isLoadingLogout.value = false;
    }
  }

  void navToAccountInfo() {
    Get.toNamed(AppRoutes.userProfile,
        arguments: UserEntity(
          id: "1a9a5785-721a-4bb5-beb7-9d752e2070d4",
          firstName: "Trung",
          lastName: "Thành",
          email: "trungthanh@gmail.com",
          phone: "0987654321",
          avatar: "https://picsum.photos/200/300?random=1",
          address: AddressEntity(
              provinceCode: 1,
              wardCode: 1,
              districtCode: 1,
              detail: "Hàng Mai"),
          dob: "1999-01-01",
          createdAt: DateTime.now(),
        ));
  }
}
