// services/memo_service.dart
import 'dart:convert';
import 'package:uuid/uuid.dart';
import '../models/memo.dart';
import 'local_storage_service.dart';

class MemoService {
  final _storage = LocalStorageService();
  static const _key = 'memos';

  Future<List<Memo>> getAllMemos() async {
    final raw = await _storage.loadData(_key);
    if (raw == null) return [];
    final List list = jsonDecode(raw);
    return list.map((j) => Memo.fromJson(j)).toList();
  }

  Future<List<Memo>> getMemosByDate(DateTime date) async {
    final all = await getAllMemos();
    return all.where((m) =>
      m.date.year == date.year &&
      m.date.month == date.month &&
      m.date.day == date.day
    ).toList();
  }

  Future<void> addMemo({
    required String content,
    String? imagePath,
    DateTime? date,
  }) async {
    final all = await getAllMemos();
    final memo = Memo(
      id: Uuid().v4(),
      date: date ?? DateTime.now(),
      content: content,
      imagePath: imagePath,
    );
    all.add(memo);
    final encoded = jsonEncode(all.map((m) => m.toJson()).toList());
    await _storage.saveData(_key, encoded);
  }
}
