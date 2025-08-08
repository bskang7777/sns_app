import 'package:flutter/material.dart';
import 'package:sns_app/core/constants/app_colors.dart';
import 'package:sns_app/core/constants/app_typography.dart';

class StoryList extends StatelessWidget {
  const StoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10, // Mock data count
        itemBuilder: (context, index) {
          return _buildStoryItem(index);
        },
      ),
    );
  }

  Widget _buildStoryItem(int index) {
    final isAddStory = index == 0;

    return Container(
      width: 80,
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        children: [
          // Story circle
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: isAddStory
                  ? null
                  : const LinearGradient(
                      colors: [
                        AppColors.storyGradient1,
                        AppColors.storyGradient2,
                        AppColors.storyGradient3,
                      ],
                    ),
              border: isAddStory
                  ? Border.all(color: AppColors.textTertiary, width: 1)
                  : null,
            ),
            child: Container(
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.background,
                image: isAddStory
                    ? null
                    : DecorationImage(
                        image: AssetImage(_getAvatarImage(index)),
                        fit: BoxFit.cover,
                      ),
              ),
              child: isAddStory
                  ? const Icon(Icons.add, color: AppColors.primary, size: 24)
                  : null,
            ),
          ),

          const SizedBox(height: 4),

          // Username
          Text(
            isAddStory ? '내 스토리1' : 'ai_tool_user_$index',
            style: AppTypography.caption.copyWith(
              color: AppColors.textPrimary,
              fontSize: 10,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  String _getAvatarImage(int index) {
    // AI TOOL 관련 이미지들
    final availableImages = [
      'assets/images/mcp_developer.jpg',
      'assets/images/llm_expert.jpg',
      'assets/images/cursor_engineer.jpg',
      'assets/images/n8n_scientist.jpg',
      'assets/images/claude_lecturer.jpg',
      'assets/images/ai_tool_team.jpg',
    ];

    // 인덱스를 사용 가능한 이미지 개수로 나눈 나머지를 사용
    return availableImages[index % availableImages.length];
  }
}
