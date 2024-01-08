import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nhagiare_mobile/core/extensions/double_ex.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../../../config/values/asset_image.dart';
import '../../../../domain/enums/type_indetification_document.dart';
import '../verification_controller.dart';

class ChooseImage extends StatefulWidget {
  final VerificationController verifyController;
  final bool typeImage;
  const ChooseImage(this.verifyController, this.typeImage, {super.key});

  @override
  State<ChooseImage> createState() => _ChooseImageState();
}

class _ChooseImageState extends State<ChooseImage> {
  String getAssetImage(TypeIndetificationDocument type) {
    if (widget.typeImage) {
      // mat truoc
      switch (type) {
        case TypeIndetificationDocument.canCuocCongDan:
          return Assets.cccdFront;
        case TypeIndetificationDocument.chungMinhNhanDan:
          return Assets.cmndFront;
        case TypeIndetificationDocument.hoChieu:
          return Assets.hochieuFront;
      }
    } else {
      switch (type) {
        case TypeIndetificationDocument.canCuocCongDan:
          return Assets.cccdBack;
        case TypeIndetificationDocument.chungMinhNhanDan:
          return Assets.cmndBack;
        case TypeIndetificationDocument.hoChieu:
          return Assets.hochieuBack;
      }
    }
  }

  File? _pickedImage;

  void _pickImageFromCamera() async {
    final pickedImageFile = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 60, maxWidth: 150);
    if (pickedImageFile != null) {
      _pickedImage = File(pickedImageFile.path);
      widget.verifyController
          .handelUploadIdCard(File(_pickedImage!.path), widget.typeImage);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: 50.0.wp,
      child: Column(
        children: [
          Obx(
            () => InkWell(
              onTap: () => _pickImageFromCamera(),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(10),
                height: 130,
                width: double.infinity,
                child: _pickedImage != null
                    ? Image.file(
                        _pickedImage!,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        fit: BoxFit.cover,
                        getAssetImage(widget
                            .verifyController.typeIndetificationDocument.value),
                      ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          InkWell(
            onTap: () => _pickImageFromCamera(),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.green,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.camera_alt,
                      color: AppColors.white,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      widget.typeImage ? "Chụp mặt trước" : "Chụp mặt sau",
                      style:
                          AppTextStyles.bold14.copyWith(color: AppColors.white),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
