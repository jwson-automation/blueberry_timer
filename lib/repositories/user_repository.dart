import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:blueberry_timer/models/user_model.dart';

class UserRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  UserRepository({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  }) : 
    _firestore = firestore ?? FirebaseFirestore.instance,
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
}
