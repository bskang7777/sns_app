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
          'Instagram',
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
        'username': 'travel_lover',
        'location': 'Seoul, Korea',
        'avatar': 'assets/images/user_avatar_1.jpg',
        'image': 'assets/images/sample_post_1.jpg',
        'likes': 245,
        'caption': '아름다운 서울의 봄날 🌸 #서울 #봄 #여행',
      },
      {
        'username': 'food_enthusiast',
        'location': 'Busan, Korea',
        'avatar': 'assets/images/user_avatar_2.jpg',
        'image': 'assets/images/sample_post_2.jpg',
        'likes': 189,
        'caption': '부산 해산물의 맛! 🦐 #부산 #해산물 #맛집',
      },
      {
        'username': 'nature_photographer',
        'location': 'Jeju Island',
        'avatar': 'assets/images/profile_avatar.jpg',
        'image': 'assets/images/sample_post_3.jpg',
        'likes': 567,
        'caption': '제주도의 아름다운 자연 🌿 #제주 #자연 #사진',
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
