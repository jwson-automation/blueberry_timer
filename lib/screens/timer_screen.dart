import 'package:blueberry_timer/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blueberry_timer/dialogs/user_profile_dialog.dart';
import 'package:blueberry_timer/features/item_service.dart';
import 'package:blueberry_timer/features/lottie_service.dart';
import 'package:blueberry_timer/features/message_service.dart';
import 'package:blueberry_timer/features/pickaxe_service.dart';
import 'package:blueberry_timer/features/timer_service.dart';
import 'package:blueberry_timer/features/user_service.dart';
import 'package:blueberry_timer/widgets/app_drawer.dart';
import 'package:blueberry_timer/widgets/current_money_widget.dart';
import 'package:blueberry_timer/widgets/current_rank_widget.dart';
import 'package:blueberry_timer/widgets/timer/control_buttons.dart';
import 'package:blueberry_timer/widgets/timer/equipped_items.dart';
import 'package:blueberry_timer/widgets/timer/timer_display.dart';
import 'package:blueberry_timer/models/message_info.dart';

/// 타이머 화면
class TimerScreen extends ConsumerStatefulWidget {
  const TimerScreen({super.key});

  @override
  ConsumerState<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends ConsumerState<TimerScreen>
    with SingleTickerProviderStateMixin {
  bool _wasStudyPhase = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    ref.read(lottieServiceProvider.notifier).initController(this);
  }

  @override
  Widget build(BuildContext context) {
    final timerState = ref.watch(timerServiceProvider);
    final itemNotifier = ref.read(itemServiceProvider.notifier);
    final messageService = ref.read(messageServiceProvider);
    final lottieState = ref.watch(lottieServiceProvider);
    final lottieNotifier = ref.read(lottieServiceProvider.notifier);
    final userState = ref.watch(userProvider);
    final userNotifier = ref.read(userProvider.notifier);

    // Check if timer is completed to collect random item
    if (_wasStudyPhase && !timerState.isStudyPhase) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // 공부 시간 업데이트
        final studyTimeInMinutes = timerState.studyTime;
        ref
            .read(userServiceProvider.notifier)
            .addTotalStudyTime(studyTimeInMinutes);
        ref
            .read(userServiceProvider.notifier)
            .addExperience(studyTimeInMinutes);

        // 경험치 업데이트 (1분당 10 경험치)
        final experienceGained = studyTimeInMinutes * 10;
        final newExperience = userState.experience + experienceGained;

        // 새로운 레벨 계산 (100 경험치당 1레벨)
        final newLevel = (newExperience / 100).floor() + 1;

        // 경험치와 레벨 업데이트
        userNotifier.updateExperience(newExperience);
        if (newLevel != userState.level) {
          userNotifier.updateLevel(newLevel);
          // 레벨업 메시지 표시
          messageService.showMessage(
            context,
            message: '축하합니다! 레벨 ${newLevel}이 되었습니다.',
            backgroundColor: Colors.green.shade700,
          );
        }

        // 곡괭이 레벨에 따른 보상 지급
        final reward = ref.read(pickaxeServiceProvider).baseReward;
        ref.read(userServiceProvider.notifier).addMoney(reward);

        // 아이템 획득 로직
        itemNotifier.collectRandomItem();

        // 로티 애니메이션 변경
        lottieNotifier.setPhase(false);
      });
    } else if (!_wasStudyPhase && timerState.isStudyPhase) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // 로티 애니메이션 변경
        lottieNotifier.setPhase(true);
      });
    }
    _wasStudyPhase = timerState.isStudyPhase;

    // 로티 애니메이션 상태 관리
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (timerState.isRunning && !lottieState.isAnimating) {
        lottieNotifier.startAnimation();
      } else if (!timerState.isRunning && lottieState.isAnimating) {
        lottieNotifier.stopAnimation();
      }
    });

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const CircleAvatar(
            backgroundColor: Colors.blue,
            child: Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
          onPressed: () => showUserProfileDialog(context),
        ),
        actions: [
          const CurrentRankWidget(),
          const CurrentMoneyWidget(),
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer();
            },
          ),
        ],
      ),
      endDrawer: const AppDrawer(),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 100),
            child: Column(
              children: [
                TimerDisplay(),
                SizedBox(height: 30),
                ControlButtons(),
                SizedBox(height: 20),
                EquippedItems(),
              ],
            ),
          ),
          // 메시지 오버레이
          Positioned(
            top: MediaQuery.of(context).size.height * 0.02,
            left: 0,
            right: 0,
            child: ValueListenableBuilder<MessageInfo?>(
              valueListenable: messageService.messageNotifier,
              builder: (context, messageInfo, child) {
                if (messageInfo == null) return const SizedBox.shrink();

                return AnimatedOpacity(
                  opacity: messageInfo != null ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: messageInfo.backgroundColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: messageInfo.backgroundColor.withOpacity(0.3),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Text(
                      messageInfo.message,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _onRandomItemCollected(BuildContext context, ItemService itemService,
      MessageService messageService) {
    final message = itemService.collectRandomItem();
    if (message != null) {
      messageService.showSuccess(context, message);
    } else {
      messageService.showWarning(context, '아이템이 없어요!');
    }
  }
}
