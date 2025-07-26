class User {
  final String id;
  final String username;
  final String email;
  final String? fullName;
  final String? bio;
  final String? profileImageUrl;
  final String? website;
  final bool isPrivate;
  final bool isVerified;
  final DateTime createdAt;
  final DateTime updatedAt;

  // Statistics
  final int postsCount;
  final int followersCount;
  final int followingCount;

  const User({
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

  User copyWith({
    String? id,
    String? username,
    String? email,
    String? fullName,
    String? bio,
    String? profileImageUrl,
    String? website,
    bool? isPrivate,
    bool? isVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? postsCount,
    int? followersCount,
    int? followingCount,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      bio: bio ?? this.bio,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      website: website ?? this.website,
      isPrivate: isPrivate ?? this.isPrivate,
      isVerified: isVerified ?? this.isVerified,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      postsCount: postsCount ?? this.postsCount,
      followersCount: followersCount ?? this.followersCount,
      followingCount: followingCount ?? this.followingCount,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'User(id: $id, username: $username, email: $email)';
  }
}
