import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  String nameUser = "Minh Phan";

  RxInt unreadMessCount = 1.obs;
  RxInt unreadNotiCount = 1.obs;

  // Search
  var textSearchController = TextEditingController();
  var searchFocusNode = FocusNode();
  onTapSearch() {}
  onChangedTextFiled(String value) {}
}
