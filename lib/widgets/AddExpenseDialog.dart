// widgets/AddExpenseDialog.dart
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/expense.dart';

class AddExpenseDialog extends StatefulWidget {
  const AddExpenseDialog({super.key});

  @override
  _AddExpenseDialogState createState() => _AddExpenseDialogState();
}

class _AddExpenseDialogState extends State<AddExpenseDialog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  bool _isIncome = false;

  void _submit() {
    final title = _titleController.text.trim();
    final amount = double.tryParse(_amountController.text.trim()) ?? 0;
    if (title.isNotEmpty && amount > 0) {
      final newExp = Expense(
        id: const Uuid().v4(),
        title: title,
        amount: _isIncome ? amount : -amount,
        date: DateTime.now(),
      );
      Navigator.pop(context, newExp);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('새 지출/수입 추가'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: '항목명'),
          ),
          TextField(
            controller: _amountController,
            decoration: const InputDecoration(labelText: '금액'),
            keyboardType: TextInputType.number,
          ),
          Row(
            children: [
              Checkbox(
                value: _isIncome,
                onChanged: (val) => setState(() => _isIncome = val ?? false),
              ),
              const Text('수입인가요?'),
            ],
          )
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('취소')),
        ElevatedButton(onPressed: _submit, child: const Text('저장')),
      ],
    );
  }
}