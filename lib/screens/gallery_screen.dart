// 화면: 사진 업로드 또는 보기 기능을 위한 갤러리 화면 (현재는 기본 텍스트만 표시됨)

import 'package:flutter/material.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 상단 앱바에 '갤러리' 제목 표시
      appBar: AppBar(title: const Text('갤러리')),

      // 본문 중앙에 안내 텍스트 표시
      body: const Center(
        child: Text('사진 업로드 화면'), // 향후 업로드된 사진 목록 또는 업로드 UI로 확장 예정
      ),
    );
  }
}
