import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sns_app/core/constants/app_colors.dart';
import 'package:sns_app/core/constants/app_typography.dart';
import 'package:sns_app/presentation/pages/presentation_page.dart';
import 'package:sns_app/presentation/providers/auth_provider.dart';
import 'package:sns_app/presentation/pages/auth/login_page.dart';
import 'package:sns_app/data/services/auth_service.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
          'ai_developer_profile',
          style: AppTypography.headline3.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add_box_outlined,
              color: AppColors.textPrimary,
            ),
            onPressed: () {
              // TODO: Navigate to create post
            },
          ),
          // 인증 상태에 따른 로그인/로그아웃 버튼
          Consumer(
            builder: (context, ref, child) {
              final user = ref.watch(currentUserProvider);
              return IconButton(
                icon: Icon(
                  user != null ? Icons.logout : Icons.login,
                  color: AppColors.textPrimary,
                ),
                onPressed: () => _handleAuthAction(ref, user),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.menu, color: AppColors.textPrimary),
            onPressed: () {
              _showProfileOptions();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Profile Header
          _buildProfileHeader(),

          // Stats
          _buildStats(),

          // Bio
          _buildBio(),

          // Action Buttons
          _buildActionButtons(),

          // Tab Bar
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppColors.textTertiary, width: 0.5),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: AppColors.textPrimary,
              unselectedLabelColor: AppColors.textSecondary,
              indicatorColor: AppColors.textPrimary,
              tabs: const [
                Tab(icon: Icon(Icons.grid_on)),
                Tab(icon: Icon(Icons.bookmark_border)),
                Tab(icon: Icon(Icons.person_pin_outlined)),
              ],
            ),
          ),

          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [_buildPostsTab(), _buildSavedTab(), _buildTaggedTab()],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          // Profile Image
          CircleAvatar(
            radius: 40,
            backgroundImage: const AssetImage(
              'assets/images/mcp_developer.jpg',
            ),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.background, width: 3),
              ),
            ),
          ),

          const SizedBox(width: 16),

          // Stats
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatItem('AI TOOL 프로젝트', '42'),
                _buildStatItem('팔로워', '1.2K'),
                _buildStatItem('팔로우', '890'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String count) {
    return Column(
      children: [
        Text(
          count,
          style: AppTypography.headline3.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        Text(
          label,
          style: AppTypography.caption.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }

  Widget _buildStats() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '김AI TOOL 개발자',
                  style: AppTypography.body1.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'AI TOOL 엔지니어 | AI TOOL 연구원 | AI TOOL 전문가',
                  style: AppTypography.body2.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBio() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '🛠️ AI TOOL 개발 및 연구',
            style: AppTypography.body2.copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: 4),
          Text(
            '📊 AI TOOL 데이터 분석 & 머신러닝',
            style: AppTypography.body2.copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: 4),
          Text(
            '🔌 AI TOOL 플러그인 & 확장 기능',
            style: AppTypography.body2.copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: 4),
          Text(
            '🤖 AI TOOL 자동화 & 워크플로우',
            style: AppTypography.body2.copyWith(color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                // TODO: Navigate to edit profile
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.textTertiary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: Text(
                '프로필 편집',
                style: AppTypography.button.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                // TODO: Navigate to share profile
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.textTertiary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: Text(
                '포트폴리오 공유',
                style: AppTypography.button.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostsTab() {
    return GridView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(1.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 1.0,
        mainAxisSpacing: 1.0,
      ),
      itemCount: 42,
      itemBuilder: (context, index) {
        return _buildPostGridItem(index);
      },
    );
  }

  Widget _buildSavedTab() {
    return GridView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(1.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 1.0,
        mainAxisSpacing: 1.0,
      ),
      itemCount: 15,
      itemBuilder: (context, index) {
        return _buildSavedGridItem(index);
      },
    );
  }

  Widget _buildTaggedTab() {
    return GridView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(1.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 1.0,
        mainAxisSpacing: 1.0,
      ),
      itemCount: 8,
      itemBuilder: (context, index) {
        return _buildTaggedGridItem(index);
      },
    );
  }

  Widget _buildPostGridItem(int index) {
    return GestureDetector(
      onTap: () {
        // TODO: Navigate to post detail
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              _getProfileImage(index),
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.1)),
          child: Stack(
            children: [
              if (index % 5 == 0) // Some posts have video indicator
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              if (index % 7 == 0) // Some posts have carousel indicator
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Icon(
                      Icons.collections,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              if (index % 3 == 0) // Some posts have presentation indicator
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Icon(
                      Icons.slideshow,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSavedGridItem(int index) {
    return GestureDetector(
      onTap: () {
        // TODO: Navigate to saved post detail
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              _getProfileImage(index),
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildTaggedGridItem(int index) {
    return GestureDetector(
      onTap: () {
        // TODO: Navigate to tagged post detail
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              _getProfileImage(index),
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  String _getProfileImage(int index) {
    final images = [
      'assets/images/mcp_tool.jpg',
      'assets/images/llm_presentation.jpg',
      'assets/images/cursor_tool.jpg',
      'assets/images/n8n_workflow.jpg',
      'assets/images/claude_tutorial.jpg',
      'assets/images/ai_tool_dashboard.jpg',
      'assets/images/mcp_developer.jpg',
      'assets/images/llm_expert.jpg',
      'assets/images/cursor_engineer.jpg',
      'assets/images/n8n_scientist.jpg',
    ];
    return images[index % images.length];
  }

  void _showProfileOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.settings, color: AppColors.textPrimary),
              title: Text(
                '설정',
                style: AppTypography.body1.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                // TODO: Navigate to settings
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.bookmark_border,
                color: AppColors.textPrimary,
              ),
              title: Text(
                '저장된 프로젝트',
                style: AppTypography.body1.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                // TODO: Navigate to saved posts
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.slideshow_outlined,
                color: AppColors.textPrimary,
              ),
              title: Text(
                'AI TOOL 모임 프리젠테이션',
                style: AppTypography.body1.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PresentationPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.favorite_border,
                color: AppColors.textPrimary,
              ),
              title: Text(
                '좋아요한 프로젝트',
                style: AppTypography.body1.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                // TODO: Navigate to liked posts
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: AppColors.error),
              title: Text(
                '로그아웃',
                style: AppTypography.body1.copyWith(color: AppColors.error),
              ),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement logout
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _handleAuthAction(WidgetRef ref, MockUser? user) {
    if (user == null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    } else {
      ref.invalidate(currentUserProvider);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('로그아웃되었습니다.')),
      );
    }
  }
}
