import 'package:sns_app/domain/entities/user.dart';
import 'package:sns_app/domain/repositories/user_repository.dart';

class GetCurrentUserUseCase {
  final UserRepository repository;

  GetCurrentUserUseCase(this.repository);

  Future<User> call() async {
    return await repository.getCurrentUser();
  }
}

class GetUserByIdUseCase {
  final UserRepository repository;

  GetUserByIdUseCase(this.repository);

  Future<User> call(String id) async {
    return await repository.getUserById(id);
  }
}

class SearchUsersUseCase {
  final UserRepository repository;

  SearchUsersUseCase(this.repository);

  Future<List<User>> call(String query) async {
    if (query.trim().isEmpty) return [];
    return await repository.searchUsers(query);
  }
}

class UpdateProfileUseCase {
  final UserRepository repository;

  UpdateProfileUseCase(this.repository);

  Future<User> call(User user) async {
    return await repository.updateProfile(user);
  }
}

class FollowUserUseCase {
  final UserRepository repository;

  FollowUserUseCase(this.repository);

  Future<void> call(String userId) async {
    await repository.followUser(userId);
  }
}

class UnfollowUserUseCase {
  final UserRepository repository;

  UnfollowUserUseCase(this.repository);

  Future<void> call(String userId) async {
    await repository.unfollowUser(userId);
  }
}

class GetFollowersUseCase {
  final UserRepository repository;

  GetFollowersUseCase(this.repository);

  Future<List<User>> call(String userId) async {
    return await repository.getFollowers(userId);
  }
}

class GetFollowingUseCase {
  final UserRepository repository;

  GetFollowingUseCase(this.repository);

  Future<List<User>> call(String userId) async {
    return await repository.getFollowing(userId);
  }
}
