// 화면: 체크리스트 항목을 추가/삭제/완료 처리할 수 있는 화면

import 'dart:convert'; // JSON 인코딩/디코딩을 위한 패키지
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart'; // 고유 ID 생성을 위한 패키지
import '../models/checklist_item.dart'; // 체크리스트 아이템 모델
import '../services/local_storage_service.dart'; // SharedPreferences를 통한 로컬 저장 서비스
import '../widgets/AddChecklistDialog.dart'; // 항목 추가 다이얼로그 위젯

class ChecklistScreen extends StatefulWidget {
  const ChecklistScreen({Key? key}) : super(key: key);

  @override
  _ChecklistScreenState createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> {
  final LocalStorageService _storage = LocalStorageService(); // 로컬 저장소 서비스 인스턴스
  final List<ChecklistItem> _items = []; // 체크리스트 항목 저장 리스트
  final String _storageKey = 'checklist_items'; // 저장소 키

  @override
  void initState() {
    super.initState();
    _loadChecklist(); // 앱 시작 시 저장된 체크리스트 불러오기
  }

  // 저장소에서 체크리스트 데이터를 불러와 리스트에 적용
  Future<void> _loadChecklist() async {
    final data = await _storage.loadData(_storageKey);
    if (data != null) {
      final List<dynamic> jsonList = jsonDecode(data);
      setState(() {
        _items.clear();
        _items.addAll(jsonList.map((e) => ChecklistItem(
          id: e['id'],
          title: e['title'],
          isDone: e['isDone'],
        )));
      });
    }
  }

  // 현재 체크리스트 항목들을 저장소에 저장
  Future<void> _saveChecklist() async {
    final jsonStr = jsonEncode(_items.map((e) => {
      'id': e.id,
      'title': e.title,
      'isDone': e.isDone,
    }).toList());
    await _storage.saveData(_storageKey, jsonStr);
  }

  // 새로운 체크리스트 항목을 추가
  Future<void> _addNewItem() async {
    final title = await showDialog<String>(
      context: context,
      builder: (_) => const AddChecklistDialog(), // 사용자 입력을 위한 다이얼로그
    );
    if (title != null && title.isNotEmpty) {
      setState(() {
        // 새 항목을 리스트에 추가 (고유 ID 생성 포함)
        _items.add(ChecklistItem(id: const Uuid().v4(), title: title));
      });
      await _saveChecklist(); // 저장
    }
  }

  // 체크 상태 토글 (완료/미완료)
  void _toggleDone(ChecklistItem item) {
    setState(() => item.isDone = !item.isDone);
    _saveChecklist(); // 변경 사항 저장
  }

  // 항목 삭제
  void _removeItem(ChecklistItem item) {
    setState(() => _items.remove(item));
    _saveChecklist(); // 저장소 반영
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _items.length,
        itemBuilder: (_, i) {
          final item = _items[i];
          return Dismissible(
            key: Key(item.id), // 삭제 애니메이션을 위한 고유 키
            onDismissed: (_) => _removeItem(item), // 좌우 스와이프로 삭제
            background: Container(color: Colors.red), // 삭제 배경
            child: CheckboxListTile(
              value: item.isDone, // 체크 상태
              title: Text(item.title), // 항목 제목
              onChanged: (_) => _toggleDone(item), // 체크 상태 변경
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewItem, // 새 항목 추가
        child: const Icon(Icons.add),
      ),
    );
  }
}
