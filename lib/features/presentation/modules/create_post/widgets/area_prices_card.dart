import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/core/extensions/textstyle_ex.dart';
import '../../../../../config/theme/text_styles.dart';
import '../create_post_controller.dart';

class AreaPricesCard extends StatelessWidget {
  AreaPricesCard({super.key});

  final CreatePostController controller = Get.find<CreatePostController>();

  final _areaFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();
  final _depositFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 5),
        TextFormField(
          focusNode: _areaFocusNode,
          controller: controller.areaTextController,
          maxLines: 1,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          style: AppTextStyles.regular14.colorEx(Colors.black),
          decoration: const InputDecoration(
            labelText: 'Diện tích (m2)',
            hintText: "Diện tích",
            contentPadding:
                EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          onTapOutside: (event) {
            _areaFocusNode.unfocus();
          },
          onSaved: (value) {
            controller.area = value;
          },
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(_priceFocusNode);
          },
        ),
        const SizedBox(height: 15),
        TextFormField(
          focusNode: _priceFocusNode,
          controller: controller.priceTextController,
          maxLines: 1,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          style: AppTextStyles.regular14.colorEx(Colors.black),
          decoration: const InputDecoration(
            labelText: 'Giá (VNĐ)',
            hintText: "Giá",
            contentPadding:
                EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          onTapOutside: (event) {
            _priceFocusNode.unfocus();
          },
          onSaved: (value) {
            controller.price = value;
          },
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(_depositFocusNode);
          },
        ),
        const SizedBox(height: 15),
        TextFormField(
          focusNode: _depositFocusNode,
          controller: controller.depositTextController,
          maxLines: 1,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.done,
          style: AppTextStyles.regular14.colorEx(Colors.black),
          decoration: const InputDecoration(
            labelText: 'Số tiền cọc (VNĐ)',
            hintText: "Không bắt buộc",
            contentPadding:
                EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          onTapOutside: (event) {
            _depositFocusNode.unfocus();
          },
          onSaved: (value) {
            controller.deposit = value;
          },
        ),
      ],
    );
  }
}
