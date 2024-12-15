import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('도움말'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _helpItems.length,
        itemBuilder: (context, index) {
          final help = _helpItems[index];
          return HelpItemWidget(
            help: help,);
        },
      ),
    );
  }
}

class HelpItem {
  final String title;
  final String content;
  final IconData icon;

  const HelpItem({
    required this.title,
    required this.content,
    required this.icon,
  });
}

class HelpItemWidget extends StatelessWidget {
  final HelpItem help;

  const HelpItemWidget({
    super.key,
    required this.help,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: ExpansionTile(
        leading: Icon(help.icon, color: Colors.blue),
        title: Text(
          help.title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              help.content,
              style: const TextStyle(
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final List<HelpItem> _helpItems = [
  HelpItem(
    title: '타이머 사용법',
    content: '1. 시간 설정: 상단의 시간을 터치하여 공부 시간과 휴식 시간을 설정할 수 있습니다.\n\n'
        '2. 시작/정지: 중앙의 큰 버튼을 눌러 타이머를 시작하거나 정지할 수 있습니다.\n\n'
        '3. 초기화: 타이머가 정지된 상태에서 초기화 버튼을 눌러 시간을 리셋할 수 있습니다.',
    icon: Icons.timer,
  ),
  HelpItem(
    title: '아이템 수집',
    content: '공부 시간이 끝날 때마다 랜덤으로 블루베리 아이템을 획득할 수 있습니다.\n\n'
        '획득한 아이템은 마이페이지에서 확인할 수 있습니다.\n\n'
        '특별한 아이템을 모아 컬렉션을 완성해보세요!',
    icon: Icons.card_giftcard,
  ),
  HelpItem(
    title: '배경음악 설정',
    content: '1. 음악 선택: 설정 메뉴에서 원하는 배경음악을 선택할 수 있습니다.\n\n'
        '2. 볼륨 조절: 음악이 재생 중일 때 볼륨 버튼으로 소리 크기를 조절할 수 있습니다.\n\n'
        '3. 음소거: 음악 아이콘을 탭하여 빠르게 음소거할 수 있습니다.',
    icon: Icons.music_note,
  ),
  HelpItem(
    title: '프로필 관리',
    content: '1. 프로필 수정: 마이페이지에서 프로필 이미지와 닉네임을 변경할 수 있습니다.\n\n'
        '2. 통계 확인: 일간/주간/월간 공부 시간 통계를 확인할 수 있습니다.\n\n'
        '3. 목표 설정: 일일 목표 공부 시간을 설정하고 달성 현황을 확인할 수 있습니다.',
    icon: Icons.person,
  ),
  HelpItem(
    title: '알림 설정',
    content: '1. 타이머 알림: 공부/휴식 시간이 끝날 때 알림을 받을 수 있습니다.\n\n'
        '2. 목표 알림: 일일 목표 달성 시 축하 알림을 받을 수 있습니다.\n\n'
        '3. 알림 설정: 설정 메뉴에서 원하는 알림만 선택하여 받을 수 있습니다.',
    icon: Icons.notifications,
  ),
];
