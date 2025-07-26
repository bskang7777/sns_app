import 'package:json_annotation/json_annotation.dart';
import 'package:sns_app/domain/entities/user.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String id;
  final String username;
  final String email;
  final String? fullName;
  final String? bio;
  final String? profileImageUrl;
  final String? website;
  final bool isPrivate;
  final bool isVerified;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  @JsonKey(name: 'posts_count')
  final int postsCount;
  @JsonKey(name: 'followers_count')
  final int followersCount;
  @JsonKey(name: 'following_count')
  final int followingCount;

  const UserModel({
    required this.id,
    required this.username,
    required this.email,
    this.fullName,
    this.bio,
    this.profileImageUrl,
    this.website,
    this.isPrivate = false,
    this.isVerified = false,
    required this.createdAt,
    required this.updatedAt,
    this.postsCount = 0,
    this.followersCount = 0,
    this.followingCount = 0,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      username: user.username,
      email: user.email,
      fullName: user.fullName,
      bio: user.bio,
      profileImageUrl: user.profileImageUrl,
      website: user.website,
      isPrivate: user.isPrivate,
      isVerified: user.isVerified,
      createdAt: user.createdAt,
      updatedAt: user.updatedAt,
      postsCount: user.postsCount,
      followersCount: user.followersCount,
      followingCount: user.followingCount,
    );
  }

  User toEntity() {
    return User(
      id: id,
      username: username,
      email: email,
      fullName: fullName,
      bio: bio,
      profileImageUrl: profileImageUrl,
      website: website,
      isPrivate: isPrivate,
      isVerified: isVerified,
      createdAt: createdAt,
      updatedAt: updatedAt,
      postsCount: postsCount,
      followersCount: followersCount,
      followingCount: followingCount,
    );
  }
}
