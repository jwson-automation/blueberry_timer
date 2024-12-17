import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blueberry_timer/models/music_model.dart';

/**
 * 배경 음악을 관리하는 서비스입니다.
 * 
 * 이 서비스는 다음 기능들을 제공합니다:
 * - 공부/휴식 시간에 따른 배경음악 재생
 * - 음악 재생, 일시정지, 정지
 * - 볼륨 조절
 * 
 * 각 상태(공부/휴식)에 맞는 음악을 자동으로 전환하여 재생하며,
 * 사용자가 원할 때 음악을 끄거나 켤 수 있습니다.
 */

// 뮤직 서비스 프로바이더 : 뮤직 서비스를 제공
final musicServiceProvider =
    StateNotifierProvider.autoDispose<MusicService, MusicModel>((ref) {
  return MusicService();
});

class MusicService extends StateNotifier<MusicModel> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  static const String backgroundMusicPath =
      'music/Silent Night - The Soundlings.mp3';

  MusicService() : super(MusicModel(isPlaying: false)) {
    // 추가 설정
    _audioPlayer.setReleaseMode(ReleaseMode.loop); // 반복 재생
    _audioPlayer.setPlayerMode(PlayerMode.mediaPlayer); // 고품질 모드
  }

  Future<void> playMusic() async {
    if (!state.isPlaying) {
      // 버퍼링 시간 추가
      await _audioPlayer.play(
        AssetSource(backgroundMusicPath),
        mode: PlayerMode.mediaPlayer,
      );
      state = state.copyWith(isPlaying: true);
    }
  }

  Future<void> pauseMusic() async {
    if (state.isPlaying) {
      await _audioPlayer.pause();
      state = state.copyWith(isPlaying: false);
    }
  }

  Future<void> resumeMusic() async {
    if (!state.isPlaying) {
      await _audioPlayer.resume();
      state = state.copyWith(isPlaying: true);
    }
  }

  Future<void> stopMusic() async {
    await _audioPlayer.stop();
    state = state.copyWith(isPlaying: false);
  }

  Future<void> setVolume(double volume) async {
    await _audioPlayer.setVolume(volume);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
