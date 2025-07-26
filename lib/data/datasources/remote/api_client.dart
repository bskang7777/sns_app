import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:sns_app/data/models/user_model.dart';
import 'package:sns_app/data/models/post_model.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: "https://api.snsapp.com/api/")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  // User endpoints
  @GET("users/profile")
  Future<UserModel> getCurrentUser();

  @GET("users/{id}")
  Future<UserModel> getUserById(@Path("id") String id);

  @GET("users/search")
  Future<List<UserModel>> searchUsers(@Query("q") String query);

  @PUT("users/profile")
  Future<UserModel> updateProfile(@Body() UserModel user);

  @POST("users/{id}/follow")
  Future<void> followUser(@Path("id") String id);

  @DELETE("users/{id}/follow")
  Future<void> unfollowUser(@Path("id") String id);

  @GET("users/{id}/followers")
  Future<List<UserModel>> getFollowers(@Path("id") String id);

  @GET("users/{id}/following")
  Future<List<UserModel>> getFollowing(@Path("id") String id);

  // Post endpoints
  @GET("posts")
  Future<List<PostModel>> getFeedPosts({
    @Query("page") int page = 1,
    @Query("limit") int limit = 10,
  });

  @GET("posts/{id}")
  Future<PostModel> getPostById(@Path("id") String id);

  @POST("posts")
  Future<PostModel> createPost(@Body() PostModel post);

  @PUT("posts/{id}")
  Future<PostModel> updatePost(@Path("id") String id, @Body() PostModel post);

  @DELETE("posts/{id}")
  Future<void> deletePost(@Path("id") String id);

  @POST("posts/{id}/like")
  Future<void> likePost(@Path("id") String id);

  @DELETE("posts/{id}/like")
  Future<void> unlikePost(@Path("id") String id);

  @GET("posts/{id}/comments")
  Future<List<CommentModel>> getPostComments(@Path("id") String id);

  @POST("posts/{id}/comments")
  Future<CommentModel> addComment(
    @Path("id") String id,
    @Body() Map<String, String> comment,
  );

  @DELETE("comments/{id}")
  Future<void> deleteComment(@Path("id") String id);

  @GET("users/{id}/posts")
  Future<List<PostModel>> getUserPosts(@Path("id") String id);

  @GET("posts/search")
  Future<List<PostModel>> searchPosts(@Query("q") String query);
}

// Comment model for API
@JsonSerializable()
class CommentModel {
  final String id;
  @JsonKey(name: 'post_id')
  final String postId;
  @JsonKey(name: 'user_id')
  final String userId;
  final String content;
  @JsonKey(name: 'parent_comment_id')
  final String? parentCommentId;
  @JsonKey(name: 'likes_count')
  final int likesCount;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  final UserModel? user;

  const CommentModel({
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

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);
  Map<String, dynamic> toJson() => _$CommentModelToJson(this);
}
