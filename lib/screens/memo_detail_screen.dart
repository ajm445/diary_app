// screens/memo_detail_screen.dart
import 'package:flutter/material.dart';

class MemoDetailScreen extends StatelessWidget {
  const MemoDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('메모 상세')),
      body: const Center(child: Text('메모 상세 화면')),
    );
  }
}