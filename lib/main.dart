import 'package:blueberry_timer/firebase_options.dart';
import 'package:blueberry_timer/l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/timer_screen.dart';
import 'package:blueberry_timer/features/item_service.dart';

/**
 * BlueberryTimer 앱의 메인 엔트리 포인트입니다.
 *
 * 앱의 기본 설정과 전역 상태를 초기화하고,
 * MaterialApp과 필요한 Provider들을 설정합니다.
 *
 * 앱 전체에서 사용되는 테마, 다국어 지원, 네비게이션 등을
 * 이 파일에서 구성합니다.
 */

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const ProviderScope(
      child: BlueberryTimerApp(),
    ),
  );
}

class BlueberryTimerApp extends StatelessWidget {
  const BlueberryTimerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
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
      builder: (context, child) {
        return Scaffold(
          body: child!,
        );
      },
      home: const TimerScreen(),
    );
  }
}
