import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:blueberry_timer/features/mine_service.dart';
import 'package:blueberry_timer/features/mine_lottie_service.dart';

class MineScreen extends ConsumerStatefulWidget {
  const MineScreen({super.key});

  @override
  ConsumerState<MineScreen> createState() => _MineScreenState();
}

class _MineScreenState extends ConsumerState<MineScreen> with SingleTickerProviderStateMixin {
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
    final mineState = ref.watch(mineServiceProvider);
    final mineService = ref.read(mineServiceProvider.notifier);
    final mineLottieState = ref.watch(mineLottieServiceProvider);

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
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 에너지 및 레벨 정보
          _buildEnergyAndLevelSection(mineState),

          const SizedBox(height: 30),

          // 로티 애니메이션
          SizedBox(
            width: 200,
            height: 200,
            child: mineLottieState.controller != null
                ? Lottie.asset(
                    'assets/lottie/pig.json', // 채굴 관련 로티 애니메이션
                    controller: mineLottieState.controller,
                    fit: BoxFit.cover,
                  )
                : const SizedBox.shrink(),
          ),

          const SizedBox(height: 30),

          // 광산 버튼
          GestureDetector(
            onTap: () {
              final minedResource = mineService.mine();
              if (minedResource != null) {
                _showMiningResultDialog(context, minedResource);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('에너지가 부족합니다!')),
                );
              }
            },
            child: Container(
              width: 150,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.cyan.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.cyan.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  '수동 채굴',
                  style: TextStyle(
                    color: Colors.cyan,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),

          // 수집된 자원 목록
          _buildCollectedResourcesSection(mineState),

          const SizedBox(height: 20),

          // 업그레이드 버튼
          _buildUpgradeSection(mineState, mineService),
        ],
      ),
    );
  }

  Widget _buildEnergyAndLevelSection(MineState mineState) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text(
                '에너지',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 16,
                ),
              ),
              Text(
                '${mineState.currentEnergy} / ${mineState.energyLevel * 100}',
                style: TextStyle(
                  color: mineState.currentEnergy > 50 ? Colors.green : Colors.red,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                '곡괭이 레벨',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 16,
                ),
              ),
              Text(
                '${mineState.pickaxeLevel}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCollectedResourcesSection(MineState mineState) {
    return Container(
      height: 100,
      color: Colors.transparent,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: mineState.collectedResources.length,
        itemBuilder: (context, index) {
          final resource = mineState.collectedResources[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.asset(
                  resource.imagePath,
                  width: 50,
                  height: 50,
                  color: Colors.white,
                ),
                Text(
                  resource.name,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildUpgradeSection(MineState mineState, MineService mineService) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNeonButton(
            icon: Icons.upgrade,
            color: Colors.green,
            onPressed: mineState.pickaxeLevel < 5 
              ? () => mineService.upgradePickaxe() 
              : null,
            label: '곡괭이 업그레이드',
          ),
          _buildNeonButton(
            icon: Icons.battery_charging_full,
            color: Colors.blue,
            onPressed: mineState.energyLevel < 5 
              ? () => mineService.upgradeEnergy() 
              : null,
            label: '에너지 업그레이드',
          ),
          _buildNeonButton(
            icon: Icons.restore,
            color: Colors.purple,
            onPressed: () => mineService.restoreEnergy(),
            label: '에너지 회복',
          ),
        ],
      ),
    );
  }

  Widget _buildNeonButton({
    required IconData icon,
    required Color color,
    required VoidCallback? onPressed,
    required String label,
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
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
        onPressed: onPressed,
        child: Column(
          children: [
            Icon(icon, size: 30, color: Colors.white),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMiningResultDialog(BuildContext context, MineResource resource) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        title: Text(
          '채굴 성공!',
          style: TextStyle(
            color: Colors.cyan,
            shadows: [
              Shadow(
                blurRadius: 10.0,
                color: Colors.cyan,
                offset: const Offset(0, 0),
              )
            ],
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              resource.imagePath,
              width: 100,
              height: 100,
              color: Colors.white,
            ),
            Text(
              '${resource.name} 획득!',
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              '가치: ${resource.baseValue} 포인트',
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              '확인',
              style: TextStyle(color: Colors.cyan),
            ),
          ),
        ],
      ),
    );
  }
}
