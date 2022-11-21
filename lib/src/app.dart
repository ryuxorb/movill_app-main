import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movill/src/components/imagedata.dart';
import 'package:movill/src/controller/bottom_nav_controller.dart';
import 'package:movill/src/pages/active_history.dart';
import 'package:movill/src/pages/mypage.dart';
import 'package:movill/src/pages/search.dart';

import 'tabBar.dart';

class App extends GetView<BottomNavController> {
  // GetX 이용
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Obx(
        () => Scaffold(
          body: IndexedStack(
            index: controller.pageIndex.value,
            children: <Widget>[
              Container(
                child: TabPage(),
              ),
              const Search(),
              const ActiveHistory(),
              const MyPage(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: controller.pageIndex.value,
            onTap: controller.chageBottomNav, // currentIndex 로 하단 바 버튼 이벤트
            items: [
              BottomNavigationBarItem(
                icon: ImageData(IconsPath.homeoff),
                activeIcon: ImageData(IconsPath.homeon),
                label: 'home',
              ),
              BottomNavigationBarItem(
                icon: ImageData(IconsPath.business),
                activeIcon: ImageData(IconsPath.business),
                label: 'business',
              ),
              BottomNavigationBarItem(
                icon: ImageData(IconsPath.notice),
                activeIcon: ImageData(IconsPath.notice),
                label: 'notice',
              ),
              BottomNavigationBarItem(
                icon: ImageData(IconsPath.mypage),
                activeIcon: ImageData(IconsPath.mypage),
                label: 'mypage',
              ),
            ],
          ),
        ),
      ),
      onWillPop: controller.willPopAction,
    );
  }
}
