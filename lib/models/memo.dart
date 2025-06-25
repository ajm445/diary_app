// models/memo.dart
class Memo {
  final String id;
  final String content;
  final String? imagePath;
  final DateTime date;

  Memo({
    required this.id,
    required this.content,
    required this.date,
    this.imagePath,
  });

  factory Memo.fromJson(Map<String, dynamic> json) {
    return Memo(
      id: json['id'],
      content: json['content'],
      imagePath: json['imagePath'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'imagePath': imagePath,
      'date': date.toIso8601String(),
    };
  }

  /// 날짜가 연/월/일만 같으면 true
  bool isSameDate(DateTime other) {
    return date.year == other.year &&
        date.month == other.month &&
        date.day == other.day;
  }
}