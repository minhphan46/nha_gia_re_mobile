import 'dart:io';
import 'package:flutter/material.dart';
import 'package:nhagiare_mobile/core/extensions/integer_ex.dart';
import '../../../../../config/theme/app_color.dart';
import '../../../../../config/values/asset_image.dart';

// ignore: must_be_immutable
class ImageAvatarPicker extends StatefulWidget {
  const ImageAvatarPicker({
    required this.getImageFromCamera,
    required this.getImageFromGallery,
    required this.imageAvatar,
    super.key,
  });
  final Function getImageFromCamera;
  final Function getImageFromGallery;
  final File? imageAvatar;

  @override
  State<ImageAvatarPicker> createState() => _ImageAvatarPickerState();
}

class _ImageAvatarPickerState extends State<ImageAvatarPicker> {
  Future<void> showImageSoure(BuildContext context) async {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () async {
                await widget.getImageFromCamera();
                setState(() {});
              },
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text('Gallery'),
              onTap: () async {
                await widget.getImageFromGallery();
                setState(() {});
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          buildImage(context),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildEditIcon(AppColors.green),
          ),
        ],
      ),
    );
  }

  Widget buildImage(BuildContext context) {
    return buildCircle(
      color: AppColors.green,
      all: 1,
      child: buildCircle(
        color: Colors.white,
        all: 1,
        child: ClipOval(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () async {
                // click on the image
                await showImageSoure(context);
              },
              child: showFace(),
            ),
          ),
        ),
      ),
    );
  }

  Widget showFace() {
    int imageSize = 30;
    if (widget.imageAvatar != null) {
      return Image.file(
        widget.imageAvatar!,
        fit: BoxFit.cover,
        width: imageSize.wp,
        height: imageSize.wp,
      );
    } else {
      return SizedBox(
        width: imageSize.wp,
        height: imageSize.wp,
        child: Image.asset(
          Assets.avatarDefault,
          fit: BoxFit.cover,
        ),
      );
    }
  }

  Widget buildEditIcon(Color color) {
    return buildCircle(
      color: Colors.white,
      all: 2,
      child: buildCircle(
        color: color,
        all: 5,
        child: InkWell(
          onTap: () async {
            // click on the image
            await showImageSoure(context);
          },
          child: const Icon(
            Icons.add_a_photo,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) {
    return ClipOval(
      child: Container(
        padding: EdgeInsets.all(all),
        color: color,
        child: child,
      ),
    );
  }
}
