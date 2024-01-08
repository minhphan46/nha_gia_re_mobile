import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/text_styles.dart';
import '../../../../../config/values/asset_image.dart';
import '../verification_controller.dart';

class ChooseImagePortrait extends StatefulWidget {
  final VerificationController verifyController;
  const ChooseImagePortrait(this.verifyController, {super.key});

  @override
  State<ChooseImagePortrait> createState() => _ChooseImagePortraitState();
}

class _ChooseImagePortraitState extends State<ChooseImagePortrait> {
  File? _pickedImage;

  void _pickImageFromCamera() async {
    final pickedImageFile = await ImagePicker().pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.front,
        imageQuality: 100,
        maxWidth: 150);
    if (pickedImageFile != null) {
      _pickedImage = File(pickedImageFile.path);
      widget.verifyController.handelUploadPortrait(File(_pickedImage!.path));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      InkWell(
        onTap: () => _pickImageFromCamera(),
        child: Obx(() => DottedBorder(
              color: widget.verifyController.isCanClickPortrait.value
                  ? Colors.white
                  : AppColors.green,
              strokeWidth: 1,
              borderType: BorderType.RRect,
              dashPattern: const [8, 4],
              radius: const Radius.circular(8),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(
                    widget.verifyController.isCanClickPortrait.value ? 0 : 10),
                height: 200,
                width: 150,
                child: _pickedImage != null
                    ? Image.file(
                        _pickedImage!,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        fit: BoxFit.cover,
                        Assets.portrait,
                      ),
              ),
            )),
      ),
      const SizedBox(height: 15),
      InkWell(
        onTap: () => _pickImageFromCamera(),
        child: Container(
          width: 200,
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
                  "Chụp ảnh",
                  style: AppTextStyles.bold14.copyWith(color: AppColors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
