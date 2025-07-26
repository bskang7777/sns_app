import 'package:flutter/material.dart';
import 'package:sns_app/core/constants/app_colors.dart';
import 'package:sns_app/core/constants/app_typography.dart';

class PostCard extends StatelessWidget {
  final String username;
  final String location;
  final String avatar;
  final String image;
  final int likes;
  final String caption;
  final VoidCallback onLike;
  final VoidCallback onComment;
  final VoidCallback onShare;
  final VoidCallback onSave;

  const PostCard({
    super.key,
    required this.username,
    required this.location,
    required this.avatar,
    required this.image,
    required this.likes,
    required this.caption,
    required this.onLike,
    required this.onComment,
    required this.onShare,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(avatar),
              radius: 20,
            ),
            title: Text(
              username,
              style: AppTypography.body1.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            subtitle: Text(
              location,
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.more_vert, color: AppColors.textPrimary),
              onPressed: () {
                // TODO: Show post options
              },
            ),
          ),

          // Image
          AspectRatio(
            aspectRatio: 1.0,
            child: Image.asset(
              image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),

          // Actions
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.favorite_border,
                    color: AppColors.textPrimary,
                  ),
                  onPressed: onLike,
                ),
                IconButton(
                  icon: const Icon(
                    Icons.chat_bubble_outline,
                    color: AppColors.textPrimary,
                  ),
                  onPressed: onComment,
                ),
                IconButton(
                  icon: const Icon(
                    Icons.send_outlined,
                    color: AppColors.textPrimary,
                  ),
                  onPressed: onShare,
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(
                    Icons.bookmark_border,
                    color: AppColors.textPrimary,
                  ),
                  onPressed: onSave,
                ),
              ],
            ),
          ),

          // Likes count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              '좋아요 ${likes}개',
              style: AppTypography.body2.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),

          // Caption
          Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 12.0),
            child: RichText(
              text: TextSpan(
                style: AppTypography.body2.copyWith(
                  color: AppColors.textPrimary,
                ),
                children: [
                  TextSpan(
                    text: '$username ',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  TextSpan(text: caption),
                ],
              ),
            ),
          ),

          // Comments preview
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              '댓글 모두 보기',
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),

          const SizedBox(height: 8.0),
        ],
      ),
    );
  }
}
