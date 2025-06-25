import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = false;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SwitchListTile(
          title: const Text('다크모드'),
          value: isDarkMode,
          onChanged: (value) {
            // TODO: 다크모드 토글 구현
          },
        ),
        const Divider(),
        ListTile(
          title: const Text('데이터 초기화'),
          trailing: const Icon(Icons.delete),
          onTap: () {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('초기화 확인'),
                content: const Text('모든 데이터를 삭제하시겠습니까?'),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(context), child: const Text('취소')),
                  TextButton(onPressed: () {
                    // TODO: 데이터 초기화 로직
                    Navigator.pop(context);
                  }, child: const Text('삭제')),
                ],
              ),
            );
          },
        )
      ],
    );
  }
}
