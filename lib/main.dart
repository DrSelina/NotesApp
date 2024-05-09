import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:test_app_1/pages/login_page.dart';

void main() {
  runApp(
    const MainApp(),
  );
}

final talker = TalkerFlutter.init();
final dio = Dio();

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}
