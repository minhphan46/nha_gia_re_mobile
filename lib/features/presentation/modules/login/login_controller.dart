import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:nhagiare_mobile/core/utils/date_picker.dart';

import '../../../../core/service/device_service.dart';

class LoginController extends GetxController {
  var loginEmail = TextEditingController();
  var loginPassword = TextEditingController();
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

  void toggleRepeatPassReg() {
    isObscureRepeatPass.value = !isObscureRepeatPass.value;
  }

  Future<void> handleLogin() async {}

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
  var emailUpdateInfoTextController = TextEditingController(text: "asdasdasd");
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
}
