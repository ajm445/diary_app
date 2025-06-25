// screens/calendar_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '/services/memo_service.dart';
import '../models/memo.dart';
import 'memo_detail_screen.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  List<Memo> _memos = [];
  final MemoService _memoService = MemoService();

  @override
  void initState() {
    super.initState();
    _loadMemosForDay(_selectedDay);
  }

  Future<void> _loadMemosForDay(DateTime day) async {
    final memos = await _memoService.getMemosByDate(day);
    setState(() {
      _selectedDay = day;
      _memos = memos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('캘린더')),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: _focusedDay,
            firstDay: DateTime(2000),
            lastDay: DateTime(2100),
            selectedDayPredicate: (day) =>
                day.year == _selectedDay.year &&
                day.month == _selectedDay.month &&
                day.day == _selectedDay.day,
            onDaySelected: (selected, focused) {
              _focusedDay = focused;
              _loadMemosForDay(selected);
            },
          ),
          const SizedBox(height: 8),
          Expanded(
            child: _memos.isEmpty
                ? const Center(child: Text('메모가 없습니다.'))
                : ListView.builder(
                    itemCount: _memos.length,
                    itemBuilder: (_, i) {
                      final memo = _memos[i];
                      return ListTile(
                        title: Text(memo.content),
                        subtitle: Text(memo.date.toIso8601String()),
                        leading: memo.imagePath != null
                            ? Image.file(
                                File(memo.imagePath!),
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              )
                            : null,
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => MemoDetailScreen(initialDate: _selectedDay),
            ),
          );
          if (result == true) {
            _loadMemosForDay(_selectedDay); // 저장 후 새로고침
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}