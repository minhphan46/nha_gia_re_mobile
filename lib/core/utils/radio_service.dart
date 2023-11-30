import 'package:get/get.dart';

class RadioService {
  List<String> values = [];
  Function? expendedFunc;

  RadioService({
    required this.values,
    this.expendedFunc,
  });

  RxInt selectedValue = 0.obs;

  void reset() {
    selectedValue.value = 0;
  }

  void onChange(int? val) {
    selectedValue.value = val!;
    if (expendedFunc != null) expendedFunc!();
  }

  bool isEqualValue(int index) {
    return selectedValue.value == index;
  }
}
