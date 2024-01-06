import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:nhagiare_mobile/config/routes/app_routes.dart';
import 'package:nhagiare_mobile/core/resources/data_state.dart';
import 'package:nhagiare_mobile/features/domain/entities/user/user.dart';
import 'package:nhagiare_mobile/features/domain/usecases/authentication/get_me.dart';
import 'package:nhagiare_mobile/features/domain/usecases/authentication/sign_out.dart';
import 'package:nhagiare_mobile/features/domain/usecases/post/remote/get_post_fav.dart';
import 'package:nhagiare_mobile/features/domain/usecases/purchase/get_current_subscription.dart';
import 'package:nhagiare_mobile/injection_container.dart';

import '../../../../config/theme/app_color.dart';
import '../../../../core/resources/pair.dart';
import '../../../../core/service/device_service.dart';
import '../../../../core/utils/date_picker.dart';
import '../../../domain/entities/posts/real_estate_post.dart';
import '../../../domain/entities/purchase/subscription.dart';
import '../../../domain/usecases/post/remote/get_posts.dart';

class AccountController extends GetxController {
  bool isIdentity = true;
  RxBool isLoadingLogout = false.obs;
  RxInt servicePack = 0.obs;

  void initServicePack() async {
    final currentSubscription = await getCurrentSubscription();
    if (currentSubscription == null) {
      servicePack.value = 0;
    } else if (currentSubscription.package!.name == "Gói cơ bản") {
      servicePack.value = 1;
    } else if (currentSubscription.package!.name == "Gói doanh nghiệp") {
      servicePack.value = 2;
    } else if (currentSubscription.package!.name == "Gói chuyên nghiệp") {
      servicePack.value = 3;
    }
  }

  final GetCurrentSubscriptionUseCase getCurrentSubscriptionUseCase =
      sl<GetCurrentSubscriptionUseCase>();

  Future<Subscription?> getCurrentSubscription() async {
    final result = await getCurrentSubscriptionUseCase.call();
    return result;
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

  final GetPostsUseCase _getPostsUseCase = sl<GetPostsUseCase>();
  Future<List<RealEstatePostEntity>> getAllPosts({int? page = 1}) async {
    final dataState = await _getPostsUseCase(
      params: Pair(userEntity.id, page),
    );

    if (dataState is DataSuccess && dataState.data!.second.isNotEmpty) {
      return dataState.data!.second;
    } else if (dataState is DataFailed) {
      return [];
    } else {
      return [];
    }
  }

  // update info

  RxBool isLoading = false.obs;
  final updateInfoFormKey = GlobalKey<FormState>();

  var fnamUpdateInfoTextController = TextEditingController();
  var lnameUpdateInfoTextController = TextEditingController();
  var phoneUpdateInfoTextController = TextEditingController();
  var emailUpdateInfoTextController = TextEditingController();
  var birthUpdateInfoTextController = TextEditingController();
  var genderUpdateInfoTextController = TextEditingController();
  var addressUpdateInfoTextController = TextEditingController();

  File? imageAvatar; // file image of user

  void cancelImages() {
    imageAvatar = null;
  }

  /// get image from camera
  Future<void> getImageFromCamera() async {
    final image = await DeviceService.pickImage(ImageSource.camera);
    if (image == null) return;
    imageAvatar = image;
    Get.back();
  }

  /// get image from gallery
  Future<void> getImageFromGallery() async {
    final image = await DeviceService.pickImage(ImageSource.gallery);
    if (image == null) return;
    imageAvatar = image;
    Get.back();
  }

  /// get day from date picker
  Future<void> handleDatePicker() async {
    DateTime? date = await DatePickerHelper.getDatePicker();
    if (date != null) {
      birthUpdateInfoTextController.text =
          DateFormat('dd/MM/yyyy').format(date);
    }
  }

  /// data gender
  RxString gender = "Nam".obs;

  void changeGender(String? newValue) {
    gender.value = newValue!;
  }

  void updateInfo() async {
    if (updateInfoFormKey.currentState!.validate()) {
      isLoading.value = true;
    }
  }

  navToUpdateInfo() {
    Get.toNamed(AppRoutes.updateInfoAccount, arguments: userEntity);
  }

  final getPostFavoriteUseCase = sl<GetPostFavorite>();
  Future<Pair<int, List<RealEstatePostEntity>>> getPostFavorite(
      int page) async {
    final dataState = await getPostFavoriteUseCase(
      params: page,
    );
    return dataState;
  }
}
