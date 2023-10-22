import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/core/extensions/integer_ex.dart';
import 'package:nhagiare_mobile/core/extensions/textstyle_ex.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../../../core/extensions/string_ex.dart';
import '../login_controller.dart';
import '../widgets/image_logo.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final LoginController controller = Get.find<LoginController>();

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _rePasswordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _rePasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Form(
          key: controller.registerFormGlobalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 2.hp),
              // Logo
              const ImageLogo(),
              // text field email
              Obx(() => TextFormField(
                    focusNode: _emailFocusNode,
                    controller: controller.registerEmail,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    style: AppTextStyles.regular14,
                    decoration: InputDecoration(
                      hintText: 'Email'.tr,
                      labelText: 'Nhập Email',
                      errorText: (controller.registerError.value == '')
                          ? null
                          : controller.registerError.value,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    validator: (value) =>
                        (value!.isEmail) ? null : 'Email không hợp lệ'.tr,
                    onTapOutside: (event) {
                      _emailFocusNode.unfocus();
                    },
                    onFieldSubmitted: (_) {
                      // chuyen qua textfill tiep theo
                      FocusScope.of(context).requestFocus(_passwordFocusNode);
                    },
                  )),
              const SizedBox(height: 15),
              Obx(() => TextFormField(
                    focusNode: _passwordFocusNode,
                    textInputAction: TextInputAction.next,
                    controller: controller.registerPassword,
                    obscureText: controller.isObscureRegister.value,
                    style: AppTextStyles.regular14,
                    autocorrect: false,
                    enableSuggestions: false,
                    onChanged: (value) {
                      controller.checkCanShowValidator(value);
                    },
                    decoration: InputDecoration(
                        hintText: 'Mật khẩu'.tr,
                        labelText: 'Nhập mật khẩu'.tr,
                        suffixIcon: IconButton(
                          icon: Icon(
                            !controller.isObscureRegister.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColor.green,
                          ),
                          onPressed: controller.togglePassReg,
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        )),
                    onTapOutside: (event) {
                      _passwordFocusNode.unfocus();
                    },
                    onFieldSubmitted: (_) {
                      // chuyen qua textfill tiep theo
                      FocusScope.of(context).requestFocus(_rePasswordFocusNode);
                    },
                  )),
              const SizedBox(height: 10),
              Obx(
                () => Visibility(
                  visible: controller.validatorVisibility.value,
                  child: FlutterPwValidator(
                      controller: controller.registerPassword,
                      strings: ValidateString(),
                      minLength: 8,
                      successColor: AppColor.green,
                      failureColor: AppColor.red,
                      uppercaseCharCount: 1,
                      lowercaseCharCount: 1,
                      specialCharCount: 1,
                      numericCharCount: 1,
                      width: 400,
                      height: 180,
                      onSuccess: () {
                        controller.hideValidator();
                        controller.validatorSusscess.value = true;
                      },
                      onFail: () {
                        controller.showValidator();
                        controller.validatorSusscess.value = false;
                      }),
                ),
              ),
              const SizedBox(height: 5),
              Obx(() => TextFormField(
                    focusNode: _rePasswordFocusNode,
                    textInputAction: TextInputAction.done,
                    obscureText: controller.isObscureRepeatPass.value,
                    autocorrect: false,
                    enableSuggestions: false,
                    style: AppTextStyles.regular14,
                    decoration: InputDecoration(
                        hintText: 'Nhập lại mật khẩu'.tr,
                        labelText: 'Nhập lại mật khẩu'.tr,
                        suffixIcon: IconButton(
                          icon: Icon(
                            !controller.isObscureRepeatPass.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColor.green,
                          ),
                          onPressed: controller.toggleRepeatPassReg,
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        )),
                    validator: (value) {
                      if (value != controller.registerPassword.text) {
                        return "Mật khẩu không khớp".tr;
                      }
                      return null;
                    },
                    onTapOutside: (event) {
                      _rePasswordFocusNode.unfocus();
                    },
                  )),
              const SizedBox(height: 20),
              // Button register
              Obx(() => ElevatedButton(
                    onPressed: controller.handleRegister,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.green,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      textStyle: const TextStyle(color: AppColor.white),
                      elevation: 10,
                    ),
                    child: controller.isLoading.value
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.black,
                              strokeWidth: 2,
                            ))
                        : Text(
                            'Đăng ký'.tr,
                            style: AppTextStyles.bold14.colorEx(AppColor.white),
                          ),
                  )),
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                      ),
                      child: Text('Đăng nhập'.tr)),
                  const Spacer(),
                  TextButton(
                      onPressed: () {
                        //Get.to(() => const ForgetPasswordPage());
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                      ),
                      child: Text('Quên mật khẩu?'.tr)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
