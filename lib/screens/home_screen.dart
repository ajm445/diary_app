// 홈 화면: 하단 탭 네비게이션으로 기능별 화면 전환, FAB로 탭에 맞는 추가 기능 수행

import 'package:diary_app/widgets/AddChecklistDialog.dart'; // 체크리스트 추가 다이얼로그
import 'package:diary_app/widgets/AddExpenseDialog.dart';   // 지출 추가 다이얼로그
import 'package:flutter/material.dart';
import 'calendar_screen.dart';       // 캘린더 화면
import 'gallery_screen.dart';        // 사진 업로드(갤러리) 화면
import 'expense_screen.dart';        // 가계부 화면
import 'checklist_screen.dart';      // 체크리스트 화면
import 'memo_detail_screen.dart';    // 메모 작성 화면
import 'settings_screen.dart';       // 설정 화면

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // 현재 선택된 탭 인덱스
  final PageStorageBucket _bucket = PageStorageBucket(); // 각 화면 상태 저장을 위한 버킷

  // 각 탭에 연결된 화면들 (PageStorageKey를 통해 상태 유지)
  final List<Widget> _screens = const [
    CalendarScreen(key: PageStorageKey('calendar')),
    GalleryScreen(key: PageStorageKey('gallery')),
    ExpenseScreen(key: PageStorageKey('expense')),
    ChecklistScreen(key: PageStorageKey('checklist')),
    SettingsScreen(key: PageStorageKey('settings')),
  ];

  // 앱바에 표시할 탭 제목
  final List<String> _titles = [
    '캘린더',
    '메모 업로드',
    '가계부',
    '체크리스트',
    '설정',
  ];

  // 하단 네비게이션 탭 클릭 시 인덱스 갱신
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // FAB 버튼 동작 정의: 탭마다 다른 기능 수행
  void _onFabPressed() {
    switch (_selectedIndex) {
      case 0:
        // 캘린더 탭: 메모 작성 화면으로 이동
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MemoDetailScreen(initialDate: DateTime.now()),
          ),
        );
        break;
      case 1:
        // 메모(갤러리) 탭: 다시 갤러리 화면으로 이동 (실제 사진 업로드 기능 확장 가능)
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const GalleryScreen(),
          ),
        );
        break;
      case 2:
        // 가계부 탭: 지출/수입 추가 다이얼로그 표시
        showDialog(context: context, builder: (_) => AddExpenseDialog());
        break;
      case 3:
        // 체크리스트 탭: 체크리스트 항목 추가 다이얼로그 표시
        showDialog(context: context, builder: (_) => AddChecklistDialog());
        break;
      default:
        // 설정 탭 등은 FAB 비활성화
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 상단 앱바 제목
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]), // 현재 탭 제목
        centerTitle: true,
      ),

      // 현재 선택된 화면 표시 (상태 유지용 PageStorage 사용)
      body: PageStorage(
        bucket: _bucket,
        child: _screens[_selectedIndex],
      ),

      // FAB: 설정 탭(4번) 이외의 탭에서만 표시
      floatingActionButton: _selectedIndex < 4
          ? FloatingActionButton(
              onPressed: _onFabPressed, // 탭에 따라 기능 실행
              child: const Icon(Icons.add),
            )
          : null,

      // 하단 탭 네비게이션 바
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped, // 탭 전환
        selectedItemColor: Colors.indigo, // 선택된 탭 색상
        unselectedItemColor: Colors.grey, // 미선택 탭 색상
        type: BottomNavigationBarType.fixed, // 고정형 탭
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: '캘린더'),
          BottomNavigationBarItem(icon: Icon(Icons.photo_library), label: '메모'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: '가계부'),
          BottomNavigationBarItem(icon: Icon(Icons.checklist), label: '체크리스트'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: '설정'),
        ],
      ),
    );
  }
}
