import 'package:sns_app/domain/entities/post.dart';
import 'package:sns_app/domain/entities/comment.dart';

abstract class PostRepository {
  Future<List<Post>> getFeedPosts({int page = 1, int limit = 10});
  Future<Post> getPostById(String id);
  Future<Post> createPost(Post post);
  Future<Post> updatePost(Post post);
  Future<void> deletePost(String id);
  Future<void> likePost(String postId);
  Future<void> unlikePost(String postId);
  Future<List<Comment>> getPostComments(String postId);
  Future<Comment> addComment(String postId, String content);
  Future<void> deleteComment(String commentId);
  Future<List<Post>> getUserPosts(String userId);
  Future<List<Post>> searchPosts(String query);
}
