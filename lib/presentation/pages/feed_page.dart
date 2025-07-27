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
          'AI TOOL 개발자',
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
        'username': 'ai_tool_developer_kim',
        'location': '서울 송파구 AI TOOL 연구소',
        'avatar': 'assets/images/mcp_developer.jpg',
        'image': 'assets/images/mcp_tool.jpg',
        'likes': 245,
        'caption': '새로운 MCP AI TOOL 개발 완료! 🛠️ #MCP #AITOOL #개발 #플러그인 #자동화',
      },
      {
        'username': 'ai_tool_expert_choi',
        'location': '서울 강남구 AI TOOL 컨퍼런스',
        'avatar': 'assets/images/llm_expert.jpg',
        'image': 'assets/images/llm_presentation.jpg',
        'likes': 189,
        'caption':
            '오늘 LLM AI TOOL 컨퍼런스에서 발표한 내용입니다! 📊 #LLM #AITOOL컨퍼런스 #프리젠테이션 #기술공유',
      },
      {
        'username': 'ai_tool_engineer_park',
        'location': '서울 강동구 AI TOOL 엔지니어링팀',
        'avatar': 'assets/images/cursor_engineer.jpg',
        'image': 'assets/images/cursor_tool.jpg',
        'likes': 567,
        'caption':
            'Cursor AI TOOL 플러그인 프로젝트 완성! 🔌 #Cursor #AITOOL #플러그인 #개발 #자동화',
      },
      {
        'username': 'ai_tool_scientist_lee',
        'location': '서울 마천동 AI TOOL 사이언스팀',
        'avatar': 'assets/images/n8n_scientist.jpg',
        'image': 'assets/images/n8n_workflow.jpg',
        'likes': 432,
        'caption':
            'n8n AI TOOL 개발 워크샵 자료 공유합니다! 📈 #n8n #AITOOL개발 #워크샵 #프리젠테이션',
      },
      {
        'username': 'ai_tool_lecturer_kang',
        'location': '서울 송파구 AI TOOL 아카데미',
        'avatar': 'assets/images/claude_lecturer.jpg',
        'image': 'assets/images/claude_tutorial.jpg',
        'likes': 678,
        'caption':
            'Claude AI TOOL 입문자를 위한 기초 강의 자료입니다! 🎓 #Claude #AITOOL입문 #강의자료 #교육',
      },
      {
        'username': 'ai_tool_team_kim',
        'location': '서울 강남구 AI TOOL 연구센터',
        'avatar': 'assets/images/ai_tool_team.jpg',
        'image': 'assets/images/ai_tool_dashboard.jpg',
        'likes': 345,
        'caption': '최신 AI TOOL 개발 동향 발표 자료! 🔬 #AITOOL개발 #트렌드 #발표자료',
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
