import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nhagiare_mobile/core/extensions/integer_ex.dart';

// ignore: must_be_immutable
class BottomSheetRadio extends StatelessWidget {
  List<String> categorys;
  RxInt selected;
  Function onChanged;

  BottomSheetRadio({
    required this.categorys,
    required this.selected,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.hp,
      padding: const EdgeInsets.only(top: 10),
      child: ListView.builder(
        itemCount: categorys.length,
        itemBuilder: (_, i) {
          return Obx(
            () => ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              title: Text(categorys[i]),
              trailing: SizedBox(
                width: 40,
                child: Radio(
                  value: i,
                  groupValue: selected.value,
                  onChanged: (val) => onChanged(val),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
