import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/config/theme/text_styles.dart';
import 'package:nhagiare_mobile/core/extensions/integer_ex.dart';
import 'package:nhagiare_mobile/features/presentation/modules/create_post/create_post_controller.dart';
import 'package:nhagiare_mobile/features/presentation/modules/create_post/widgets/chatacter_box.dart';
import '../../../../../domain/enums/furniture_status.dart';
import '../../../../../domain/enums/legal_document_status.dart';
import '../../../../global_widgets/base_dropdown_button.dart';

class ApartmentMoreInfoCard extends StatelessWidget {
  ApartmentMoreInfoCard({super.key});

  final CreatePostController controller = Get.find<CreatePostController>();

  @override
  Widget build(BuildContext context) {
    final double widthDropdown = 38.wp;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: widthDropdown,
              child: BaseDropdownButton(
                title: "Giấy tờ pháp lý",
                hint: "Không bắt buộc",
                width: widthDropdown,
                isSetSelectedItemBuilder: true,
                value: controller.apartmentLegalDocumentStatus.value,
                items: LegalDocumentStatus.toMap().entries.map((entry) {
                  return DropdownMenuItem(
                    value: entry.key,
                    child: Text(
                      entry.value,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    controller.setapartmentLegalDocumentStatus(
                        value as LegalDocumentStatus);
                  }
                },
                onSaved: (value) {
                  if (value == null) return;
                },
              ),
            ),
            SizedBox(
              width: widthDropdown,
              child: BaseDropdownButton(
                title: "Tình trạng nội thất",
                hint: "Không bắt buộc",
                width: widthDropdown,
                isSetSelectedItemBuilder: true,
                value: controller.apartmentFurnitureStatus.value,
                items: FurnitureStatus.toMap().entries.map((entry) {
                  return DropdownMenuItem(
                    value: entry.key,
                    child: Text(
                      entry.value,
                      overflow: TextOverflow.visible,
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    controller
                        .setapartmentFurnitureStatus(value as FurnitureStatus);
                  }
                },
                onSaved: (value) {
                  if (value == null) return;
                },
              ),
            ),
          ],
        ),
        // is facade
        const SizedBox(height: 10),
        CharacterBox(
          title: "Đặt điểm chung cư",
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Obx(
                  () => SizedBox(
                    width: 50,
                    child: Checkbox(
                      value: controller.houseIsFacade.value,
                      onChanged: (value) => controller.sethouseIsFacade(value!),
                    ),
                  ),
                ),
                Text("Căn góc", style: AppTextStyles.regular14),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
