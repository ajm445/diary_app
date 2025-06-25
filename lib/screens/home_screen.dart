// screens/home_screen.dart
import 'package:diary_app/widgets/AddChecklistDialog.dart';
import 'package:diary_app/widgets/AddExpenseDialog.dart';
import 'package:flutter/material.dart';
import 'calendar_screen.dart';
import 'gallery_screen.dart';
import 'expense_screen.dart';
import 'checklist_screen.dart';
import 'memo_detail_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final PageStorageBucket _bucket = PageStorageBucket();

  final List<Widget> _screens = const [
    CalendarScreen(key: PageStorageKey('calendar')),
    GalleryScreen(key: PageStorageKey('gallery')),
    ExpenseScreen(key: PageStorageKey('expense')),
    ChecklistScreen(key: PageStorageKey('checklist')),
    SettingsScreen(key: PageStorageKey('settings')),
  ];

  final List<String> _titles = [
    '캘린더',
    '메모 업로드',
    '가계부',
    '체크리스트',
    '설정',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onFabPressed() {
  switch (_selectedIndex) {
    case 0:
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => MemoDetailScreen(initialDate: DateTime.now()),
        ),
      );
      break;
    case 1:
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const GalleryScreen(),
        ),
      );
      break;
    case 2:
      showDialog(context: context, builder: (_) => AddExpenseDialog());
      break;
    case 3:
      showDialog(context: context, builder: (_) => AddChecklistDialog());
      break;
    default:
      break;
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
        centerTitle: true,
      ),
      body: PageStorage(
        bucket: _bucket,
        child: _screens[_selectedIndex],
      ),
      floatingActionButton: _selectedIndex < 4
          ? FloatingActionButton(
              onPressed: _onFabPressed,
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
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
