// 화면: 캘린더에서 날짜를 선택하고 해당 날짜의 메모를 확인/추가하는 화면

import 'dart:io'; // 로컬 이미지 파일을 불러오기 위한 패키지
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart'; // 캘린더 UI를 위한 패키지
import '/services/memo_service.dart'; // 메모 저장/불러오기 로직을 포함한 서비스
import '../models/memo.dart'; // 메모 모델 클래스
import 'memo_detail_screen.dart'; // 메모 상세 작성 화면

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  // 현재 캘린더에서 보여주는 날짜
  DateTime _focusedDay = DateTime.now();

  // 현재 선택된 날짜 (메모를 보여줄 기준 날짜)
  DateTime _selectedDay = DateTime.now();

  // 선택된 날짜의 메모 목록
  List<Memo> _memos = [];

  // 메모 데이터 관리 서비스
  final MemoService _memoService = MemoService();

  @override
  void initState() {
    super.initState();
    _loadMemosForDay(_selectedDay); // 초기 선택된 날짜의 메모 불러오기
  }

  // 특정 날짜에 대한 메모들을 불러오고 상태를 갱신
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
          // 날짜 선택 가능한 테이블 캘린더 위젯
          TableCalendar(
            focusedDay: _focusedDay,
            firstDay: DateTime(2000), // 캘린더의 시작 날짜
            lastDay: DateTime(2100),  // 캘린더의 종료 날짜
            selectedDayPredicate: (day) =>
                // 선택된 날짜인지 확인
                day.year == _selectedDay.year &&
                day.month == _selectedDay.month &&
                day.day == _selectedDay.day,
            onDaySelected: (selected, focused) {
              // 날짜를 선택했을 때 상태 갱신 및 메모 로드
              _focusedDay = focused;
              _loadMemosForDay(selected);
            },
          ),
          const SizedBox(height: 8),

          // 선택한 날짜의 메모를 보여주는 영역
          Expanded(
            child: _memos.isEmpty
                ? const Center(child: Text('메모가 없습니다.')) // 메모 없을 때 메시지
                : ListView.builder(
                    itemCount: _memos.length,
                    itemBuilder: (_, i) {
                      final memo = _memos[i];
                      return ListTile(
                        title: Text(memo.content), // 메모 본문
                        subtitle: Text(memo.date.toIso8601String()), // 저장된 날짜 (시간 포함)
                        leading: memo.imagePath != null
                            // 이미지가 있다면 왼쪽에 표시
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

      // 메모 추가 버튼
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // 메모 작성 화면으로 이동 (선택된 날짜 전달)
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => MemoDetailScreen(initialDate: _selectedDay),
            ),
          );
          if (result == true) {
            // 메모 저장 후 되돌아오면 다시 목록 로드
            _loadMemosForDay(_selectedDay);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}