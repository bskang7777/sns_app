import 'package:sns_app/domain/entities/story.dart';

abstract class StoryRepository {
  Future<List<Story>> getStories();
  Future<Story> createStory(Story story);
  Future<void> deleteStory(String id);
  Future<void> markStoryAsViewed(String storyId);
  Future<List<Story>> getUserStories(String userId);
  Future<List<Story>> getStoriesByUserIds(List<String> userIds);
}
