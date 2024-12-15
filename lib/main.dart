import 'package:blueberry_timer/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'timer_screen.dart';
import 'package:blueberry_timer/features/item_service.dart';
import 'package:blueberry_timer/features/message_service.dart';

// 앱이 시작되는 지점
void main() {
  runApp(
    const ProviderScope(child: BlueberryTimerApp()),
  );
}

// 앱의 루트 위젯
class BlueberryTimerApp extends StatelessWidget {
  const BlueberryTimerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final messageState = ref.watch(messageServiceProvider);
        return MaterialApp(
          navigatorKey: messageState.navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: Colors.black,
          ),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'), // English
            Locale('ko'), // Korean
          ],
          home: const TimerScreen(),
        );
      },
    );
  }
}
