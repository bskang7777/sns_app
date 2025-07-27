import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sns_app/core/constants/app_colors.dart';
import 'package:sns_app/core/constants/app_typography.dart';
import 'package:sns_app/core/utils/permission_utils.dart';
import 'dart:io';

class CreatePostPage extends ConsumerStatefulWidget {
  const CreatePostPage({super.key});

  @override
  ConsumerState<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends ConsumerState<CreatePostPage> {
  final TextEditingController _captionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
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
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.camera_alt,
                  color: AppColors.primary, size: 24),
            ),
            title: Text('카메라로 촬영',
                style:
                    AppTypography.body1.copyWith(fontWeight: FontWeight.w600)),
            subtitle: Text('새로운 사진을 촬영합니다', style: AppTypography.caption),
            onTap: () {
              Navigator.pop(context);
              _openCamera();
            },
          ),
          const SizedBox(height: 8),
          ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.photo_library,
                  color: AppColors.primary, size: 24),
            ),
            title: Text('갤러리에서 선택',
                style:
                    AppTypography.body1.copyWith(fontWeight: FontWeight.w600)),
            subtitle: Text('기존 사진을 선택합니다', style: AppTypography.caption),
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

  void _openCamera() async {
    try {
      // 카메라 권한 확인
      final hasPermission = await PermissionUtils.hasCameraPermission();
      if (!hasPermission) {
        final granted = await PermissionUtils.requestCameraPermission();
        if (!granted) {
          if (mounted) {
            _showPermissionDialog('카메라');
          }
          return;
        }
      }

      // 카메라가 실제로 켜지는지 확인
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('카메라를 켜는 중...'),
            duration: Duration(seconds: 1),
            backgroundColor: AppColors.primary,
          ),
        );
      }

      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
        preferredCameraDevice: CameraDevice.rear, // 후면 카메라 우선
      );

      if (image != null) {
        setState(() {
          _selectedImagePath = image.path;
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('사진이 성공적으로 촬영되었습니다!'),
              backgroundColor: AppColors.success,
              duration: Duration(seconds: 2),
            ),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('사진 촬영이 취소되었습니다.'),
              backgroundColor: AppColors.textSecondary,
              duration: Duration(seconds: 1),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('카메라 오류: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  void _openGallery() async {
    try {
      // 갤러리 권한 확인
      final hasPermission = await PermissionUtils.hasGalleryPermission();
      if (!hasPermission) {
        final granted = await PermissionUtils.requestGalleryPermission();
        if (!granted) {
          if (mounted) {
            _showPermissionDialog('갤러리');
          }
          return;
        }
      }

      // 갤러리 열기 중 메시지
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('갤러리를 여는 중...'),
            duration: Duration(seconds: 1),
            backgroundColor: AppColors.primary,
          ),
        );
      }

      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _selectedImagePath = image.path;
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('이미지가 성공적으로 선택되었습니다!'),
              backgroundColor: AppColors.success,
              duration: Duration(seconds: 2),
            ),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('이미지 선택이 취소되었습니다.'),
              backgroundColor: AppColors.textSecondary,
              duration: Duration(seconds: 1),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('갤러리 오류: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  void _showPermissionDialog(String permissionName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('권한 필요'),
        content: Text('$permissionName 접근 권한이 필요합니다. 설정에서 권한을 허용해주세요.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              PermissionUtils.openAppSettings();
            },
            child: const Text('설정으로 이동'),
          ),
        ],
      ),
    );
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image Selection Area
            _buildImageSelectionArea(),

            // Post Details
            _buildPostDetails(),
          ],
        ),
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
          ? Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: _selectedImagePath!.startsWith('assets/')
                      ? Image.asset(
                          _selectedImagePath!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        )
                      : Image.file(
                          File(_selectedImagePath!),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedImagePath = null;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.black54,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.add_photo_alternate_outlined,
                    size: 48,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  '사진이나 동영상을 선택하세요',
                  style: AppTypography.body2.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '카메라로 촬영하거나 갤러리에서 선택할 수 있습니다',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textTertiary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: _selectImage,
                  icon: const Icon(Icons.add_a_photo, size: 20),
                  label: const Text('이미지 선택'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
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
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.location_on_outlined,
                color: AppColors.primary,
                size: 20,
              ),
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
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                _isPublic ? Icons.public : Icons.people,
                color: AppColors.primary,
                size: 20,
              ),
            ),
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
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.tune,
                color: AppColors.primary,
                size: 20,
              ),
            ),
            title: Text(
              '고급 설정',
              style: AppTypography.body2.copyWith(color: AppColors.textPrimary),
            ),
            subtitle: Text(
              '콘텐츠 유형, 태그 등',
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            trailing: const Icon(
              Icons.chevron_right,
              color: AppColors.textSecondary,
            ),
            onTap: () {
              // TODO: Show advanced options
            },
          ),

          const SizedBox(height: 100),

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

  Widget _buildAdvancedOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '고급 옵션',
          style: AppTypography.body1.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),

        // Content Type Selection
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.backgroundSecondary,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.textTertiary),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '콘텐츠 유형',
                style: AppTypography.body2.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  _buildContentTypeChip('AI 프로젝트', true),
                  _buildContentTypeChip('프리젠테이션', false),
                  _buildContentTypeChip('코드 스니펫', false),
                  _buildContentTypeChip('연구 결과', false),
                  _buildContentTypeChip('강의 자료', false),
                  _buildContentTypeChip('컨퍼런스', false),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Presentation Options
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.backgroundSecondary,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.textTertiary),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '프리젠테이션 옵션',
                style: AppTypography.body2.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),

              // Slide Count
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '슬라이드 수',
                      style: AppTypography.body2.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: AppColors.textTertiary),
                    ),
                    child: Text(
                      '15장',
                      style: AppTypography.body2.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Presentation Duration
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '발표 시간',
                      style: AppTypography.body2.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: AppColors.textTertiary),
                    ),
                    child: Text(
                      '30분',
                      style: AppTypography.body2.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Conference Info
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '컨퍼런스',
                      style: AppTypography.body2.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: AppColors.textTertiary),
                    ),
                    child: Text(
                      '부산 AI 컨퍼런스 2024',
                      style: AppTypography.body2.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Code Snippet Options
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.backgroundSecondary,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.textTertiary),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '코드 스니펫 옵션',
                style: AppTypography.body2.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),

              // Programming Language
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '프로그래밍 언어',
                      style: AppTypography.body2.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: AppColors.textTertiary),
                    ),
                    child: Text(
                      'Python',
                      style: AppTypography.body2.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Framework
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '프레임워크',
                      style: AppTypography.body2.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: AppColors.textTertiary),
                    ),
                    child: Text(
                      'TensorFlow',
                      style: AppTypography.body2.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContentTypeChip(String label, bool isSelected) {
    return FilterChip(
      label: Text(
        label,
        style: AppTypography.caption.copyWith(
          color: isSelected ? Colors.white : AppColors.textPrimary,
        ),
      ),
      selected: isSelected,
      onSelected: (selected) {
        // TODO: Implement content type selection
      },
      backgroundColor: AppColors.background,
      selectedColor: AppColors.primary,
      checkmarkColor: Colors.white,
      side: BorderSide(
        color: isSelected ? AppColors.primary : AppColors.textTertiary,
      ),
    );
  }
}
