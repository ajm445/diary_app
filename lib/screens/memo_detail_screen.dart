// screens/memo_detail_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/memo_service.dart';

class MemoDetailScreen extends StatefulWidget {
  final DateTime initialDate;

  const MemoDetailScreen({Key? key, required this.initialDate}) : super(key: key);

  @override
  State<MemoDetailScreen> createState() => _MemoDetailScreenState();
}

class _MemoDetailScreenState extends State<MemoDetailScreen> {
  final _contentCtrl = TextEditingController();
  File? _pickedImage;
  final _service = MemoService();

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _pickedImage = File(picked.path));
    }
  }

  Future<void> _save() async {
    final text = _contentCtrl.text.trim();
    if (text.isEmpty && _pickedImage == null) return;

    await _service.addMemo(
      content: text,
      imagePath: _pickedImage?.path,
      date: widget.initialDate,
    );

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('새 메모')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _contentCtrl,
              decoration: const InputDecoration(labelText: '내용 입력'),
              maxLines: 5,
            ),
            const SizedBox(height: 12),
            if (_pickedImage != null)
              Image.file(_pickedImage!, height: 150),
            ElevatedButton.icon(
              icon: const Icon(Icons.photo),
              label: const Text('이미지 선택'),
              onPressed: _pickImage,
            ),
            const Spacer(),
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