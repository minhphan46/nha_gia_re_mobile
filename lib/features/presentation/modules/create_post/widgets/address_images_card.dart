import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/core/extensions/integer_ex.dart';
import 'package:nhagiare_mobile/core/extensions/textstyle_ex.dart';
import 'package:nhagiare_mobile/features/domain/enums/property_types.dart';
import 'package:nhagiare_mobile/features/presentation/modules/create_post/widgets/picker_images.dart';
import '../../../../../config/theme/text_styles.dart';
import '../create_post_controller.dart';

class AddressImagesCard extends StatelessWidget {
  AddressImagesCard({super.key});
  final CreatePostController controller = Get.find<CreatePostController>();

  final _apartmentNameFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();
  final _blockFocusNode = FocusNode();
  final _floorFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 5),
        TextFormField(
          focusNode: _apartmentNameFocusNode,
          controller: controller.apartmentNameTextController,
          maxLines: 1,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          style: AppTextStyles.regular14.colorEx(Colors.black),
          decoration: InputDecoration(
            labelText: 'Tên tòa nhà / khu dân cư / dự án',
            hintText: controller.selectedPropertyType!.value ==
                    PropertyTypes.apartment
                ? 'Tên tòa nhà / khu dân cư / dự án'.tr
                : "(Không bắt buộc)",
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          onTapOutside: (event) {
            _apartmentNameFocusNode.unfocus();
          },
          onSaved: (value) {
            controller.apartmentName = value;
          },
        ),
        const SizedBox(height: 15),
        TextFormField(
          focusNode: _addressFocusNode,
          controller: controller.addressTextController,
          keyboardType: TextInputType.text,
          readOnly: true,
          textInputAction: TextInputAction.done,
          style: AppTextStyles.regular14.colorEx(Colors.black),
          decoration: const InputDecoration(
            labelText: 'Địa chỉ',
            hintText: "Địa chỉ",
            contentPadding:
                EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          onTapOutside: (event) {
            _addressFocusNode.unfocus();
          },
          onTap: () {},
          onSaved: (value) {
            controller.address = value;
          },
        ),
        const SizedBox(height: 15),
        Visibility(
          visible:
              controller.selectedPropertyType!.value == PropertyTypes.apartment,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 37.wp,
                child: TextFormField(
                  focusNode: _floorFocusNode,
                  controller: controller.floorTextController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  style: AppTextStyles.regular14.colorEx(Colors.black),
                  decoration: const InputDecoration(
                    labelText: 'Tầng',
                    hintText: "Tầng",
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onTapOutside: (event) {
                    _floorFocusNode.unfocus();
                  },
                  onTap: () {},
                  onSaved: (value) {
                    controller.floor = value;
                  },
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(_blockFocusNode);
                  },
                ),
              ),
              SizedBox(
                width: 40.wp,
                child: TextFormField(
                  focusNode: _blockFocusNode,
                  controller: controller.blockTextController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  style: AppTextStyles.regular14.colorEx(Colors.black),
                  decoration: const InputDecoration(
                    labelText: 'Block/Tòa',
                    hintText: "Block/Tòa",
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onTapOutside: (event) {
                    _blockFocusNode.unfocus();
                  },
                  onTap: () {},
                  onSaved: (value) {
                    controller.block = value;
                  },
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 15),
        PickerImages(),
      ],
    );
  }
}
