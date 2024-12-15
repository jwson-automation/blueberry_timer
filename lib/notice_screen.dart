import 'package:flutter/material.dart';

class NoticeScreen extends StatelessWidget {
  const NoticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('공지사항'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: _dummyNotices.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final notice = _dummyNotices[index];
          return NoticeItem(notice: notice);
        },
      ),
    );
  }
}

class Notice {
  final String title;
  final String content;
  final DateTime date;

  Notice({
    required this.title,
    required this.content,
    required this.date,
  });
}

class NoticeItem extends StatelessWidget {
  final Notice notice;

  const NoticeItem({
    super.key,
    required this.notice,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _showNoticeDetail(context, notice);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notice.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _formatDate(notice.date),
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showNoticeDetail(BuildContext context, Notice notice) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(notice.title),
        content: SingleChildScrollView(
          child: Text(notice.content),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('닫기'),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}';
  }
}

// 더미 데이터
final List<Notice> _dummyNotices = [
  Notice(
    title: '앱 업데이트 안내',
    content: '새로운 기능이 추가되었습니다.\n1. 타이머 기능 개선\n2. UI 개선\n3. 버그 수정',
    date: DateTime(2024, 12, 14),
  ),
  Notice(
    title: '서비스 점검 안내',
    content: '2024년 12월 20일 새벽 2시부터 4시까지 서비스 점검이 있을 예정입니다.',
    date: DateTime(2024, 12, 13),
  ),
  Notice(
    title: '이용 안내',
    content: '블루베리 타이머를 이용해 주셔서 감사합니다. 더 나은 서비스를 제공하도록 하겠습니다.',
    date: DateTime(2024, 12, 10),
  ),
];
