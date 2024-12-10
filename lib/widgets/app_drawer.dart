import 'package:flutter/material.dart';
import 'package:blueberry_timer/mine_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width / 2, // 화면 너비의 절반으로 조정
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.cyan.shade700,
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Blueberry Timer',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '공부의 시간을 더욱 효율적으로',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('공지사항'),
            onTap: () {
              // 설정 화면으로 이동
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('설정'),
            onTap: () {
              // 설정 화면으로 이동
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.diamond),
            title: const Text('광산'),
            onTap: () {
              // 광산 화면으로 이동
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MineScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text('도움말'),
            onTap: () {
              // 도움말 화면으로 이동
              Navigator.pop(context);
            },
          ),
          AboutListTile(
            icon: const Icon(Icons.info_outline),
            applicationName: 'Blueberry Timer',
            applicationVersion: '1.0.0',
            applicationIcon: Image.asset(
              'assets/icon/app_icon.png', // 앱 아이콘 경로 추가 필요
              width: 50,
              height: 50,
            ),
            applicationLegalese: ' 2024 Blueberry Timer Team',
            aboutBoxChildren: const [
              Text('효율적인 공부 시간 관리를 위한 앱입니다.'),
              SizedBox(height: 10),
              Text(' 2024 Blueberry Timer Team'),
            ],
          ),
        ],
      ),
    );
  }
}
