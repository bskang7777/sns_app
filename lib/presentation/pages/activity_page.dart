import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sns_app/core/constants/app_colors.dart';
import 'package:sns_app/core/constants/app_typography.dart';

class ActivityPage extends ConsumerStatefulWidget {
  const ActivityPage({super.key});

  @override
  ConsumerState<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends ConsumerState<ActivityPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          '활동',
          style: AppTypography.headline3.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.textPrimary,
          unselectedLabelColor: AppColors.textSecondary,
          indicatorColor: AppColors.textPrimary,
          tabs: const [
            Tab(text: '팔로우'),
            Tab(text: '좋아요'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildFollowTab(), _buildLikesTab()],
      ),
    );
  }

  Widget _buildFollowTab() {
    return RefreshIndicator(
      onRefresh: () async {
        // TODO: Implement refresh
      },
      child: ListView.builder(
        controller: _scrollController,
        itemCount: 15,
        itemBuilder: (context, index) {
          return _buildFollowItem(index);
        },
      ),
    );
  }

  Widget _buildLikesTab() {
    return RefreshIndicator(
      onRefresh: () async {
        // TODO: Implement refresh
      },
      child: ListView.builder(
        controller: _scrollController,
        itemCount: 20,
        itemBuilder: (context, index) {
          return _buildLikeItem(index);
        },
      ),
    );
  }

  Widget _buildFollowItem(int index) {
    final isNew = index < 3; // First 3 items are new
    final usernames = [
      'travel_lover',
      'food_enthusiast',
      'nature_photographer',
      'art_creator',
      'fitness_guru',
      'presentation_expert_choi',
      'ai_lecturer_kang',
      'research_team_kim',
    ];
    final username = usernames[index % usernames.length];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          // Avatar
          Stack(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage(
                  'assets/images/user_avatar_${(index % 3) + 1}.jpg',
                ),
              ),
              if (isNew)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.background, width: 2),
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(width: 12),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: AppTypography.body2.copyWith(
                      color: AppColors.textPrimary,
                    ),
                    children: [
                      TextSpan(
                        text: username,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const TextSpan(text: '님이 회원님을 팔로우하기 시작했습니다.'),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  isNew ? '방금 전' : '${index + 1}시간 전',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          // Follow Button
          ElevatedButton(
            onPressed: () {
              // TODO: Implement follow/unfollow
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              minimumSize: const Size(80, 32),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: Text(
              '팔로우',
              style: AppTypography.caption.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLikeItem(int index) {
    final usernames = [
      'travel_lover',
      'food_enthusiast',
      'nature_photographer',
      'art_creator',
      'fitness_guru',
      'presentation_expert_choi',
      'ai_lecturer_kang',
      'research_team_kim',
    ];
    final username = usernames[index % usernames.length];
    final isMultiple = index % 4 == 0; // Some items show multiple users

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          // Avatar
          CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage(
              'assets/images/user_avatar_${(index % 3) + 1}.jpg',
            ),
          ),

          const SizedBox(width: 12),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: AppTypography.body2.copyWith(
                      color: AppColors.textPrimary,
                    ),
                    children: [
                      TextSpan(
                        text:
                            isMultiple ? '$username 외 ${index + 2}명' : username,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const TextSpan(text: '님이 회원님의 게시물을 좋아합니다.'),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${index + 1}시간 전',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          // Post Thumbnail
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              image: DecorationImage(
                image: AssetImage(
                  _getActivityImage(index),
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getActivityImage(int index) {
    final images = [
      'assets/images/ai_project_1.jpg',
      'assets/images/presentation_1.jpg',
      'assets/images/ai_project_2.jpg',
      'assets/images/presentation_2.jpg',
      'assets/images/ai_project_3.jpg',
      'assets/images/presentation_3.jpg',
      'assets/images/presentation_4.jpg',
      'assets/images/user_avatar_1.jpg',
      'assets/images/user_avatar_2.jpg',
      'assets/images/profile_avatar.jpg',
    ];
    return images[index % images.length];
  }
}
