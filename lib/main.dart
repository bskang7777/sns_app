import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sns_app/core/constants/app_colors.dart';
import 'package:sns_app/core/constants/app_typography.dart';
import 'package:sns_app/presentation/pages/feed_page.dart';
import 'package:sns_app/presentation/pages/explore_page.dart';
import 'package:sns_app/presentation/pages/create_post_page.dart';
import 'package:sns_app/presentation/pages/activity_page.dart';
import 'package:sns_app/presentation/pages/profile_page.dart';
import 'package:sns_app/presentation/pages/presentation_page.dart';
import 'package:sns_app/presentation/pages/youtube_videos_page.dart';
import 'package:sns_app/presentation/pages/auth/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // TODO: Firebase 초기화는 실제 프로덕션에서 활성화
  // Firebase와 Google 로그인을 위한 구조는 이미 구현되어 있음

  runApp(const ProviderScope(child: SnsApp()));
}

class SnsApp extends StatelessWidget {
  const SnsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SNS App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.background,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.textPrimary),
          titleTextStyle: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        textTheme: const TextTheme(
          displayLarge: AppTypography.headline1,
          displayMedium: AppTypography.headline2,
          displaySmall: AppTypography.headline3,
          bodyLarge: AppTypography.body1,
          bodyMedium: AppTypography.body2,
          bodySmall: AppTypography.caption,
          labelLarge: AppTypography.button,
          labelSmall: AppTypography.overline,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          background: AppColors.background,
          surface: AppColors.background,
          onBackground: AppColors.textPrimary,
          onSurface: AppColors.textPrimary,
        ),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  final List<Widget> _pages = [
    const FeedPage(),
    const ExplorePage(),
    const CreatePostPage(),
    const YouTubeVideosPage(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.9,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    _animationController.forward().then((_) {
      _animationController.reverse();
    });
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.background,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, Icons.home_outlined, Icons.home, '홈'),
                _buildNavItem(1, Icons.search_outlined, Icons.search, '탐색'),
                _buildNavItem(2, Icons.add_box_outlined, Icons.add_box, '게시물'),
                _buildNavItem(3, Icons.video_library_outlined,
                    Icons.video_library, '동영상'),
                _buildNavItem(4, Icons.person_outline, Icons.person, '프로필'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
      int index, IconData inactiveIcon, IconData activeIcon, String label) {
    final isSelected = _currentIndex == index;

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: isSelected ? _scaleAnimation.value : 1.0,
          child: GestureDetector(
            onTapDown: (_) {
              if (isSelected) {
                _animationController.forward().then((_) {
                  _animationController.reverse();
                });
              }
            },
            onTap: () => _onTabTapped(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary.withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    children: [
                      Icon(
                        isSelected ? activeIcon : inactiveIcon,
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.textSecondary,
                        size: 24,
                      ),
                      // 새 알림 배지 (동영상 탭에만)
                      if (index == 3 && !isSelected)
                        Positioned(
                          right: -2,
                          top: -2,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    label,
                    style: AppTypography.caption.copyWith(
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.textSecondary,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
