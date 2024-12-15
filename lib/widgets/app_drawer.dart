import 'package:blueberry_timer/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:blueberry_timer/mine_screen.dart';
import 'package:blueberry_timer/widgets/notice_dialog.dart';
import 'package:blueberry_timer/widgets/help_dialog.dart';
import 'package:blueberry_timer/widgets/settings_dialog.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Drawer(
      width: MediaQuery.of(context).size.width / 2,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.cyan.shade700,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  l10n.appName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.appSlogan,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: Text(l10n.menuNotice),
            onTap: () {
              Navigator.pop(context);
              NoticeDialog.show(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(l10n.menuSettings),
            onTap: () {
              Navigator.pop(context);
              SettingsDialog.show(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: Text(l10n.menuHelp),
            onTap: () {
              Navigator.pop(context);
              HelpDialog.show(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.diamond),
            title: Text(l10n.menuMine),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MineScreen()),
              );
            },
          ),
          AboutListTile(
            icon: const Icon(Icons.info_outline),
            applicationName: l10n.appName,
            applicationVersion: l10n.aboutVersion,
            applicationLegalese: l10n.aboutCopyright,
            aboutBoxChildren: [
              Text(l10n.aboutDescription),
              const SizedBox(height: 10),
              Text(l10n.aboutTeam),
            ],
            child: Text(l10n.menuAbout),
          ),
        ],
      ),
    );
  }
}
