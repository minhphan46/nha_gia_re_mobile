import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/features/presentation/global_widgets/my_appbar.dart';
import 'package:nhagiare_mobile/features/presentation/modules/account/account_controller.dart';

class ChangeLanguageScreen extends StatefulWidget {
  const ChangeLanguageScreen({super.key});

  @override
  State<ChangeLanguageScreen> createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  final AccountController controller = Get.find<AccountController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(title: "Thay đổi ngôn ngữ"),
      // radio button
      body: Column(
        children: [
          RadioListTile<Language>(
            title: const Text("Tiếng Việt"),
            value: Language.vi,
            groupValue: controller.language.value,
            onChanged: (value) {
              controller.language.value = value!;
              setState(() {});
            },
          ),
          RadioListTile<Language>(
            title: const Text("English"),
            value: Language.en,
            groupValue: controller.language.value,
            onChanged: (value) {
              controller.language.value = value!;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}
