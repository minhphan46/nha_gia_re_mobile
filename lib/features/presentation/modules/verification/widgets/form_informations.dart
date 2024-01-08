import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../verification_controller.dart';

class FormInfomations extends StatefulWidget {
  final VerificationController controller;
  const FormInfomations(this.controller, {super.key});

  @override
  State<FormInfomations> createState() => _FormInfomationsState();
}

class _FormInfomationsState extends State<FormInfomations> {
  final _nameFocusNode = FocusNode();
  final _idFocusNode = FocusNode();
  final _cardIssuedDateFocusNode = FocusNode();
  final _countryFocusNode = FocusNode();
  final _birthdayFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    widget.controller.userInfoFormKey = GlobalKey<FormState>();
    widget.controller.countryTextController.text = "Việt Nam";
    widget.controller.issuedBy = widget.controller.issuedByList[0].obs;
  }

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _idFocusNode.dispose();
    _cardIssuedDateFocusNode.dispose();
    _countryFocusNode.dispose();
    _birthdayFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.controller.userInfoFormKey,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(
              focusNode: _nameFocusNode,
              key: const ValueKey('name'),
              controller: widget.controller.fullNameTextController,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              maxLines: 1,
              style: AppTextStyles.regular16,
              decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  suffixIcon: IconButton(
                    onPressed: () {
                      widget.controller.fullNameTextController.clear();
                    },
                    icon: const Icon(Icons.close_rounded),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Full name'.tr,
                  labelText: "Họ và tên thật, có dấu, viết cách",
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  )),
              validator: widget.controller.validateTextField,
              onTapOutside: (event) {
                _nameFocusNode.unfocus();
                widget.controller.checkCanfinish();
              },
              onFieldSubmitted: (_) {
                // chuyen qua textfill tiep theo
                FocusScope.of(context).requestFocus(_idFocusNode);
                widget.controller.checkCanfinish();
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              focusNode: _idFocusNode,
              key: const ValueKey('identityCard'),
              controller: widget.controller.identityCardNoTextController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              maxLines: 1,
              style: AppTextStyles.regular16,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  suffixIcon: IconButton(
                    onPressed: () {
                      widget.controller.identityCardNoTextController.clear();
                    },
                    icon: const Icon(Icons.close_rounded),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Căn cước công dân'.tr,
                  labelText: "Nhập đúng số Căn cước",
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  )),
              validator: widget.controller.validateIdCardTextField,
              onTapOutside: (event) {
                _idFocusNode.unfocus();
                widget.controller.checkCanfinish();
              },
              onFieldSubmitted: (_) {
                _idFocusNode.unfocus();
                widget.controller.checkCanfinish();
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              key: const ValueKey('identityCardIssuedDate'),
              focusNode: _cardIssuedDateFocusNode,
              readOnly: true,
              controller:
                  widget.controller.identityCardIssuedDateTextController,
              textInputAction: TextInputAction.next,
              maxLines: 1,
              style: AppTextStyles.regular16,
              onTap: () => widget.controller.handleDatePicker(
                  widget.controller.identityCardIssuedDateTextController,
                  widget.controller.identityCardIssuedDate),
              decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  suffixIcon: IconButton(
                    onPressed: () {
                      widget.controller.handleDatePicker(
                          widget
                              .controller.identityCardIssuedDateTextController,
                          widget.controller.identityCardIssuedDate);
                    },
                    icon: const Icon(Icons.calendar_month_outlined),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: '01/01/2023',
                  labelText: "Ngày cấp giấy tờ",
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  )),
              validator: widget.controller.validateTextField,
              onTapOutside: (event) {
                _cardIssuedDateFocusNode.unfocus();
                widget.controller.checkCanfinish();
              },
            ),
            const SizedBox(height: 20),
            Obx(
              () => DropdownButtonFormField<String>(
                value: widget.controller.issuedBy.value,
                isExpanded: true,
                isDense: true,
                itemHeight: null,
                style: AppTextStyles.regular16.copyWith(color: AppColors.black),
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  hintText: "Chọn nơi cấp giấy tờ",
                  labelText: "Chọn nơi cấp giấy tờ",
                ),
                items: widget.controller.issuedByList.map((value) {
                  return DropdownMenuItem<String>(
                    value: value, // ensure this is unique
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(value),
                    ),
                  );
                }).toList(),
                selectedItemBuilder: (BuildContext context) {
                  return widget.controller.issuedByList.map<Widget>((item) {
                    return Text(
                      item,
                      overflow: TextOverflow.ellipsis,
                    );
                  }).toList();
                },
                onChanged: (value) {
                  widget.controller.changeIssueBy(value!);
                },
                validator: (value) {
                  if (value == null) {
                    return "Vui lòng chọn nơi cấp giấy tờ";
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              key: const ValueKey('country'),
              enabled: false,
              focusNode: _birthdayFocusNode,
              readOnly: true,
              controller: widget.controller.countryTextController,
              textInputAction: TextInputAction.next,
              maxLines: 1,
              style: AppTextStyles.regular16,
              decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Việt Nam',
                  labelText: "Quốc tịch",
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  )),
              validator: widget.controller.validateTextField,
              onTapOutside: (event) {
                _cardIssuedDateFocusNode.unfocus();
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              key: const ValueKey('birthday'),
              focusNode: _birthdayFocusNode,
              readOnly: true,
              controller: widget.controller.birthDayTextController,
              textInputAction: TextInputAction.next,
              maxLines: 1,
              style: AppTextStyles.regular16,
              onTap: () => widget.controller.handleDatePicker(
                  widget.controller.birthDayTextController,
                  widget.controller.birthday),
              decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  suffixIcon: IconButton(
                    onPressed: () {
                      widget.controller.handleDatePicker(
                          widget.controller.birthDayTextController,
                          widget.controller.birthday);
                    },
                    icon: const Icon(Icons.calendar_month_outlined),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: '01/01/2023',
                  labelText: "Ngày sinh",
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  )),
              validator: widget.controller.validateTextField,
              onTapOutside: (event) {
                _cardIssuedDateFocusNode.unfocus();
                widget.controller.checkCanfinish();
              },
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Obx(() => Flexible(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        child: RadioListTile<bool>(
                          visualDensity: const VisualDensity(
                              horizontal: VisualDensity.minimumDensity,
                              vertical: VisualDensity.minimumDensity),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          value: true,
                          groupValue: widget.controller.isMale.value,
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            "Nam",
                            style: AppTextStyles.regular16,
                          ),
                          onChanged: (ind) {
                            widget.controller.isMale.value = ind!;
                          },
                        ),
                      ),
                    )),
                const SizedBox(width: 20),
                Obx(() => Flexible(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        child: RadioListTile<bool>(
                          visualDensity: const VisualDensity(
                              horizontal: VisualDensity.minimumDensity,
                              vertical: VisualDensity.minimumDensity),
                          contentPadding: EdgeInsets.zero,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          value: false,
                          groupValue: widget.controller.isMale.value,
                          title: Text(
                            "Nữ",
                            style: AppTextStyles.regular16,
                          ),
                          onChanged: (ind) {
                            widget.controller.isMale.value = ind!;
                          },
                        ),
                      ),
                    )),
              ],
            ),
            const SizedBox(height: 10),
            Obx(() => SizedBox(
                  width: double.infinity,
                  child: CheckboxListTile(
                    visualDensity: const VisualDensity(
                        horizontal: VisualDensity.minimumDensity,
                        vertical: VisualDensity.minimumDensity),
                    contentPadding: EdgeInsets.zero,
                    title: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Tôi đồng ý với ",
                            style: AppTextStyles.regular14
                                .copyWith(color: AppColors.black),
                          ),
                          TextSpan(
                            text: "thỏa thuận sử dụng",
                            style: AppTextStyles.regular14
                                .copyWith(color: AppColors.green),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                launchUrl(Uri.parse(
                                    'https://zalopay.vn/quy-dinh/thoa-thuan-su-dung-zalopay'));
                              },
                          ),
                          TextSpan(
                            text: " của Nhà Giá Rẻ",
                            style: AppTextStyles.regular14
                                .copyWith(color: AppColors.black),
                          ),
                        ],
                      ),
                    ),
                    value: widget.controller.isApprove.value,
                    onChanged: (newValue) {
                      widget.controller.isApprove.value = newValue!;
                      widget.controller.checkCanfinish();
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, //  <-- leading Checkbox
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
