// screens/gallery_screen.dart
import 'package:flutter/material.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('갤러리')),
      body: const Center(child: Text('사진 업로드 화면')),
    );
  }
}