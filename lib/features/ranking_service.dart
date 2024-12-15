import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/ranking_model.dart';

final rankingServiceProvider = Provider<RankingService>((ref) => RankingService());

class RankingService {
  // 임시 데이터로 랭킹 생성
  List<RankingEntry> getRankings() {
    final List<RankingEntry> rankings = [
      RankingEntry(
        username: '블루베리',
        totalStudyTime: 480,  // 8시간
        level: 5,
        rank: 1,
      ),
      RankingEntry(
        username: '열공맨',
        totalStudyTime: 360,  // 6시간
        level: 4,
        rank: 2,
      ),
      RankingEntry(
        username: '공부왕',
        totalStudyTime: 300,  // 5시간
        level: 3,
        rank: 3,
      ),
      RankingEntry(
        username: '성실맨',
        totalStudyTime: 240,  // 4시간
        level: 3,
        rank: 4,
      ),
      RankingEntry(
        username: '노력이',
        totalStudyTime: 180,  // 3시간
        level: 2,
        rank: 5,
      ),
    ];

    return rankings;
  }

  // 현재 사용자의 순위 정보를 가져옴
  (int rank, int total) getCurrentUserRanking(int userStudyTime) {
    final rankings = getRankings();
    int totalUsers = rankings.length + 1;  // 현재 사용자 포함
    
    // 현재 사용자의 순위 계산
    int currentRank = 1;
    for (var entry in rankings) {
      if (entry.totalStudyTime > userStudyTime) {
        currentRank++;
      }
    }
    
    return (currentRank, totalUsers);
  }
}
