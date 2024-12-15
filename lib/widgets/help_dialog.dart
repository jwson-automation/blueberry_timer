import 'package:flutter/material.dart';
import 'package:blueberry_timer/l10n/app_localizations.dart';

class HelpDialog extends StatelessWidget {
  const HelpDialog({super.key});

  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const HelpDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return AlertDialog(
      title: Text(l10n.helpTitle),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: _helpItems(l10n).length,
          itemBuilder: (context, index) {
            final help = _helpItems(l10n)[index];
            return HelpItemWidget(help: help);
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.helpClose),
        ),
      ],
    );
  }
}

class HelpItem {
  final String title;
  final String content;

  const HelpItem({
    required this.title,
    required this.content,
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
      margin: const EdgeInsets.only(bottom: 8.0),
      child: ExpansionTile(
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

List<HelpItem> _helpItems(AppLocalizations l10n) => [
  HelpItem(
    title: l10n.helpTimerTitle,
    content: l10n.helpTimerContent,
  ),
  HelpItem(
    title: l10n.helpItemTitle,
    content: l10n.helpItemContent,
  ),
  HelpItem(
    title: l10n.helpMusicTitle,
    content: l10n.helpMusicContent,
  ),
  HelpItem(
    title: l10n.helpProfileTitle,
    content: l10n.helpProfileContent,
  ),
  HelpItem(
    title: l10n.helpNotificationTitle,
    content: l10n.helpNotificationContent,
  ),
];
