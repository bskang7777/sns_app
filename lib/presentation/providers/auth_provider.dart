import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sns_app/data/services/auth_service.dart';

// AuthService Provider
final authServiceProvider = Provider<AuthService>((ref) => AuthService());

// 현재 사용자 상태 Provider
final authStateProvider = StreamProvider<MockUser?>((ref) {
  final authService = ref.read(authServiceProvider);
  return authService.authStateChanges;
});

// 로그인 상태 Provider
final isLoggedInProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.maybeWhen(
    data: (user) => user != null,
    orElse: () => false,
  );
});

// 현재 사용자 Provider
final currentUserProvider = Provider<MockUser?>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.maybeWhen(
    data: (user) => user,
    orElse: () => null,
  );
});

// 인증 액션 Provider
final authActionsProvider = Provider<AuthActions>((ref) {
  final authService = ref.read(authServiceProvider);
  return AuthActions(authService);
});

class AuthActions {
  final AuthService _authService;

  AuthActions(this._authService);

  Future<MockUserCredential?> signInWithGoogle() async {
    try {
      return await _authService.signInWithGoogle();
    } catch (e) {
      throw Exception('Google 로그인 실패: $e');
    }
  }

  Future<MockUserCredential> signInAnonymously() async {
    try {
      return await _authService.signInAnonymously();
    } catch (e) {
      throw Exception('익명 로그인 실패: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await _authService.signOut();
    } catch (e) {
      throw Exception('로그아웃 실패: $e');
    }
  }

  Future<void> deleteAccount() async {
    try {
      await _authService.deleteAccount();
    } catch (e) {
      throw Exception('계정 삭제 실패: $e');
    }
  }

  Future<void> updateProfile({
    String? displayName,
    String? photoURL,
  }) async {
    try {
      await _authService.updateProfile(
        displayName: displayName,
        photoURL: photoURL,
      );
    } catch (e) {
      throw Exception('프로필 업데이트 실패: $e');
    }
  }
}
