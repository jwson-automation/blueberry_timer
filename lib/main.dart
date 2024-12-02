import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'timer_screen.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const TimerScreen(),
    );
  }
}
