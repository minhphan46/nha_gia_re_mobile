import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
}
