import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sns_app/core/constants/app_colors.dart';
import 'package:sns_app/core/constants/app_typography.dart';
import 'dart:io';

class SharePage extends StatefulWidget {
  final String? imagePath;
  final String? videoPath;
  final String caption;
  final String? location;

  const SharePage({
    super.key,
    this.imagePath,
    this.videoPath,
    required this.caption,
    this.location,
  });

  @override
  State<SharePage> createState() => _SharePageState();
}

class _SharePageState extends State<SharePage> {
  bool _isLoading = false;
  List<String> _selectedPlatforms = [];

  final List<Map<String, dynamic>> _sharePlatforms = [
    {
      'name': 'Instagram',
      'icon': Icons.camera_alt,
      'color': Colors.purple,
      'id': 'instagram',
    },
    {
      'name': 'Facebook',
      'icon': Icons.facebook,
      'color': Colors.blue,
      'id': 'facebook',
    },
    {
      'name': 'Twitter',
      'icon': Icons.flutter_dash,
      'color': Colors.lightBlue,
      'id': 'twitter',
    },
    {
      'name': 'KakaoTalk',
      'icon': Icons.chat,
      'color': Colors.yellow,
      'id': 'kakao',
    },
    {
      'name': 'Line',
      'icon': Icons.message,
      'color': Colors.green,
      'id': 'line',
    },
    {
      'name': 'Copy Link',
      'icon': Icons.link,
      'color': Colors.grey,
      'id': 'copy',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          '공유하기',
          style: AppTypography.headline3.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _shareContent,
            child: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(
                    '공유',
                    style: AppTypography.button.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Preview Section
            _buildPreviewSection(),

            const SizedBox(height: 24),

            // Share Platforms
            _buildSharePlatformsSection(),

            const SizedBox(height: 24),

            // Additional Options
            _buildAdditionalOptionsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildPreviewSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '미리보기',
            style: AppTypography.body1.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              // Media Preview
              if (widget.imagePath != null || widget.videoPath != null)
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[200],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: widget.imagePath != null
                        ? Image.file(
                            File(widget.imagePath!),
                            fit: BoxFit.cover,
                          )
                        : const Icon(
                            Icons.videocam,
                            size: 40,
                            color: Colors.grey,
                          ),
                  ),
                ),
              const SizedBox(width: 12),
              // Content Preview
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.caption.isNotEmpty)
                      Text(
                        widget.caption,
                        style: AppTypography.body2.copyWith(
                          color: AppColors.textPrimary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    if (widget.location != null) ...[
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 16,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            widget.location!,
                            style: AppTypography.caption.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSharePlatformsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '공유할 플랫폼',
          style: AppTypography.body1.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1,
          ),
          itemCount: _sharePlatforms.length,
          itemBuilder: (context, index) {
            final platform = _sharePlatforms[index];
            final isSelected = _selectedPlatforms.contains(platform['id']);

            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _selectedPlatforms.remove(platform['id']);
                  } else {
                    _selectedPlatforms.add(platform['id']);
                  }
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected
                      ? platform['color'].withOpacity(0.1)
                      : AppColors.background,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? platform['color'] : Colors.grey[300]!,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      platform['icon'],
                      color: platform['color'],
                      size: 32,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      platform['name'],
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildAdditionalOptionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '추가 옵션',
          style: AppTypography.body1.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Column(
            children: [
              SwitchListTile(
                title: const Text('위치 정보 포함'),
                subtitle: const Text('게시물에 위치 정보를 포함합니다'),
                value: widget.location != null,
                onChanged: (value) {
                  // TODO: Implement location toggle
                },
                activeColor: AppColors.primary,
              ),
              SwitchListTile(
                title: const Text('해시태그 자동 생성'),
                subtitle: const Text('AI가 자동으로 해시태그를 생성합니다'),
                value: false,
                onChanged: (value) {
                  // TODO: Implement hashtag generation
                },
                activeColor: AppColors.primary,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _shareContent() async {
    if (_selectedPlatforms.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('공유할 플랫폼을 선택해주세요')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // 공유할 텍스트 생성
      String shareText = widget.caption;
      if (widget.location != null) {
        shareText += '\n📍 ${widget.location}';
      }
      shareText += '\n\n#SNSApp #AI_TOOL_개발자';

      // 선택된 플랫폼에 따라 공유
      for (String platformId in _selectedPlatforms) {
        switch (platformId) {
          case 'copy':
            await Share.share(shareText);
            break;
          case 'instagram':
            // TODO: Instagram 공유 구현
            break;
          case 'facebook':
            // TODO: Facebook 공유 구현
            break;
          case 'twitter':
            // TODO: Twitter 공유 구현
            break;
          case 'kakao':
            // TODO: KakaoTalk 공유 구현
            break;
          case 'line':
            // TODO: Line 공유 구현
            break;
        }
      }

      // 성공 메시지
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('성공적으로 공유되었습니다!')),
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('공유 중 오류가 발생했습니다: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
