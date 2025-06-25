// widgets/expense_chart.dart
import 'package:flutter/material.dart';
import '../models/expense.dart';

class ExpenseChart extends StatelessWidget {
  final List<Expense> expenses;

  const ExpenseChart({super.key, required this.expenses});

  @override
  Widget build(BuildContext context) {
    double total = expenses.fold(0.0, (sum, e) => sum + e.amount);
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('이번 달 총합', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('${total.toStringAsFixed(0)} 원', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}