import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sns_app/core/constants/app_colors.dart';
import 'package:sns_app/core/constants/app_typography.dart';

class CreatePostPage extends ConsumerStatefulWidget {
  const CreatePostPage({super.key});

  @override
  ConsumerState<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends ConsumerState<CreatePostPage> {
  final TextEditingController _captionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  String? _selectedImagePath;
  bool _isLoading = false;
  bool _isPublic = true;

  @override
  void dispose() {
    _captionController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _selectImage() {
    showModalBottomSheet(
      context: context,
      builder: (context) => _buildImageSourceBottomSheet(),
    );
  }

  Widget _buildImageSourceBottomSheet() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt, color: AppColors.primary),
            title: Text('카메라로 촬영', style: AppTypography.body1),
            onTap: () {
              Navigator.pop(context);
              _openCamera();
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library, color: AppColors.primary),
            title: Text('갤러리에서 선택', style: AppTypography.body1),
            onTap: () {
              Navigator.pop(context);
              _openGallery();
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  void _openCamera() {
    // TODO: Implement camera functionality
    setState(() {
      _selectedImagePath = 'assets/images/sample_post_1.jpg';
    });
  }

  void _openGallery() {
    // TODO: Implement gallery picker
    setState(() {
      _selectedImagePath = 'assets/images/sample_post_2.jpg';
    });
  }

  void _createPost() async {
    if (_selectedImagePath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('이미지를 선택해주세요.'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // TODO: Implement post creation
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('게시물이 성공적으로 업로드되었습니다!'),
          backgroundColor: AppColors.success,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          '새 게시물',
          style: AppTypography.headline3.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _createPost,
            child: Text(
              '공유',
              style: AppTypography.button.copyWith(
                color: _isLoading ? AppColors.textSecondary : AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Image Selection Area
          _buildImageSelectionArea(),

          // Post Details
          Expanded(child: _buildPostDetails()),
        ],
      ),
    );
  }

  Widget _buildImageSelectionArea() {
    return Container(
      height: 300,
      width: double.infinity,
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: AppColors.textTertiary),
      ),
      child: _selectedImagePath != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                _selectedImagePath!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add_photo_alternate_outlined,
                  size: 64,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(height: 16),
                Text(
                  '사진이나 동영상을 선택하세요',
                  style: AppTypography.body2.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: _selectImage,
                  icon: const Icon(Icons.add),
                  label: const Text('선택'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildPostDetails() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Caption
          TextField(
            controller: _captionController,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: '문구 입력...',
              hintStyle: AppTypography.body2.copyWith(
                color: AppColors.textSecondary,
              ),
              border: InputBorder.none,
            ),
            style: AppTypography.body2.copyWith(color: AppColors.textPrimary),
          ),

          const Divider(),

          // Location
          ListTile(
            leading: const Icon(
              Icons.location_on_outlined,
              color: AppColors.textSecondary,
            ),
            title: TextField(
              controller: _locationController,
              decoration: InputDecoration(
                hintText: '위치 추가',
                hintStyle: AppTypography.body2.copyWith(
                  color: AppColors.textSecondary,
                ),
                border: InputBorder.none,
              ),
              style: AppTypography.body2.copyWith(color: AppColors.textPrimary),
            ),
            onTap: () {
              // TODO: Implement location picker
            },
          ),

          const Divider(),

          // Privacy Settings
          ListTile(
            leading: const Icon(Icons.public, color: AppColors.textSecondary),
            title: Text(
              '공개 설정',
              style: AppTypography.body2.copyWith(color: AppColors.textPrimary),
            ),
            subtitle: Text(
              _isPublic ? '모든 사용자' : '팔로워만',
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            trailing: Switch(
              value: _isPublic,
              onChanged: (value) {
                setState(() {
                  _isPublic = value;
                });
              },
              activeColor: AppColors.primary,
            ),
          ),

          const Divider(),

          // Advanced Options
          ListTile(
            leading: const Icon(Icons.tune, color: AppColors.textSecondary),
            title: Text(
              '고급 설정',
              style: AppTypography.body2.copyWith(color: AppColors.textPrimary),
            ),
            trailing: const Icon(
              Icons.chevron_right,
              color: AppColors.textSecondary,
            ),
            onTap: () {
              // TODO: Show advanced options
            },
          ),

          const Spacer(),

          // Loading indicator
          if (_isLoading)
            const Center(
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('게시물을 업로드하는 중...'),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
