import 'dart:io';
import 'package:nhagiare_mobile/features/domain/usecases/authentication/sign_in.dart';
import 'package:nhagiare_mobile/injection_container.dart';

import '../../../../../config/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:nhagiare_mobile/core/utils/date_picker.dart';

import '../../../../core/resources/data_state.dart';
import '../../../../core/service/device_service.dart';

class LoginController extends GetxController {
  var loginEmail = TextEditingController(text: "nhao@qa.team");
  var loginPassword = TextEditingController(text: "12345678");
  var forgotPassEmail = TextEditingController();
  var registerEmail = TextEditingController();
  var registerPassword = TextEditingController();
  var newPassword = TextEditingController();

  // final CountdownController countdownController =
  //     CountdownController(autoStart: true);

  final registerFormGlobalKey = GlobalKey<FormState>();
  final loginFormGlobalKey = GlobalKey<FormState>();
  final forgotPassFormGlobalKey = GlobalKey<FormState>();
  final changePassFormKey = GlobalKey<FormState>();
  final updateInfoFormKey = GlobalKey<FormState>();

  RxString loginError = RxString('');
  RxString registerError = RxString('');
  RxBool isLoading = false.obs;
  RxBool isCountDown = true.obs;
  RxBool isObscureNewPass = true.obs;
  RxBool isObscureLogin = true.obs;
  RxBool isObscureRegister = true.obs;
  RxBool isObscureRepeatPass = true.obs;
  RxBool isObscureResetPass = true.obs;
  RxBool isObscureRepeatPassReset = true.obs;
  RxBool validatorVisibility = false.obs;
  RxBool validatorSusscess = false.obs;
  RxBool validatorChangePassVisibility = true.obs;

  void handleChangePass() async {}

  void toggleNewPass() {
    isObscureNewPass.value = !isObscureNewPass.value;
  }

  void toggleRepeatPass() {
    isObscureRepeatPassReset.value = !isObscureRepeatPassReset.value;
  }

  void togglePassword() {
    isObscureLogin.value = !isObscureLogin.value;
  }

  void togglePassReg() {
    isObscureRegister.value = !isObscureRegister.value;
  }

  void toggleResetPass() {
    isObscureResetPass.value = !isObscureResetPass.value;
  }

  void toggleRepeatPassReg() {
    isObscureRepeatPass.value = !isObscureRepeatPass.value;
  }

  final SignInUseCase signInUseCase = sl<SignInUseCase>();
  Future<void> handleLogin() async {
    // validate form
    if (loginFormGlobalKey.currentState!.validate()) {
      // show loading
      isLoading.value = true;
      // call api
      Map<String, dynamic>? params = {
        "email": loginEmail.text,
        "password": loginPassword.text,
      };

      final dataState = await signInUseCase(params: params);
      // hide loading
      isLoading.value = false;
      // if success
      if (dataState is DataSuccess) {
        Get.offAllNamed(AppRoutes.bottomBar);
      } else {
        Get.snackbar(
          'Đăng nhập thất bại',
          'Email hoặc mật khẩu không đúng',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
      // if fail
      // loginError.value = 'Email hoặc mật khẩu không đúng';
    }
  }

  void showChangePassValidator() {
    validatorChangePassVisibility.value = true;
  }

  void hideChangePassValidator() {
    validatorChangePassVisibility.value = false;
  }

  void checkCanShowValidator(String value) {
    if (value.isEmpty || validatorSusscess.value) {
      hideValidator();
    } else {
      showValidator();
    }
  }

  void showValidator() {
    validatorVisibility.value = true;
  }

  void hideValidator() {
    validatorVisibility.value = false;
  }

  Future<void> handleRegister() async {}

  Future<void> handleForgotPass() async {}

  /// this is add info form
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

  /// forgot password
  var emailForgotTextController = TextEditingController();
  var newPasswordTextController = TextEditingController();
  var reNewPasswordTextController = TextEditingController();

  void handleForgotPassword() {}

  void handleResetPassword() {}
}
