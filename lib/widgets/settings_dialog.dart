import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blueberry_timer/l10n/app_localizations.dart';

class SettingsDialog extends ConsumerWidget {
  const SettingsDialog({super.key});

  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const SettingsDialog(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    
    return AlertDialog(
      title: Text(l10n.settingsTitle),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionTitle(title: l10n.settingsTimerSection),
            _SettingSwitch(
              title: l10n.settingsAutoStart,
              subtitle: l10n.settingsAutoStartDesc,
              value: false, // TODO: Implement provider
              onChanged: (value) {
                // TODO: Implement provider
              },
            ),
            const SizedBox(height: 16),
            _SectionTitle(title: l10n.settingsNotificationSection),
            _SettingSwitch(
              title: l10n.settingsTimerNotification,
              subtitle: l10n.settingsTimerNotificationDesc,
              value: false, // TODO: Implement provider
              onChanged: (value) {
                // TODO: Implement provider
              },
            ),
            _SettingSwitch(
              title: l10n.settingsVibration,
              subtitle: l10n.settingsVibrationDesc,
              value: false, // TODO: Implement provider
              onChanged: (value) {
                // TODO: Implement provider
              },
            ),
            const SizedBox(height: 16),
            _SectionTitle(title: l10n.settingsSoundSection),
            _SettingSwitch(
              title: l10n.settingsSoundEffect,
              subtitle: l10n.settingsSoundEffectDesc,
              value: false, // TODO: Implement provider
              onChanged: (value) {
                // TODO: Implement provider
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.settingsBgmVolume,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l10n.settingsBgmVolumeDesc,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  Slider(
                    value: 0.5, // TODO: Implement provider
                    onChanged: (value) {
                      // TODO: Implement provider
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.settingsClose),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _SettingSwitch extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SettingSwitch({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: onChanged,
    );
  }
}
