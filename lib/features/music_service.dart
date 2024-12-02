import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 뮤직 스테이트 : 음악의 상태를 나타냄
class MusicState {
  final bool isPlaying;

  MusicState({required this.isPlaying});

  MusicState copyWith({bool? isPlaying}) {
    return MusicState(
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }
}

// 뮤직 서비스 프로바이더 : 뮤직 서비스를 제공
final musicServiceProvider =
    StateNotifierProvider.autoDispose<MusicService, MusicState>((ref) {
  return MusicService();
});

class MusicService extends StateNotifier<MusicState> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  static const String backgroundMusicPath =
      'music/Silent Night - The Soundlings.mp3';

  MusicService() : super(MusicState(isPlaying: false)) {
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
