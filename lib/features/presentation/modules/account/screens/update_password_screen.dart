import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/core/extensions/integer_ex.dart';
import 'package:nhagiare_mobile/core/extensions/textstyle_ex.dart';
import 'package:nhagiare_mobile/features/presentation/global_widgets/my_appbar.dart';

import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../global_widgets/base_card.dart';
import '../../../global_widgets/base_textfield.dart';
import '../account_controller.dart';

class UpdatePasswordAccountScreen extends StatelessWidget {
  UpdatePasswordAccountScreen({super.key});

  final AccountController controller = Get.find<AccountController>();

  final _oldPassFocusNode = FocusNode();
  final _newPassFocusNode = FocusNode();
  final _reNewPassFocusNode = FocusNode();

  final TextEditingController oldPassTextController = TextEditingController();
  final TextEditingController newPassTextController = TextEditingController();
  final TextEditingController reNewPassTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(title: "Cập nhập mật khẩu"),
      body: Column(
        children: [
          BaseCard(
            isvisible: true,
            title: "Cập nhập mật khẩu",
            child: Column(
              children: [
                const SizedBox(height: 5),
                BaseTextField(
                  focusNode: _oldPassFocusNode,
                  nexFocusNode: _newPassFocusNode,
                  minLines: 1,
                  maxLines: 5,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  controller: oldPassTextController,
                  labelText: 'Nhâp mật khẩu cũ',
                  hintText: 'Nhập mật khẩu cũ',
                  onSaved: (value) {
                    controller.oldPassword = value!.trim();
                  },
                  validator: (value) => (value!.trim().isNotEmpty)
                      ? null
                      : 'Mật khẩu không được rỗng'.tr,
                ),
                const SizedBox(height: 20),
                BaseTextField(
                  focusNode: _newPassFocusNode,
                  nexFocusNode: _reNewPassFocusNode,
                  minLines: 1,
                  maxLines: 5,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  controller: newPassTextController,
                  labelText: 'Nhập mật khẩu mới',
                  hintText: 'Nhập mật khẩu mới',
                  onSaved: (value) {
                    controller.newPassword = value!.trim();
                  },
                  validator: (value) => (value!.trim().isNotEmpty)
                      ? null
                      : 'Mật khẩu không được rỗng'.tr,
                ),
                const SizedBox(height: 20),
                BaseTextField(
                  focusNode: _reNewPassFocusNode,
                  minLines: 1,
                  maxLines: 5,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  controller: reNewPassTextController,
                  labelText: 'Nhập lại mật khẩu mới',
                  hintText: 'Nhập lại mật khẩu mới',
                  onSaved: (value) {
                    controller.reNewPassword = value!.trim();
                  },
                  validator: (value) => (value!.trim().isNotEmpty)
                      ? null
                      : 'Mật khẩu không được rỗng'.tr,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Obx(
              () => ElevatedButton(
                onPressed: controller.isCanClickUpdatePassword.value
                    ? () {
                        controller.updatePassword();
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.green,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(color: AppColors.white),
                  elevation: 10,
                  minimumSize: Size(100.wp, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Tiếp tục'.tr,
                  style: AppTextStyles.bold14.colorEx(AppColors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
