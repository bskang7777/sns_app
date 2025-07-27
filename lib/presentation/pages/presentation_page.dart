import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sns_app/core/constants/app_colors.dart';
import 'package:sns_app/core/constants/app_typography.dart';

class PresentationPage extends ConsumerStatefulWidget {
  const PresentationPage({super.key});

  @override
  ConsumerState<PresentationPage> createState() => _PresentationPageState();
}

class _PresentationPageState extends ConsumerState<PresentationPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _launchYouTube(String videoId) async {
    final url = 'https://www.youtube.com/watch?v=$videoId';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'AI TOOL 모임 프리젠테이션',
          style: AppTypography.headline3.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // TODO: Implement refresh
        },
        child: ListView(
          controller: _scrollController,
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            _buildUpcomingPresentations(),
            const SizedBox(height: 24),
            _buildPastPresentations(),
            const SizedBox(height: 24),
            _buildVideoTutorials(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primary.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'AI TOOL 개발자 모임',
            style: AppTypography.headline2.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '서울 지역 AI TOOL 개발자들의 지식 공유 플랫폼',
            style: AppTypography.body1.copyWith(
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildStatItem('총 모임', '24회'),
              const SizedBox(width: 24),
              _buildStatItem('참여자', '156명'),
              const SizedBox(width: 24),
              _buildStatItem('발표자', '18명'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: AppTypography.headline3.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: AppTypography.caption.copyWith(
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildUpcomingPresentations() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '다음 모임',
          style: AppTypography.headline3.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildPresentationCard(
          title: 'MCP AI TOOL 개발 실전',
          presenter: '김MCP개발자',
          date: '2024년 1월 15일',
          location: '서울 송파구 AI TOOL 연구소',
          image: 'assets/images/mcp_tool.jpg',
          description:
              'Model Context Protocol을 활용한 AI TOOL 개발 방법과 실제 구현 사례를 공유합니다.',
          isUpcoming: true,
        ),
        const SizedBox(height: 12),
        _buildPresentationCard(
          title: 'LLM 기반 코드 생성 도구',
          presenter: '최LLM전문가',
          date: '2024년 1월 22일',
          location: '서울 강남구 AI TOOL 컨퍼런스',
          image: 'assets/images/llm_presentation.jpg',
          description: 'GPT-4와 Claude를 활용한 코드 생성 및 리팩토링 도구 개발 경험을 나눕니다.',
          isUpcoming: true,
        ),
      ],
    );
  }

  Widget _buildPastPresentations() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '지난 모임',
          style: AppTypography.headline3.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildPresentationCard(
          title: 'Cursor AI 에디터 활용법',
          presenter: '박Cursor엔지니어',
          date: '2024년 1월 8일',
          location: '서울 강동구 AI TOOL 엔지니어링팀',
          image: 'assets/images/cursor_tool.jpg',
          description: 'Cursor AI 에디터의 고급 기능과 플러그인 개발 방법을 소개합니다.',
          isUpcoming: false,
          videoId: 'F8eUrnw5VD0',
        ),
        const SizedBox(height: 12),
        _buildPresentationCard(
          title: 'n8n 워크플로우 자동화',
          presenter: '이n8n과학자',
          date: '2024년 1월 1일',
          location: '서울 마천동 AI TOOL 사이언스팀',
          image: 'assets/images/n8n_workflow.jpg',
          description: 'n8n을 활용한 AI 워크플로우 자동화 및 API 연동 사례를 공유합니다.',
          isUpcoming: false,
          videoId: 'nz9BglylZMI',
        ),
      ],
    );
  }

  Widget _buildVideoTutorials() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'AI TOOL 튜토리얼',
          style: AppTypography.headline3.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildVideoCard(
          title: 'Claude AI 어시스턴트 활용법',
          presenter: '강Claude강사',
          image: 'assets/images/claude_tutorial.jpg',
          videoId: 'VHGhfEz7wcM',
          description: 'Claude AI를 활용한 코드 리뷰 및 개발 생산성 향상 방법을 배워봅니다.',
        ),
        const SizedBox(height: 12),
        _buildVideoCard(
          title: 'AI TOOL 대시보드 구축',
          presenter: '김AI팀장',
          image: 'assets/images/ai_tool_dashboard.jpg',
          videoId: 'Fh8M4BBLUws',
          description: '다양한 AI TOOL을 통합한 대시보드 구축 및 모니터링 시스템을 소개합니다.',
        ),
        const SizedBox(height: 12),
        _buildVideoCard(
          title: 'Google Slides에 AI TOOL 삽입하기',
          presenter: '이AI교육자',
          image: 'assets/images/llm_presentation.jpg',
          videoId: '6ef62lb3P88',
          description: 'Google Slides에 AI TOOL 관련 이미지와 동영상을 삽입하는 방법을 알려드립니다.',
        ),
      ],
    );
  }

  Widget _buildPresentationCard({
    required String title,
    required String presenter,
    required String date,
    required String location,
    required String image,
    required String description,
    required bool isUpcoming,
    String? videoId,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                children: [
                  Image.asset(
                    image,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  if (videoId != null)
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                        ),
                        child: Center(
                          child: GestureDetector(
                            onTap: () => _launchYouTube(videoId),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (isUpcoming)
                    Positioned(
                      top: 12,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '예정',
                          style: AppTypography.caption.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.headline3.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: AssetImage(
                        _getPresenterAvatar(presenter),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            presenter,
                            style: AppTypography.body2.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            location,
                            style: AppTypography.caption.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      date,
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  description,
                  style: AppTypography.body2.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    if (videoId != null)
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _launchYouTube(videoId),
                          icon: const Icon(Icons.play_circle_outline),
                          label: const Text('YouTube 보기'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                    if (videoId != null) const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          // TODO: Navigate to presentation detail
                        },
                        icon: const Icon(Icons.info_outline),
                        label: const Text('자세히 보기'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primary,
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
    );
  }

  Widget _buildVideoCard({
    required String title,
    required String presenter,
    required String image,
    required String videoId,
    required String description,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: GestureDetector(
                onTap: () => _launchYouTube(videoId),
                child: Stack(
                  children: [
                    Image.asset(
                      image,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                        ),
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.headline3.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: AssetImage(
                        _getPresenterAvatar(presenter),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        presenter,
                        style: AppTypography.body2.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '튜토리얼',
                        style: AppTypography.caption.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  description,
                  style: AppTypography.body2.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => _launchYouTube(videoId),
                    icon: const Icon(Icons.play_circle_outline),
                    label: const Text('YouTube에서 보기'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getPresenterAvatar(String presenter) {
    if (presenter.contains('MCP')) return 'assets/images/mcp_developer.jpg';
    if (presenter.contains('LLM')) return 'assets/images/llm_expert.jpg';
    if (presenter.contains('Cursor'))
      return 'assets/images/cursor_engineer.jpg';
    if (presenter.contains('n8n')) return 'assets/images/n8n_scientist.jpg';
    if (presenter.contains('Claude'))
      return 'assets/images/claude_lecturer.jpg';
    if (presenter.contains('AI팀')) return 'assets/images/ai_tool_team.jpg';
    if (presenter.contains('AI교육')) return 'assets/images/llm_expert.jpg';
    return 'assets/images/mcp_developer.jpg';
  }
}
