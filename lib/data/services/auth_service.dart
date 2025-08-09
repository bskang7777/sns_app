import 'package:flutter/foundation.dart';

// Mock User 클래스 (Firebase User 대신 사용)
class MockUser {
  final String uid;
  final String? displayName;
  final String? email;
  final String? photoURL;
  final bool isAnonymous;

  MockUser({
    required this.uid,
    this.displayName,
    this.email,
    this.photoURL,
    this.isAnonymous = false,
  });
}

// Mock UserCredential 클래스
class MockUserCredential {
  final MockUser? user;

  MockUserCredential({this.user});
}

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  MockUser? _currentUser;

  // 현재 사용자 상태 스트림 (Mock)
  Stream<MockUser?> get authStateChanges async* {
    yield _currentUser;
  }

  // 현재 사용자
  MockUser? get currentUser => _currentUser;

  // Google 로그인 (Mock)
  Future<MockUserCredential?> signInWithGoogle() async {
    try {
      await Future.delayed(const Duration(seconds: 1)); // 시뮬레이션

      _currentUser = MockUser(
        uid: 'google_user_${DateTime.now().millisecondsSinceEpoch}',
        displayName: 'Google User',
        email: 'user@gmail.com',
        photoURL: 'https://via.placeholder.com/150',
        isAnonymous: false,
      );

      return MockUserCredential(user: _currentUser);
    } catch (e) {
      debugPrint('Google 로그인 오류: $e');
      rethrow;
    }
  }

  // 익명 로그인 (Mock)
  Future<MockUserCredential> signInAnonymously() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500)); // 시뮬레이션

      _currentUser = MockUser(
        uid: 'anonymous_user_${DateTime.now().millisecondsSinceEpoch}',
        displayName: '게스트 사용자',
        isAnonymous: true,
      );

      return MockUserCredential(user: _currentUser);
    } catch (e) {
      debugPrint('익명 로그인 오류: $e');
      rethrow;
    }
  }

  // 로그아웃
  Future<void> signOut() async {
    try {
      await Future.delayed(const Duration(milliseconds: 300)); // 시뮬레이션
      _currentUser = null;
    } catch (e) {
      debugPrint('로그아웃 오류: $e');
      rethrow;
    }
  }

  // 계정 삭제
  Future<void> deleteAccount() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500)); // 시뮬레이션
      _currentUser = null;
    } catch (e) {
      debugPrint('계정 삭제 오류: $e');
      rethrow;
    }
  }

  // 사용자 프로필 업데이트
  Future<void> updateProfile({
    String? displayName,
    String? photoURL,
  }) async {
    try {
      await Future.delayed(const Duration(milliseconds: 400)); // 시뮬레이션

      if (_currentUser != null) {
        _currentUser = MockUser(
          uid: _currentUser!.uid,
          displayName: displayName ?? _currentUser!.displayName,
          email: _currentUser!.email,
          photoURL: photoURL ?? _currentUser!.photoURL,
          isAnonymous: _currentUser!.isAnonymous,
        );
      }
    } catch (e) {
      debugPrint('프로필 업데이트 오류: $e');
      rethrow;
    }
  }
}
