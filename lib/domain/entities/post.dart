import 'package:sns_app/domain/entities/user.dart';

enum PostType { image, video, carousel }

class Location {
  final String name;
  final double latitude;
  final double longitude;

  const Location({
    required this.name,
    required this.latitude,
    required this.longitude,
  });
}

class Post {
  final String id;
  final String userId;
  final String? caption;
  final List<String> imageUrls;
  final List<String> hashtags;
  final Location? location;
  final PostType type;
  final bool isLiked;
  final int likesCount;
  final int commentsCount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final User? user; // Associated user data

  const Post({
    required this.id,
    required this.userId,
    this.caption,
    required this.imageUrls,
    this.hashtags = const [],
    this.location,
    this.type = PostType.image,
    this.isLiked = false,
    this.likesCount = 0,
    this.commentsCount = 0,
    required this.createdAt,
    required this.updatedAt,
    this.user,
  });

  Post copyWith({
    String? id,
    String? userId,
    String? caption,
    List<String>? imageUrls,
    List<String>? hashtags,
    Location? location,
    PostType? type,
    bool? isLiked,
    int? likesCount,
    int? commentsCount,
    DateTime? createdAt,
    DateTime? updatedAt,
    User? user,
  }) {
    return Post(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      caption: caption ?? this.caption,
      imageUrls: imageUrls ?? this.imageUrls,
      hashtags: hashtags ?? this.hashtags,
      location: location ?? this.location,
      type: type ?? this.type,
      isLiked: isLiked ?? this.isLiked,
      likesCount: likesCount ?? this.likesCount,
      commentsCount: commentsCount ?? this.commentsCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      user: user ?? this.user,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Post && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Post(id: $id, userId: $userId, caption: $caption)';
  }
}
