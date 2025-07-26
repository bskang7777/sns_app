import 'package:sns_app/domain/entities/post.dart';
import 'package:sns_app/domain/entities/comment.dart';
import 'package:sns_app/domain/repositories/post_repository.dart';

class GetFeedPostsUseCase {
  final PostRepository repository;

  GetFeedPostsUseCase(this.repository);

  Future<List<Post>> call({int page = 1, int limit = 10}) async {
    return await repository.getFeedPosts(page: page, limit: limit);
  }
}

class GetPostByIdUseCase {
  final PostRepository repository;

  GetPostByIdUseCase(this.repository);

  Future<Post> call(String id) async {
    return await repository.getPostById(id);
  }
}

class CreatePostUseCase {
  final PostRepository repository;

  CreatePostUseCase(this.repository);

  Future<Post> call(Post post) async {
    return await repository.createPost(post);
  }
}

class UpdatePostUseCase {
  final PostRepository repository;

  UpdatePostUseCase(this.repository);

  Future<Post> call(Post post) async {
    return await repository.updatePost(post);
  }
}

class DeletePostUseCase {
  final PostRepository repository;

  DeletePostUseCase(this.repository);

  Future<void> call(String id) async {
    await repository.deletePost(id);
  }
}

class LikePostUseCase {
  final PostRepository repository;

  LikePostUseCase(this.repository);

  Future<void> call(String postId) async {
    await repository.likePost(postId);
  }
}

class UnlikePostUseCase {
  final PostRepository repository;

  UnlikePostUseCase(this.repository);

  Future<void> call(String postId) async {
    await repository.unlikePost(postId);
  }
}

class GetPostCommentsUseCase {
  final PostRepository repository;

  GetPostCommentsUseCase(this.repository);

  Future<List<Comment>> call(String postId) async {
    return await repository.getPostComments(postId);
  }
}

class AddCommentUseCase {
  final PostRepository repository;

  AddCommentUseCase(this.repository);

  Future<Comment> call(String postId, String content) async {
    if (content.trim().isEmpty) {
      throw ArgumentError('Comment content cannot be empty');
    }
    return await repository.addComment(postId, content);
  }
}

class DeleteCommentUseCase {
  final PostRepository repository;

  DeleteCommentUseCase(this.repository);

  Future<void> call(String commentId) async {
    await repository.deleteComment(commentId);
  }
}

class GetUserPostsUseCase {
  final PostRepository repository;

  GetUserPostsUseCase(this.repository);

  Future<List<Post>> call(String userId) async {
    return await repository.getUserPosts(userId);
  }
}

class SearchPostsUseCase {
  final PostRepository repository;

  SearchPostsUseCase(this.repository);

  Future<List<Post>> call(String query) async {
    if (query.trim().isEmpty) return [];
    return await repository.searchPosts(query);
  }
}
