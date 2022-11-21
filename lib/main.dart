import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movill/src/app.dart';
import 'package:movill/src/binding/init_binding.dart';
import 'package:movill/src/devicesList.dart';
import 'package:movill/src/dio_server.dart';
import 'package:movill/src/login.dart';
import 'package:movill/src/map.dart';
import 'package:movill/src/polyline.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Movill',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            titleTextStyle: TextStyle(color: Colors.black),
          ),
        ),
        initialBinding: InitBinding(), // 버튼컨트롤러 인스턴스 관리
        home: Login());
  }
}
