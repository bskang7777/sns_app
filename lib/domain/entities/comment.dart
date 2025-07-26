import 'package:sns_app/domain/entities/user.dart';

class Comment {
  final String id;
  final String postId;
  final String userId;
  final String content;
  final String? parentCommentId; // For replies
  final int likesCount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final User? user; // Associated user data

  const Comment({
    required this.id,
    required this.postId,
    required this.userId,
    required this.content,
    this.parentCommentId,
    this.likesCount = 0,
    required this.createdAt,
    required this.updatedAt,
    this.user,
  });

  Comment copyWith({
    String? id,
    String? postId,
    String? userId,
    String? content,
    String? parentCommentId,
    int? likesCount,
    DateTime? createdAt,
    DateTime? updatedAt,
    User? user,
  }) {
    return Comment(
      id: id ?? this.id,
      postId: postId ?? this.postId,
      userId: userId ?? this.userId,
      content: content ?? this.content,
      parentCommentId: parentCommentId ?? this.parentCommentId,
      likesCount: likesCount ?? this.likesCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      user: user ?? this.user,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Comment && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Comment(id: $id, postId: $postId, content: $content)';
  }
}
