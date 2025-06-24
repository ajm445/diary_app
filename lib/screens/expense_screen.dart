// screens/expense_screen.dart
import 'package:flutter/material.dart';

class ExpenseScreen extends StatelessWidget {
  const ExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('가계부')),
      body: const Center(child: Text('가계부 화면')),
    );
  }
}