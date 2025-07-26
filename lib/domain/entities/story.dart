enum StoryType { image, video }

class Story {
  final String id;
  final String userId;
  final String mediaUrl;
  final StoryType type;
  final List<String>? mentions;
  final List<String>? hashtags;
  final DateTime createdAt;
  final DateTime expiresAt; // 24 hours after creation
  final bool isViewed;

  const Story({
    required this.id,
    required this.userId,
    required this.mediaUrl,
    this.type = StoryType.image,
    this.mentions,
    this.hashtags,
    required this.createdAt,
    required this.expiresAt,
    this.isViewed = false,
  });

  Story copyWith({
    String? id,
    String? userId,
    String? mediaUrl,
    StoryType? type,
    List<String>? mentions,
    List<String>? hashtags,
    DateTime? createdAt,
    DateTime? expiresAt,
    bool? isViewed,
  }) {
    return Story(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      type: type ?? this.type,
      mentions: mentions ?? this.mentions,
      hashtags: hashtags ?? this.hashtags,
      createdAt: createdAt ?? this.createdAt,
      expiresAt: expiresAt ?? this.expiresAt,
      isViewed: isViewed ?? this.isViewed,
    );
  }

  bool get isExpired => DateTime.now().isAfter(expiresAt);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Story && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Story(id: $id, userId: $userId, type: $type)';
  }
}
