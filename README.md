# diary_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

```
lib/
├── main.dart                        # 앱 시작점
│
├── screens/                         # 주요 화면(페이지)
│   ├── calendar_screen.dart         # 📅 캘린더 + 메모 기능
│   ├── memo_detail_screen.dart      # 📝 메모 작성/상세 보기
│   ├── gallery_screen.dart          # 🖼️ 사진 업로드/보기
│   ├── expense_screen.dart          # 💰 가계부 기능
│   └── checklist_screen.dart        # ✅ 체크리스트 기능
│
├── models/                          # 데이터 모델 정의
│   ├── memo.dart
│   ├── expense.dart
│   └── checklist_item.dart
│
├── widgets/                         # 재사용 가능한 위젯
│   ├── calendar_widget.dart
│   ├── memo_tile.dart
│   ├── expense_chart.dart
│   └── checklist_tile.dart
│
└── services/                        # 데이터 처리 및 유틸 서비스
    ├── local_storage_service.dart   # 로컬 저장소 관리
    └── image_picker_service.dart    # 이미지 선택 처리
```
