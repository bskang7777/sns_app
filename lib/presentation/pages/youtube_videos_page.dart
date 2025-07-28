import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sns_app/core/constants/app_colors.dart';
import 'package:sns_app/core/constants/app_typography.dart';
import 'package:sns_app/core/models/youtube_video.dart';
import 'package:sns_app/core/services/youtube_service.dart';

class YouTubeVideosPage extends ConsumerStatefulWidget {
  const YouTubeVideosPage({super.key});

  @override
  ConsumerState<YouTubeVideosPage> createState() => _YouTubeVideosPageState();
}

class _YouTubeVideosPageState extends ConsumerState<YouTubeVideosPage>
    with TickerProviderStateMixin {
  List<YouTubeVideo> _videos = [];
  List<YouTubeVideo> _filteredVideos = [];
  String _selectedCategory = '전체';
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  // 애니메이션 컨트롤러들
  late AnimationController _searchAnimationController;
  late AnimationController _pulseAnimationController;
  late AnimationController _categoryAnimationController;
  late Animation<double> _searchRotationAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _categoryScaleAnimation;

  @override
  void initState() {
    super.initState();
    _loadVideos();
    _initializeAnimations();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchAnimationController.dispose();
    _pulseAnimationController.dispose();
    _categoryAnimationController.dispose();
    super.dispose();
  }

  void _initializeAnimations() {
    // 검색 애니메이션
    _searchAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _searchRotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.25,
    ).animate(CurvedAnimation(
      parent: _searchAnimationController,
      curve: Curves.easeInOut,
    ));

    // 펄스 애니메이션
    _pulseAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseAnimationController,
      curve: Curves.easeInOut,
    ));

    // 카테고리 애니메이션
    _categoryAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _categoryScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _categoryAnimationController,
      curve: Curves.easeInOut,
    ));

    // 펄스 애니메이션 반복
    _pulseAnimationController.repeat(reverse: true);
  }

  void _loadVideos() {
    setState(() {
      _videos = YouTubeService.getAllVideos();
      _filteredVideos = _videos;
    });
  }

  void _filterVideos() {
    setState(() {
      if (_selectedCategory == '전체') {
        _filteredVideos = _videos;
      } else {
        _filteredVideos = YouTubeService.getVideosByCategory(_selectedCategory);
      }

      if (_searchController.text.isNotEmpty) {
        _filteredVideos = YouTubeService.searchVideos(_searchController.text);
      }
    });
  }

  void _playVideo(YouTubeVideo video) async {
    // 펄스 애니메이션 트리거
    _pulseAnimationController.forward().then((_) {
      _pulseAnimationController.reverse();
    });

    // 사용자에게 피드백 제공
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${video.title} 재생 중...'),
          duration: const Duration(seconds: 2),
          backgroundColor: AppColors.primary,
        ),
      );
    }

    // 웹에서는 새 탭에서 열기, 모바일에서는 외부 앱 실행
    final url = video.youtubeUrl;
    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(
          Uri.parse(url),
          mode: LaunchMode.externalApplication,
        );
      } else {
        // 웹에서는 새 탭에서 열기
        await launchUrl(
          Uri.parse(url),
          mode: LaunchMode.externalApplication,
        );
      }
    } catch (e) {
      // 에러 발생 시 브라우저에서 열기
      await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      );
    }
  }

  void _openInYouTube(YouTubeVideo video) async {
    final url = video.youtubeUrl;
    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(
          Uri.parse(url),
          mode: LaunchMode.externalApplication,
        );
      } else {
        // 웹에서는 새 탭에서 열기
        await launchUrl(
          Uri.parse(url),
          mode: LaunchMode.externalApplication,
        );
      }
    } catch (e) {
      // 에러 발생 시 브라우저에서 열기
      await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      );
    }
  }

  void _onSearchTap() {
    _searchAnimationController.forward().then((_) {
      _searchAnimationController.reverse();
    });
    setState(() {
      _isSearching = !_isSearching;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'AI YouTube 동영상',
          style: AppTypography.headline3.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
        actions: [
          AnimatedBuilder(
            animation: _searchRotationAnimation,
            builder: (context, child) {
              return Transform.rotate(
                angle: _searchRotationAnimation.value * 2 * 3.14159,
                child: IconButton(
                  icon: Icon(
                    _isSearching ? Icons.close : Icons.search,
                    color: AppColors.textPrimary,
                  ),
                  onPressed: _onSearchTap,
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // 카테고리 필터
          _buildCategoryFilter(),

          // 검색바 (검색 모드일 때만 표시)
          if (_isSearching) _buildSearchBar(),

          // 동영상 목록
          Expanded(child: _buildVideoList()),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    final categories = ['전체', 'AI'];

    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = _selectedCategory == category;

          return AnimatedBuilder(
            animation: _categoryScaleAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: isSelected ? _categoryScaleAnimation.value : 1.0,
                child: Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(
                      category,
                      style: AppTypography.caption.copyWith(
                        color:
                            isSelected ? Colors.white : AppColors.textPrimary,
                      ),
                    ),
                    selected: isSelected,
                    onSelected: (selected) {
                      _categoryAnimationController.forward().then((_) {
                        _categoryAnimationController.reverse();
                      });
                      setState(() {
                        _selectedCategory = category;
                      });
                      _filterVideos();
                    },
                    backgroundColor: AppColors.backgroundSecondary,
                    selectedColor: AppColors.primary,
                    checkmarkColor: Colors.white,
                    elevation: isSelected ? 4 : 1,
                    shadowColor: AppColors.primary.withOpacity(0.3),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildSearchBar() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 60,
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _searchController,
        onChanged: (value) => _filterVideos(),
        decoration: InputDecoration(
          hintText: '동영상 검색...',
          hintStyle: AppTypography.body2.copyWith(
            color: AppColors.textSecondary,
          ),
          prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
          filled: true,
          fillColor: AppColors.backgroundSecondary,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        style: AppTypography.body2.copyWith(color: AppColors.textPrimary),
      ),
    );
  }

  Widget _buildVideoList() {
    if (_filteredVideos.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.video_library_outlined,
              size: 64,
              color: AppColors.textSecondary,
            ),
            const SizedBox(height: 16),
            Text(
              '동영상을 찾을 수 없습니다',
              style: AppTypography.body1.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _filteredVideos.length,
      itemBuilder: (context, index) {
        final video = _filteredVideos[index];
        return _buildVideoCard(video);
      },
    );
  }

  Widget _buildVideoCard(YouTubeVideo video) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => _playVideo(video),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 썸네일과 재생 버튼
              Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.network(
                      video.thumbnailUrl,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: double.infinity,
                          height: 200,
                          color: AppColors.textTertiary,
                          child: const Icon(
                            Icons.video_library_outlined,
                            size: 48,
                            color: AppColors.textSecondary,
                          ),
                        );
                      },
                    ),
                  ),
                  // 재생 버튼 (펄스 애니메이션)
                  Positioned.fill(
                    child: Center(
                      child: AnimatedBuilder(
                        animation: _pulseAnimation,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _pulseAnimation.value,
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary.withOpacity(0.3),
                                    blurRadius: 8,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  // 재생 오버레이
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12)),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.3),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // 동영상 정보
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      video.title,
                      style: AppTypography.body1.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            video.category,
                            style: AppTypography.caption.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          _formatDate(video.dateAdded),
                          style: AppTypography.caption.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => _playVideo(video),
                            icon: const Icon(Icons.play_arrow, size: 18),
                            label: const Text('재생'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 2,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => _openInYouTube(video),
                            icon: const Icon(Icons.open_in_new, size: 18),
                            label: const Text('YouTube'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.primary,
                              side: BorderSide(color: AppColors.primary),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return '오늘';
    } else if (difference.inDays == 1) {
      return '어제';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}일 전';
    } else if (difference.inDays < 30) {
      return '${(difference.inDays / 7).floor()}주 전';
    } else {
      return '${date.month}월 ${date.day}일';
    }
  }
}

// 검색 델리게이트
class VideoSearchDelegate extends SearchDelegate<String> {
  final List<YouTubeVideo> videos;

  VideoSearchDelegate(this.videos);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    final filteredVideos = videos
        .where(
            (video) => video.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filteredVideos.length,
      itemBuilder: (context, index) {
        final video = filteredVideos[index];
        return ListTile(
          title: Text(video.title),
          subtitle: Text(video.category),
          leading: Image.network(
            video.thumbnailUrl,
            width: 60,
            height: 45,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 60,
                height: 45,
                color: AppColors.textTertiary,
                child: const Icon(Icons.video_library_outlined),
              );
            },
          ),
          onTap: () {
            close(context, video.id);
          },
        );
      },
    );
  }
}
