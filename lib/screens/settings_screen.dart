// 화면: 설정 - 다크모드 토글 및 데이터 초기화 기능을 포함

import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = false; // 현재 다크모드 상태 (TODO: 실제 상태와 연동 필요)

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // 다크모드 ON/OFF 스위치
        SwitchListTile(
          title: const Text('다크모드'),
          value: isDarkMode, // 현재 다크모드 여부
          onChanged: (value) {
            // TODO: 다크모드 토글 구현 필요 (예: Provider, ThemeNotifier 등)
          },
        ),

        const Divider(), // 구분선

        // 데이터 초기화 항목
        ListTile(
          title: const Text('데이터 초기화'),
          trailing: const Icon(Icons.delete), // 삭제 아이콘
          onTap: () {
            // 초기화 확인 다이얼로그 표시
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('초기화 확인'),
                content: const Text('모든 데이터를 삭제하시겠습니까?'),
                actions: [
                  // 취소 버튼 → 다이얼로그 닫기
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('취소'),
                  ),
                  // 삭제 버튼 → 초기화 로직 실행 예정
                  TextButton(
                    onPressed: () {
                      // TODO: 데이터 초기화 로직 작성 (예: SharedPreferences.clear 등)
                      Navigator.pop(context); // 다이얼로그 닫기
                    },
                    child: const Text('삭제'),
                  ),
                ],
              ),
            );
          },
        )
      ],
    );
  }
}
