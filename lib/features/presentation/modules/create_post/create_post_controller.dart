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
}
