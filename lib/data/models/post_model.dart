import 'package:json_annotation/json_annotation.dart';
import 'package:sns_app/domain/entities/post.dart';
import 'package:sns_app/data/models/user_model.dart';

part 'post_model.g.dart';

@JsonSerializable()
class LocationModel {
  final String name;
  final double latitude;
  final double longitude;

  const LocationModel({
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);
  Map<String, dynamic> toJson() => _$LocationModelToJson(this);

  factory LocationModel.fromEntity(Location location) {
    return LocationModel(
      name: location.name,
      latitude: location.latitude,
      longitude: location.longitude,
    );
  }

  Location toEntity() {
    return Location(name: name, latitude: latitude, longitude: longitude);
  }
}

@JsonSerializable()
class PostModel {
  final String id;
  @JsonKey(name: 'user_id')
  final String userId;
  final String? caption;
  @JsonKey(name: 'image_urls')
  final List<String> imageUrls;
  final List<String> hashtags;
  final LocationModel? location;
  final String type;
  @JsonKey(name: 'is_liked')
  final bool isLiked;
  @JsonKey(name: 'likes_count')
  final int likesCount;
  @JsonKey(name: 'comments_count')
  final int commentsCount;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  final UserModel? user;

  const PostModel({
    required this.id,
    required this.userId,
    this.caption,
    required this.imageUrls,
    this.hashtags = const [],
    this.location,
    this.type = 'image',
    this.isLiked = false,
    this.likesCount = 0,
    this.commentsCount = 0,
    required this.createdAt,
    required this.updatedAt,
    this.user,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);
  Map<String, dynamic> toJson() => _$PostModelToJson(this);

  factory PostModel.fromEntity(Post post) {
    return PostModel(
      id: post.id,
      userId: post.userId,
      caption: post.caption,
      imageUrls: post.imageUrls,
      hashtags: post.hashtags,
      location: post.location != null
          ? LocationModel.fromEntity(post.location!)
          : null,
      type: post.type.name,
      isLiked: post.isLiked,
      likesCount: post.likesCount,
      commentsCount: post.commentsCount,
      createdAt: post.createdAt,
      updatedAt: post.updatedAt,
      user: post.user != null ? UserModel.fromEntity(post.user!) : null,
    );
  }

  Post toEntity() {
    return Post(
      id: id,
      userId: userId,
      caption: caption,
      imageUrls: imageUrls,
      hashtags: hashtags,
      location: location?.toEntity(),
      type: PostType.values.firstWhere(
        (e) => e.name == type,
        orElse: () => PostType.image,
      ),
      isLiked: isLiked,
      likesCount: likesCount,
      commentsCount: commentsCount,
      createdAt: createdAt,
      updatedAt: updatedAt,
      user: user?.toEntity(),
    );
  }
}
