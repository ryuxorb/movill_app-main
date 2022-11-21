import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movill/src/components/message_popup.dart';

enum PageName {
  Home,
  Business,
  Notice,
  MyPage,
}

class BottomNavController extends GetxController {
  RxInt pageIndex = 0.obs;
  List<int> bottomHistory = [0];

  void chageBottomNav(int value, {bool hasGestrue = true}) {
    var page = PageName.values[value];
    switch (page) {
      case PageName.Home:
      case PageName.Business:
      case PageName.Notice:
      case PageName.MyPage:
        _changePage(value, hasGesture: hasGestrue);
    }
  }

  void _changePage(int value, {bool hasGesture = true}) {
    pageIndex(value);
    if (!hasGesture) return;
    // if (bottomHistory.contains(value)) {
    //   bottomHistory.remove(value);
    // } [0, 1, 2, 3] > [1, 2, 3, 0]
    if (bottomHistory.last != value) {
      bottomHistory.add(value);
      print(bottomHistory);
    } // [0, 1, 2, 3] > [0, 1, 2, 3, 0]
  }

  Future<bool> willPopAction() async {
    if (bottomHistory.length == 1) {
      showDialog(
          context: Get.context!,
          builder: (context) => MessagePopup(
                cancelCallback: Get.back,
                title: 'Movill',
                message: 'Are you sure you want to quit the program?',
                okCallback: () {
                  exit(0);
                },
              ));
      return true;
    } else {
      print('goto before page');
      bottomHistory.removeLast();
      var index = bottomHistory.last;
      chageBottomNav(index, hasGestrue: false);
      print(bottomHistory);
      return false;
    }
  }
}
