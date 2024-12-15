import 'package:blueberry_timer/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class NoticeDialog extends StatelessWidget {
  const NoticeDialog({super.key});

  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const NoticeDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    
    if (l10n == null) {
      return const SizedBox();
    }
    
    return AlertDialog(
      title: Text(l10n.noticeTitle),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: _notices(l10n).length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            final notice = _notices(l10n)[index];
            return NoticeItemWidget(notice: notice);
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.noticeClose),
        ),
      ],
    );
  }
}

class Notice {
  final String title;
  final String content;
  final DateTime date;

  const Notice({
    required this.title,
    required this.content,
    required this.date,
  });
}

class NoticeItemWidget extends StatelessWidget {
  final Notice notice;

  const NoticeItemWidget({
    super.key,
    required this.notice,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showNoticeDetail(context),
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

  void _showNoticeDetail(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (l10n == null) {
      return;
    }
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(notice.title),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _formatDate(notice.date),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 16),
              Text(notice.content),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.noticeClose),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}';
  }
}

List<Notice> _notices(AppLocalizations l10n) => [
  Notice(
    title: l10n.noticeAppUpdate,
    content: l10n.noticeAppUpdateContent,
    date: DateTime(2024, 12, 14),
  ),
  Notice(
    title: l10n.noticeServiceCheck,
    content: l10n.noticeServiceCheckContent,
    date: DateTime(2024, 12, 13),
  ),
  Notice(
    title: l10n.noticeWelcome,
    content: l10n.noticeWelcomeContent,
    date: DateTime(2024, 12, 10),
  ),
];
