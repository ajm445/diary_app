// widgets/AddChecklistDialog.dart
import 'package:flutter/material.dart';

class AddChecklistDialog extends StatefulWidget {
  const AddChecklistDialog({super.key});

  @override
  State<AddChecklistDialog> createState() => _AddChecklistDialogState();
}

class _AddChecklistDialogState extends State<AddChecklistDialog> {
  final _controller = TextEditingController();

  void _submit() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      Navigator.pop(context, text); // 텍스트 전달
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('체크리스트 항목 추가'),
      content: TextField(
        controller: _controller,
        decoration: const InputDecoration(labelText: '내용'),
        onSubmitted: (_) => _submit(),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('취소')),
        ElevatedButton(onPressed: _submit, child: const Text('추가')),
      ],
    );
  }
}
