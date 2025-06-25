// lib/screens/expense_screen.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/expense.dart';
import '../services/local_storage_service.dart';
import '../widgets/expense_chart.dart';
import '../widgets/AddExpenseDialog.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({Key? key}) : super(key: key);

  @override
  _ExpenseScreenState createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  final LocalStorageService _storage = LocalStorageService();
  final List<Expense> _expenses = [];
  final String _storageKey = 'expense_items';

  @override
  void initState() {
    super.initState();
    _loadExpenses();
  }

  Future<void> _loadExpenses() async {
    final data = await _storage.loadData(_storageKey);
    if (data != null) {
      final List<dynamic> jsonList = jsonDecode(data);
      setState(() {
        _expenses.clear();
        _expenses.addAll(jsonList.map((e) => Expense(
          id: e['id'],
          title: e['title'],
          amount: e['amount'],
          date: DateTime.parse(e['date']),
        )));
      });
    }
  }

  Future<void> _saveExpenses() async {
    final jsonStr = jsonEncode(_expenses.map((e) => {
      'id': e.id,
      'title': e.title,
      'amount': e.amount,
      'date': e.date.toIso8601String(),
    }).toList());
    await _storage.saveData(_storageKey, jsonStr);
  }

  Future<void> _addNewExpense() async {
    final newExp = await showDialog<Expense>(
      context: context,
      builder: (_) => AddExpenseDialog(),
    );
    if (newExp != null) {
      setState(() => _expenses.add(newExp));
      await _saveExpenses();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: ExpenseChart(expenses: _expenses)),
        ElevatedButton.icon(
          onPressed: _addNewExpense,
          icon: const Icon(Icons.add),
          label: const Text('새 지출/수입 추가'),
        ),
      ],
    );
  }
}