class MusicModel {
  final bool isPlaying;

  const MusicModel({required this.isPlaying});

  MusicModel copyWith({bool? isPlaying}) {
    return MusicModel(
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }
}
