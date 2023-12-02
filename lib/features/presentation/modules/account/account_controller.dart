import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/config/routes/app_routes.dart';
import 'package:nhagiare_mobile/core/resources/data_state.dart';
import 'package:nhagiare_mobile/features/domain/entities/posts/address.dart';
import 'package:nhagiare_mobile/features/domain/entities/user/user.dart';
import 'package:nhagiare_mobile/features/domain/usecases/authentication/get_me.dart';
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

  GetMeUseCase getMeUseCase = sl<GetMeUseCase>();
  late UserEntity userEntity;

  Future<UserEntity?> getUserInfo() async {
    try {
      userEntity = await getMeUseCase.call();
      return userEntity;
    } catch (e) {
      Get.snackbar(
        'Lỗi',
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
    return null;
  }

  void navToAccountInfo() {
    Get.toNamed(AppRoutes.userProfile, arguments: userEntity);
  }
}
