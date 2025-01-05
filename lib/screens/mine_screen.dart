import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:blueberry_timer/features/mine_lottie_service.dart';
import 'package:blueberry_timer/features/user_service.dart';
import 'package:blueberry_timer/features/pickaxe_service.dart';
import 'package:blueberry_timer/widgets/current_money_widget.dart';

class MineScreen extends ConsumerStatefulWidget {
  const MineScreen({super.key});

  @override
  ConsumerState<MineScreen> createState() => _MineScreenState();
}

class _MineScreenState extends ConsumerState<MineScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // 애니메이션 컨트롤러 초기화를 비동기로 수행
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(mineLottieServiceProvider.notifier).initController(this);
    });
  }

  @override
  void dispose() {
    ref.read(mineLottieServiceProvider.notifier).dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mineLottieState = ref.watch(mineLottieServiceProvider);
    final pickaxe = ref.watch(pickaxeServiceProvider);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          '광산',
          style: TextStyle(
            color: Colors.cyan,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                blurRadius: 10.0,
                color: Colors.cyan,
                offset: Offset(0, 0),
              )
            ],
          ),
        ),
        actions: const [
          CurrentMoneyWidget(),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 로티 애니메이션
            SizedBox(
              width: 200,
              height: 200,
              child: mineLottieState.controller != null
                  ? Lottie.asset(
                      'assets/lottie/study.json', // 채굴 관련 로티 애니메이션
                      controller: mineLottieState.controller,
                      fit: BoxFit.cover,
                    )
                  : const SizedBox.shrink(),
            ),

            const SizedBox(height: 30),

            // 현재 곡괭이 정보
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.build,
                    size: 48,
                    color: Colors.brown[700],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Lv.${pickaxe.level} 곡괭이',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    pickaxe.rewardDescription,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // 업그레이드 버튼
            ElevatedButton.icon(
              icon: const Icon(Icons.upgrade),
              label: Text(pickaxe.upgradeDescription),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
              ),
              onPressed: () {
                final userService = ref.read(userServiceProvider.notifier);
                final userProfile = ref.read(userServiceProvider);
                if (userProfile.profile.money >= pickaxe.upgradeCost) {
                  userService.useMoney(pickaxe.upgradeCost);
                  ref.read(pickaxeServiceProvider.notifier).upgrade();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('곡괭이가 업그레이드되었습니다! '),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('돈이 부족합니다 '),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
