import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sns_app/core/constants/app_colors.dart';
import 'package:sns_app/core/constants/app_typography.dart';
import 'package:sns_app/domain/entities/post.dart';
import 'package:sns_app/presentation/widgets/post_card.dart';
import 'package:sns_app/presentation/widgets/story_list.dart';

class FeedPage extends ConsumerStatefulWidget {
  const FeedPage({super.key});

  @override
  ConsumerState<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends ConsumerState<FeedPage> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadMorePosts();
    }
  }

  void _loadMorePosts() {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });
      // TODO: Implement pagination
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          '동네AI개발자',
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
          IconButton(
            icon: const Icon(
              Icons.favorite_border,
              color: AppColors.textPrimary,
            ),
            onPressed: () {
              // TODO: Navigate to activity
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.chat_bubble_outline,
              color: AppColors.textPrimary,
            ),
            onPressed: () {
              // TODO: Navigate to messages
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // TODO: Implement refresh
        },
        child: ListView(
          controller: _scrollController,
          children: [
            // Stories
            const StoryList(),

            // Posts
            ..._buildPosts(),

            // Loading indicator
            if (_isLoading)
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(child: CircularProgressIndicator()),
              ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildPosts() {
    // TODO: Replace with actual data from provider
    final List<Map<String, dynamic>> mockPosts = [
      {
        'username': 'ai_researcher_kim',
        'location': '서울 AI 연구소',
        'avatar': 'assets/images/user_avatar_1.jpg',
        'image': 'assets/images/ai_project_1.jpg',
        'likes': 245,
        'caption': '새로운 Transformer 모델 실험 결과! 🧠 #AI #Transformer #NLP #딥러닝',
      },
      {
        'username': 'presentation_expert_choi',
        'location': '부산 AI 컨퍼런스',
        'avatar': 'assets/images/user_avatar_2.jpg',
        'image': 'assets/images/presentation_1.jpg',
        'likes': 189,
        'caption': '오늘 AI 컨퍼런스에서 발표한 내용입니다! 📊 #AI컨퍼런스 #프리젠테이션 #기술공유',
      },
      {
        'username': 'ml_engineer_park',
        'location': '부산 ML 엔지니어링팀',
        'avatar': 'assets/images/profile_avatar.jpg',
        'image': 'assets/images/ai_project_2.jpg',
        'likes': 567,
        'caption': '컴퓨터 비전 프로젝트 완성! 🖼️ #ComputerVision #OpenCV #Python #AI',
      },
      {
        'username': 'data_scientist_lee',
        'location': '대구 데이터 사이언스팀',
        'avatar': 'assets/images/user_avatar_1.jpg',
        'image': 'assets/images/presentation_2.jpg',
        'likes': 432,
        'caption': '데이터 사이언스 워크샵 자료 공유합니다! 📈 #데이터사이언스 #워크샵 #프리젠테이션',
      },
      {
        'username': 'ai_lecturer_kang',
        'location': '서울 AI 아카데미',
        'avatar': 'assets/images/user_avatar_2.jpg',
        'image': 'assets/images/presentation_3.jpg',
        'likes': 678,
        'caption': 'AI 입문자를 위한 기초 강의 자료입니다! 🎓 #AI입문 #강의자료 #교육',
      },
      {
        'username': 'research_team_kim',
        'location': '대전 AI 연구센터',
        'avatar': 'assets/images/profile_avatar.jpg',
        'image': 'assets/images/presentation_4.jpg',
        'likes': 345,
        'caption': '최신 AI 연구 동향 발표 자료! 🔬 #AI연구 #트렌드 #발표자료',
      },
    ];

    return mockPosts.map((postData) {
      return PostCard(
        username: postData['username'],
        location: postData['location'],
        avatar: postData['avatar'],
        image: postData['image'],
        likes: postData['likes'],
        caption: postData['caption'],
        onLike: () {
          // TODO: Implement like functionality
        },
        onComment: () {
          // TODO: Navigate to comments
        },
        onShare: () {
          // TODO: Implement share functionality
        },
        onSave: () {
          // TODO: Implement save functionality
        },
      );
    }).toList();
  }
}
