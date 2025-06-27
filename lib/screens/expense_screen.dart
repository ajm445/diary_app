// 화면: 사용자가 지출/수입 내역을 추가하고, 차트로 확인할 수 있는 가계부 화면

import 'dart:convert'; // JSON 인코딩/디코딩을 위한 패키지
import 'package:flutter/material.dart';
import '../models/expense.dart'; // 지출 항목 모델
import '../services/local_storage_service.dart'; // SharedPreferences 기반 로컬 저장소
import '../widgets/expense_chart.dart'; // 지출/수입 차트 위젯
import '../widgets/AddExpenseDialog.dart'; // 지출 추가 입력 다이얼로그

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({Key? key}) : super(key: key);

  @override
  _ExpenseScreenState createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  final LocalStorageService _storage = LocalStorageService(); // 로컬 저장소 인스턴스
  final List<Expense> _expenses = []; // 수입/지출 항목 리스트
  final String _storageKey = 'expense_items'; // 저장소 키

  @override
  void initState() {
    super.initState();
    _loadExpenses(); // 앱 시작 시 기존 데이터 불러오기
  }

  // 저장소에서 데이터를 불러와서 _expenses 리스트에 반영
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

  // 현재 _expenses 리스트를 JSON으로 변환하여 저장소에 저장
  Future<void> _saveExpenses() async {
    final jsonStr = jsonEncode(_expenses.map((e) => {
      'id': e.id,
      'title': e.title,
      'amount': e.amount,
      'date': e.date.toIso8601String(),
    }).toList());
    await _storage.saveData(_storageKey, jsonStr);
  }

  // 새로운 지출/수입 항목을 추가하는 다이얼로그 실행
  Future<void> _addNewExpense() async {
    final newExp = await showDialog<Expense>(
      context: context,
      builder: (_) => AddExpenseDialog(), // 금액, 내용 등을 입력하는 다이얼로그
    );
    if (newExp != null) {
      setState(() => _expenses.add(newExp)); // 리스트에 추가
      await _saveExpenses(); // 저장
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 지출/수입 차트를 표시 (막대그래프 또는 기타 시각화 방식)
        Expanded(child: ExpenseChart(expenses: _expenses)),

        // 지출/수입 추가 버튼
        ElevatedButton.icon(
          onPressed: _addNewExpense,
          icon: const Icon(Icons.add),
          label: const Text('새 지출/수입 추가'),
        ),
      ],
    );
  }
}
