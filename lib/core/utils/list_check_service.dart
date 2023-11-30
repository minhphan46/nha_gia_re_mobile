import 'package:get/get.dart';

class ListCheckService {
  // input list value
  List<String> values = [];
  // from list value => generate to list check with
  List checkListItems = [];
  // ouput list checked
  RxList<String> multipleSelected = <String>[].obs;
  Function? expendedFunc;

  ListCheckService({
    required this.values,
    this.expendedFunc,
  }) {
    checkListItems = convertList(values);
  }

  List<String> getListSelected() {
    return <String>[...multipleSelected];
  }

  void reset() {
    // reset false to all item of checklistItems
    for (var item in checkListItems) {
      item["value"].value = false;
    }
    // multipleSelected = null
    multipleSelected.value = [];
  }

  void onChange(int i, bool value) {
    // change value
    checkListItems[i]["value"].value = value;
    if (multipleSelected.contains(checkListItems[i]["title"])) {
      multipleSelected.remove(checkListItems[i]["title"]);
    } else {
      multipleSelected.add(checkListItems[i]["title"]);
    }
    // function added
    if (expendedFunc != null) expendedFunc!();
  }

  ///convert list values => list check items
  /// values = ["title1", "title2", "title3",] =>   [{"id": id, "value": value, "title": title,}]
  List convertList(List<String> values) {
    List<Map<String, dynamic>> checkListItems =
        values.asMap().entries.map((entry) {
      int id = entry.key;
      String title = entry.value;
      RxBool value = false.obs;
      return {
        "id": id,
        "value": value,
        "title": title,
      };
    }).toList();

    return checkListItems;
  }

  bool isEqualValue(int index) {
    return getListSelected().contains(values[index]);
  }
}
