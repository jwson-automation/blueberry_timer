class TimerState {
  final int currentTime;
  final bool isRunning;
  final bool isStudyPhase;
  final int studyTime;  // 설정된 공부 시간

  const TimerState({
    required this.currentTime,
    required this.isRunning,
    required this.isStudyPhase,
    required this.studyTime,
  });

  TimerState copyWith({
    int? currentTime,
    bool? isRunning,
    bool? isStudyPhase,
    int? studyTime,
  }) {
    return TimerState(
      currentTime: currentTime ?? this.currentTime,
      isRunning: isRunning ?? this.isRunning,
      isStudyPhase: isStudyPhase ?? this.isStudyPhase,
      studyTime: studyTime ?? this.studyTime,
    );
  }
}
