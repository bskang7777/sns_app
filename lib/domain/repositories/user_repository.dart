import 'package:sns_app/domain/entities/user.dart';

abstract class UserRepository {
  Future<User> getCurrentUser();
  Future<User> getUserById(String id);
  Future<User> getUserByUsername(String username);
  Future<List<User>> searchUsers(String query);
  Future<User> updateProfile(User user);
  Future<void> followUser(String userId);
  Future<void> unfollowUser(String userId);
  Future<List<User>> getFollowers(String userId);
  Future<List<User>> getFollowing(String userId);
  Future<bool> isFollowing(String userId);
}
