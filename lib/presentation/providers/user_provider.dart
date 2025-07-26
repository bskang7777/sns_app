import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sns_app/domain/entities/user.dart';
import 'package:sns_app/domain/repositories/user_repository.dart';
import 'package:sns_app/domain/usecases/user_usecases.dart';

// Repository providers
final userRepositoryProvider = Provider<UserRepository>((ref) {
  // TODO: Inject actual repository implementation
  throw UnimplementedError('UserRepository not implemented');
});

// Use case providers
final getCurrentUserUseCaseProvider = Provider<GetCurrentUserUseCase>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return GetCurrentUserUseCase(repository);
});

final getUserByIdUseCaseProvider = Provider<GetUserByIdUseCase>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return GetUserByIdUseCase(repository);
});

final searchUsersUseCaseProvider = Provider<SearchUsersUseCase>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return SearchUsersUseCase(repository);
});

final updateProfileUseCaseProvider = Provider<UpdateProfileUseCase>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return UpdateProfileUseCase(repository);
});

final followUserUseCaseProvider = Provider<FollowUserUseCase>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return FollowUserUseCase(repository);
});

final unfollowUserUseCaseProvider = Provider<UnfollowUserUseCase>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return UnfollowUserUseCase(repository);
});

// State providers
final currentUserProvider = FutureProvider<User>((ref) async {
  final useCase = ref.watch(getCurrentUserUseCaseProvider);
  return await useCase();
});

final userByIdProvider = FutureProvider.family<User, String>((ref, id) async {
  final useCase = ref.watch(getUserByIdUseCaseProvider);
  return await useCase(id);
});

final searchUsersProvider = FutureProvider.family<List<User>, String>((
  ref,
  query,
) async {
  final useCase = ref.watch(searchUsersUseCaseProvider);
  return await useCase(query);
});

// Notifier for user actions
class UserNotifier extends StateNotifier<AsyncValue<User?>> {
  final UpdateProfileUseCase _updateProfileUseCase;
  final FollowUserUseCase _followUserUseCase;
  final UnfollowUserUseCase _unfollowUserUseCase;

  UserNotifier(
    this._updateProfileUseCase,
    this._followUserUseCase,
    this._unfollowUserUseCase,
  ) : super(const AsyncValue.loading());

  Future<void> updateProfile(User user) async {
    state = const AsyncValue.loading();
    try {
      final updatedUser = await _updateProfileUseCase(user);
      state = AsyncValue.data(updatedUser);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> followUser(String userId) async {
    try {
      await _followUserUseCase(userId);
      // Refresh current user data
      // TODO: Implement refresh logic
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> unfollowUser(String userId) async {
    try {
      await _unfollowUserUseCase(userId);
      // Refresh current user data
      // TODO: Implement refresh logic
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

final userNotifierProvider =
    StateNotifierProvider<UserNotifier, AsyncValue<User?>>((ref) {
      final updateProfileUseCase = ref.watch(updateProfileUseCaseProvider);
      final followUserUseCase = ref.watch(followUserUseCaseProvider);
      final unfollowUserUseCase = ref.watch(unfollowUserUseCaseProvider);

      return UserNotifier(
        updateProfileUseCase,
        followUserUseCase,
        unfollowUserUseCase,
      );
    });
