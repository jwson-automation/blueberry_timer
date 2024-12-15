class RankingEntry {
  final String username;
  final int totalStudyTime;
  final int level;
  final int rank;

  const RankingEntry({
    required this.username,
    required this.totalStudyTime,
    required this.level,
    required this.rank,
  });

  String get formattedStudyTime {
    final hours = totalStudyTime ~/ 60;
    final minutes = totalStudyTime % 60;
    return '${hours}시간 ${minutes}분';
  }
}
