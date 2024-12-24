import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:blueberry_timer/models/user_model.dart';

class UserRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  UserRepository({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  // 현재 로그인된 사용자의 UID 가져오기
  String? get currentUserId => _auth.currentUser?.uid;

  // Firebase에 사용자 데이터 저장
  Future<void> saveUser(UserModel userModel) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception('사용자가 로그인되어 있지 않습니다.');
      }

      final userRef = _firestore.collection('users').doc(user.uid);
      await userRef.set(userModel.toJson(), SetOptions(merge: true));
    } catch (e) {
      print('Firebase에 사용자 데이터 저장 중 오류 발생: $e');
      rethrow;
    }
  }

  // Firebase에서 사용자 데이터 불러오기
  Future<UserModel?> fetchUser() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception('사용자가 로그인되어 있지 않습니다.');
      }

      final userRef = _firestore.collection('users').doc(user.uid);
      final userDoc = await userRef.get();

      if (userDoc.exists) {
        return UserModel.fromJson(userDoc.data()!);
      }
      return null;
    } catch (e) {
      print('Firebase에서 사용자 데이터 불러오기 중 오류 발생: $e');
      rethrow;
    }
  }

  // 사용자 랭킹 불러오기 (경험치 기준)
  Future<List<UserModel>> fetchUserRankings({int limit = 10}) async {
    try {
      final querySnapshot = await _firestore
          .collection('users')
          .orderBy('experience', descending: true)
          .limit(limit)
          .get();

      return querySnapshot.docs
          .map((doc) => UserModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      print('사용자 랭킹 불러오기 중 오류 발생: $e');
      rethrow;
    }
  }

  // 사용자 데이터 부분 업데이트
  Future<void> updateUserField(String field, dynamic value) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception('사용자가 로그인되어 있지 않습니다.');
      }

      final userRef = _firestore.collection('users').doc(user.uid);
      await userRef.update({field: value});
    } catch (e) {
      print('사용자 데이터 부분 업데이트 중 오류 발생: $e');
      rethrow;
    }
  }

  // 임시 사용자 추가
  Future<UserModel> addTemporaryUser({
    required String name,
    required String email,
    int initialExperience = 0,
    int initialMoney = 0,
  }) async {
    try {
      // 임시 사용자를 위한 익명 인증 생성
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: _generateTemporaryPassword(),
      );

      final user = userCredential.user;
      if (user == null) {
        throw Exception('임시 사용자 생성 중 오류 발생');
      }

      // 사용자 모델 생성
      final userModel = UserModel(
          uid: user.uid,
          username: name,
          level: 1,
          totalStudyTime: 0,
          achievements: [],
          experience: initialExperience,
          money: initialMoney);

      // Firestore에 사용자 저장
      final userRef = _firestore.collection('users').doc(user.uid);
      await userRef.set(userModel.toJson());

      return userModel;
    } catch (e) {
      print('임시 사용자 추가 중 오류 발생: $e');
      rethrow;
    }
  }

  // 임시 비밀번호 생성 (보안을 위해 랜덤하고 복잡한 비밀번호)
  String _generateTemporaryPassword() {
    // 임시 비밀번호 생성 로직 (예: 랜덤 문자열)
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return 'Temp_$timestamp${_randomString(8)}';
  }

  // 랜덤 문자열 생성 헬퍼 메서드
  String _randomString(int length) {
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(
            length, (index) => chars[DateTime.now().millisecond % chars.length])
        .join();
  }
}
