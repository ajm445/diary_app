// 화면: 텍스트 및 사진을 입력하여 메모를 저장하는 화면

import 'dart:io'; // 이미지 파일 처리를 위한 패키지
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // 이미지 선택을 위한 패키지
import '../services/memo_service.dart'; // 메모 저장을 위한 서비스

class MemoDetailScreen extends StatefulWidget {
  final DateTime initialDate; // 메모에 저장될 날짜

  const MemoDetailScreen({Key? key, required this.initialDate}) : super(key: key);

  @override
  State<MemoDetailScreen> createState() => _MemoDetailScreenState();
}

class _MemoDetailScreenState extends State<MemoDetailScreen> {
  final _contentCtrl = TextEditingController(); // 텍스트 입력 컨트롤러
  File? _pickedImage; // 사용자가 선택한 이미지 파일
  final _service = MemoService(); // 메모 저장 서비스 인스턴스

  // 이미지 선택 함수 (갤러리에서 이미지 선택)
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery); // 갤러리에서 선택
    if (picked != null) {
      setState(() => _pickedImage = File(picked.path)); // 이미지 파일 설정
    }
  }

  // 메모 저장 함수
  Future<void> _save() async {
    final text = _contentCtrl.text.trim();
    // 텍스트와 이미지 모두 없으면 저장 안 함
    if (text.isEmpty && _pickedImage == null) return;

    // 메모 서비스에 저장 요청
    await _service.addMemo(
      content: text,
      imagePath: _pickedImage?.path,
      date: widget.initialDate,
    );

    Navigator.pop(context, true); // 저장 후 이전 화면으로 돌아가기 (성공 플래그 true 전달)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('새 메모')),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 텍스트 입력창
            TextField(
              controller: _contentCtrl,
              decoration: const InputDecoration(labelText: '내용 입력'),
              maxLines: 5, // 최대 5줄 입력 가능
            ),
            const SizedBox(height: 12),

            // 선택된 이미지가 있으면 화면에 표시
            if (_pickedImage != null)
              Image.file(_pickedImage!, height: 150),

            // 이미지 선택 버튼
            ElevatedButton.icon(
              icon: const Icon(Icons.photo),
              label: const Text('이미지 선택'),
              onPressed: _pickImage,
            ),

            const Spacer(),

            // 저장 버튼
            ElevatedButton(
              onPressed: _save,
              child: const Text('저장하기'),
            )
          ],
        ),
      ),
    );
  }
}
