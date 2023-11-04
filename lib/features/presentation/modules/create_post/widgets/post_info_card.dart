import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/core/extensions/textstyle_ex.dart';
import '../../../../../config/theme/text_styles.dart';
import '../create_post_controller.dart';

class PostInfoCard extends StatelessWidget {
  PostInfoCard({super.key});
  final CreatePostController controller = Get.find<CreatePostController>();

  final _titleFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 5),
        TextFormField(
          focusNode: _titleFocusNode,
          controller: controller.titleTextController,
          minLines: 1,
          maxLines: 5,
          maxLength: 255,
          autocorrect: true,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          style: AppTextStyles.regular14.colorEx(Colors.black),
          decoration: InputDecoration(
            labelText: 'Tiêu đề',
            hintText: 'Nhập tiều đề'.tr,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          validator: (value) =>
              (value!.isNotEmpty) ? null : 'Tiêu đề không được rỗng'.tr,
          onTapOutside: (event) {
            _titleFocusNode.unfocus();
          },
          onSaved: (value) {
            controller.title = value;
          },
          onFieldSubmitted: (_) {
            // chuyen qua textfill tiep theo
            FocusScope.of(context).requestFocus(_descriptionFocusNode);
          },
        ),
        const SizedBox(height: 15),
        TextFormField(
          focusNode: _descriptionFocusNode,
          controller: controller.descriptionTextController,
          minLines: 1,
          maxLines: 10,
          autocorrect: true,
          maxLength: 1000,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          style: AppTextStyles.regular14.colorEx(Colors.black),
          decoration: InputDecoration(
            labelText: 'Mô tả chi tiết',
            hintText: 'Mô tả chi tiết'.tr,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          validator: (value) =>
              (value!.isNotEmpty) ? null : 'Mô tả không được rỗng'.tr,
          onTapOutside: (event) {
            _descriptionFocusNode.unfocus();
          },
          onSaved: (value) {
            controller.description = value;
          },
        ),
      ],
    );
  }
}
