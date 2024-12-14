import 'package:blueberry_timer/features/item_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'features/timer_service.dart';
import 'features/music_service.dart';
import 'features/lottie_service.dart';
import 'package:blueberry_timer/widgets/item_dialog.dart';
import 'package:blueberry_timer/widgets/app_drawer.dart';
import 'package:blueberry_timer/widgets/user_profile_dialog.dart';
import 'package:blueberry_timer/features/user_service.dart';

class TimerScreen extends ConsumerStatefulWidget {
  const TimerScreen({super.key});

  @override
  TimerScreenState createState() => TimerScreenState();
}

class TimerScreenState extends ConsumerState<TimerScreen>
    with SingleTickerProviderStateMixin {
  bool _wasStudyPhase = true; // 이전 상태 저장용
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // ScaffoldState를 관리하기 위한 글로벌 키 추가

  @override
  void initState() {
    super.initState();
    ref.read(lottieServiceProvider.notifier).initController(this);
  }

  @override
  Widget build(BuildContext context) {
    // Watching states
    final timerState = ref.watch(timerServiceProvider);
    final musicState = ref.watch(musicServiceProvider);
    final lottieState = ref.watch(lottieServiceProvider);
    final itemState = ref.watch(itemServiceProvider);
    final userProfile = ref.watch(userServiceProvider).profile;

    // Notifiers
    final timerNotifier = ref.read(timerServiceProvider.notifier);
    final musicNotifier = ref.read(musicServiceProvider.notifier);
    final lottieNotifier = ref.read(lottieServiceProvider.notifier);
    final itemNotifier = ref.read(itemServiceProvider.notifier);

    // Check if timer is completed to collect random item
    if (_wasStudyPhase && !timerState.isStudyPhase) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // 공부 시간 업데이트
        final studyTimeInMinutes = timerState.studyTime;
        ref.read(userServiceProvider.notifier).addTotalStudyTime(studyTimeInMinutes);
        ref.read(userServiceProvider.notifier).addExperience(studyTimeInMinutes);
        
        // 아이템 수집
        itemNotifier.collectRandomItem();
        
        // 로티 애니메이션 변경
        ref.read(lottieServiceProvider.notifier).setPhase(false);
      });
    } else if (!_wasStudyPhase && timerState.isStudyPhase) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // 로티 애니메이션 변경
        ref.read(lottieServiceProvider.notifier).setPhase(true);
      });
    }
    _wasStudyPhase = timerState.isStudyPhase;

    // Use a post-frame callback to handle animation state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (timerState.isRunning && !lottieState.isAnimating) {
        lottieNotifier.startAnimation();
      } else if (!timerState.isRunning && lottieState.isAnimating) {
        lottieNotifier.stopAnimation();
      }
    });

    return Scaffold(
      key: _scaffoldKey, // ScaffoldState를 관리하기 위한 글로벌 키 추가
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: CircleAvatar(
            backgroundColor: userProfile.primaryColor.withOpacity(0.2),
            child: Icon(
              Icons.person,
              color: userProfile.primaryColor,
            ),
          ),
          onPressed: () => showUserProfileDialog(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer(); // 드로어 열기
            },
          ),
        ],
      ),
      endDrawer: const AppDrawer(), // 별도의 위젯으로 분리된 드로어
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Top section with timer and animation
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Lottie Animation
                SizedBox(
                  width: 200,
                  height: 200,
                  child: Lottie.asset(
                    lottieState.currentAnimation,
                    controller: lottieNotifier.controller,
                    fit: BoxFit.cover,
                  ),
                ),

                // Timer Display
                Text(
                  timerNotifier.formatTime(),
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color:
                        timerState.isStudyPhase ? Colors.cyan : Colors.orange,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: timerState.isStudyPhase
                            ? Colors.cyan
                            : Colors.orange,
                        offset: const Offset(0, 0),
                      )
                    ],
                  ),
                ),

                // Phase Indicator
                Text(
                  timerState.isStudyPhase ? 'Study Time' : 'Rest Time',
                  style: TextStyle(
                    fontSize: 20,
                    color:
                        timerState.isStudyPhase ? Colors.cyan : Colors.orange,
                  ),
                ),

                const SizedBox(height: 30),

                // Control Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Timer Control Buttons
                    _buildNeonButton(
                      icon:
                          timerState.isRunning ? Icons.pause : Icons.play_arrow,
                      color: Colors.green,
                      onPressed: timerState.isRunning
                          ? timerNotifier.stopTimer
                          : timerNotifier.startTimer,
                    ),
                    const SizedBox(width: 20),
                    _buildNeonButton(
                      icon: Icons.restart_alt,
                      color: Colors.red,
                      onPressed: () {
                        timerNotifier.resetTimer();
                        lottieNotifier.resetAnimation();
                      },
                    ),
                    const SizedBox(width: 20),
                    // Music Control Button
                    _buildNeonButton(
                      icon: musicState.isPlaying
                          ? Icons.music_note
                          : Icons.music_off,
                      color: Colors.purple,
                      onPressed: musicState.isPlaying
                          ? musicNotifier.pauseMusic
                          : musicNotifier.playMusic,
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Item Grid
          const Text(
            'Collected Items',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1,
            ),
            itemCount: 10,
            // Always show 10 slots
            itemBuilder: (context, index) {
              // Check if this index has a collected item
              final item = index < itemState.collectedItems.length
                  ? itemState.collectedItems[index]
                  : null;

              return GestureDetector(
                onTap: item != null 
                  ? () {
                      showDialog(
                        context: context,
                        builder: (context) => ItemDialog(item: item),
                      );
                    }
                  : null,
                child: Container(
                  decoration: BoxDecoration(
                    color: item?.backgroundColor ?? Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: item != null
                          ? Colors.green.shade300
                          : Colors.grey.shade400,
                      width: 2,
                    ),
                  ),
                  child: item != null
                      ? Stack(
                          children: [
                            Center(
                              child: SvgPicture.asset(
                                item.imagePath,
                                width: 50,
                                height: 50,
                              ),
                            ),
                            if (item.quantity > 1)
                              Positioned(
                                right: 4,
                                bottom: 4,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.black54,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    '${item.quantity}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        )
                      : const Center(
                          child: Icon(
                            Icons.add_circle_outline,
                            color: Colors.grey,
                          ),
                        ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNeonButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.5),
            blurRadius: 15,
            spreadRadius: 2,
          )
        ],
        borderRadius: BorderRadius.circular(50),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(15),
        ),
        onPressed: onPressed,
        child: Icon(icon, size: 30, color: Colors.white),
      ),
    );
  }
}
