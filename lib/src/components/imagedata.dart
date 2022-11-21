import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageData extends StatelessWidget {
  String icon;
  final double? width; // ?는 null 값을 받는다는 의미

  ImageData(
    this.icon, {
    Key? key,
    this.width = 65,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      icon,
      width: width! / Get.mediaQuery.devicePixelRatio,
    );
  }
}

class IconsPath {
  static String get homeoff => 'assets/images/bottom_nav_home_off_icon.jpg';
  static String get homeon => 'assets/images/bottom_nav_home_on_icon.jpg';
  static String get mypage => 'assets/images/my_tag_image_on_icon.jpg';
  static String get business =>
      'assets/images/mypage_bottom_sheet_setting_04.jpg';
  static String get notice =>
      'assets/images/mypage_bottom_sheet_setting_02.jpg';
}
