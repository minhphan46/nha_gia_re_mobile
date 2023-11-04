import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
}
