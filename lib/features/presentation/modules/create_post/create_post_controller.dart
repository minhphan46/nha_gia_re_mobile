import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../domain/enums/property_types.dart';

class CreatePostController extends GetxController {
  // card choose type property
  Rx<PropertyTypes>? selectedPropertyType = PropertyTypes.apartment.obs;
  bool isReachLimitPost = false;
  Rx<bool> isShowSale = false.obs;

  void setVisibility(PropertyTypes value) {
    selectedPropertyType!.value = value;
    // initBody();
    if (selectedPropertyType!.value != PropertyTypes.motel) {
      isShowSale.value = true;
    } else {
      isShowSale.value = false;
    }
  }

  void setWork(bool value) {
    isShowSale.value = value;
  }

  // card choose type of user
  RxBool isPersonal = true.obs;
  void setRole(bool value) {
    isPersonal.value = value;
  }

  // card post info
  final titleTextController = TextEditingController();
  final descriptionTextController = TextEditingController();
  String? title;
  String? description;

  // dia chi, hinh anh
  final apartmentNameTextController = TextEditingController();
  final addressTextController = TextEditingController();
  final blockTextController = TextEditingController();
  final floorTextController = TextEditingController();
  String? apartmentName;
  String? block;
  String? floor;
  String? address;

  // hinh anh
  bool? photoController;

  void checkLengthPhoto() {
    int length = photo.length + imageUrlList.length;
    if (length >= 3 && length <= 12) {
      photoController = true;
    } else {
      photoController = false;
    }
    update();
  }

  List<File> photo = [];
  List<String> imageUrlList = [];
  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery() async {
    final pickedImages = await _picker.pickMultiImage();
    for (int i = 0; i < pickedImages.length; i++) {
      photo.add(File(pickedImages[i].path));
    }
    checkLengthPhoto();
    update();
  }

  Future imgFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      photo.add(File(image.path));
      checkLengthPhoto();
      update();
    }
  }

  void deleteImage(int index) {
    if (index < imageUrlList.length) {
      imageUrlList.removeAt(index);
    } else {
      photo.removeAt(index - imageUrlList.length);
    }
    checkLengthPhoto();
    update();
  }

  // Dien tich , gia
  final areaTextController = TextEditingController();
  final priceTextController = TextEditingController();
  final depositTextController = TextEditingController();
  String? area;
  String? price;
  String? deposit;

  // thong tin khac
}
