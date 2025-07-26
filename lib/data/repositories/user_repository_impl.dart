import 'package:sns_app/domain/entities/user.dart';
import 'package:sns_app/domain/repositories/user_repository.dart';
import 'package:sns_app/data/datasources/remote/api_client.dart';
import 'package:sns_app/data/models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final ApiClient apiClient;

  UserRepositoryImpl(this.apiClient);

  @override
  Future<User> getCurrentUser() async {
    try {
      final userModel = await apiClient.getCurrentUser();
      return userModel.toEntity();
    } catch (e) {
      throw Exception('Failed to get current user: $e');
    }
  }

  @override
  Future<User> getUserById(String id) async {
    try {
      final userModel = await apiClient.getUserById(id);
      return userModel.toEntity();
    } catch (e) {
      throw Exception('Failed to get user by id: $e');
    }
  }

  @override
  Future<User> getUserByUsername(String username) async {
    try {
      final users = await apiClient.searchUsers(username);
      final user = users.firstWhere((u) => u.username == username);
      return user.toEntity();
    } catch (e) {
      throw Exception('Failed to get user by username: $e');
    }
  }

  @override
  Future<List<User>> searchUsers(String query) async {
    try {
      final userModels = await apiClient.searchUsers(query);
      return userModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to search users: $e');
    }
  }

  @override
  Future<User> updateProfile(User user) async {
    try {
      final userModel = UserModel.fromEntity(user);
      final updatedUserModel = await apiClient.updateProfile(userModel);
      return updatedUserModel.toEntity();
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }

  @override
  Future<void> followUser(String userId) async {
    try {
      await apiClient.followUser(userId);
    } catch (e) {
      throw Exception('Failed to follow user: $e');
    }
  }

  @override
  Future<void> unfollowUser(String userId) async {
    try {
      await apiClient.unfollowUser(userId);
    } catch (e) {
      throw Exception('Failed to unfollow user: $e');
    }
  }

  @override
  Future<List<User>> getFollowers(String userId) async {
    try {
      final userModels = await apiClient.getFollowers(userId);
      return userModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to get followers: $e');
    }
  }

  @override
  Future<List<User>> getFollowing(String userId) async {
    try {
      final userModels = await apiClient.getFollowing(userId);
      return userModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to get following: $e');
    }
  }

  @override
  Future<bool> isFollowing(String userId) async {
    try {
      final following = await getFollowing(userId);
      return following.any((user) => user.id == userId);
    } catch (e) {
      throw Exception('Failed to check if following: $e');
    }
  }
}
