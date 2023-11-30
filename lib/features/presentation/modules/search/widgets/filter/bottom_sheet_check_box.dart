import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/core/extensions/integer_ex.dart';

// ignore: must_be_immutable
class BottomSheetCheckBox extends StatelessWidget {
  List checkListItems;
  Function onChanged;

  BottomSheetCheckBox({
    required this.checkListItems,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.hp,
      padding: const EdgeInsets.only(top: 10),
      child: ListView.builder(
        itemCount: checkListItems.length,
        itemBuilder: (_, i) {
          return Obx(
            () => ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              title: Text(checkListItems[i]["title"]),
              trailing: SizedBox(
                width: 40,
                child: Checkbox(
                  onChanged: (value) => onChanged(i, value),
                  value: checkListItems[i]["value"].value,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
