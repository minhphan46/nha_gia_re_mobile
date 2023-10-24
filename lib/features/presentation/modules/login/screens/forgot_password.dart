import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/config/theme/app_color.dart';
import 'package:nhagiare_mobile/config/theme/text_styles.dart';
import 'package:nhagiare_mobile/core/extensions/integer_ex.dart';
import 'package:nhagiare_mobile/core/extensions/textstyle_ex.dart';

import '../../../../../config/routes/app_routes.dart';
import '../../../../../config/values/asset_image.dart';
import '../login_controller.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final LoginController controller = Get.find<LoginController>();

  final _emailFocusNode = FocusNode();

  @override
  void dispose() {
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 15.hp),
              // Logo
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    Assets.forgotPassword,
                    width: 70.wp,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "NHAGIARE",
                    style: AppTextStyles.semiBold20.colorEx(AppColor.green),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Vui lòng điền email gắn với tài khoản của bạn để nhận đường dẫn thay đổi mật khẩu",
                    style: AppTextStyles.regular14.colorEx(AppColor.lightBlack),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Obx(
                () => TextFormField(
                  focusNode: _emailFocusNode,
                  controller: controller.emailForgotTextController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  style: AppTextStyles.regular14,
                  decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Nhập Email'.tr,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 18.0, horizontal: 20.0),
                      errorText: (controller.loginError.value == '')
                          ? null
                          : controller.loginError.value,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      )),
                  validator: (value) =>
                      (value!.isEmail) ? null : 'Email không hợp lệ'.tr,
                  onTapOutside: (event) {
                    _emailFocusNode.unfocus();
                  },
                ),
              ),
              const SizedBox(height: 15),
              // button tiep tuc
              Obx(() => ElevatedButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.resetPassword);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.green,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      textStyle: const TextStyle(color: AppColor.white),
                      minimumSize: Size(100.wp, 55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
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
                            'Tiếp tục'.tr,
                            style: AppTextStyles.bold14.colorEx(AppColor.white),
                          ),
                  )),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Chưa có tài khoản? "),
                  TextButton(
                      onPressed: () async {
                        Get.toNamed(AppRoutes.register);
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                      ),
                      child: Text('Đăng ký ngay'.tr)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
