// main.dart
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '다이어리 앱',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const HomeScreen(), // 라우트는 제거함
    );
  }
}