import 'package:flutter/material.dart';
import 'package:sns_app/core/constants/app_colors.dart';
import 'package:sns_app/core/constants/app_typography.dart';

class AdvancedSettingsPage extends StatefulWidget {
  const AdvancedSettingsPage({super.key});

  @override
  State<AdvancedSettingsPage> createState() => _AdvancedSettingsPageState();
}

class _AdvancedSettingsPageState extends State<AdvancedSettingsPage> {
  bool _isPublic = true;
  bool _allowComments = true;
  bool _allowLikes = true;
  bool _allowShares = true;
  bool _hideFromExplore = false;
  bool _disableNotifications = false;
  String _selectedAudience = '모든 사용자';

  final List<String> _audienceOptions = [
    '모든 사용자',
    '팔로워만',
    '친구만',
    '나만',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          '고급설정',
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
            onPressed: () {
              Navigator.pop(context, {
                'isPublic': _isPublic,
                'allowComments': _allowComments,
                'allowLikes': _allowLikes,
                'allowShares': _allowShares,
                'hideFromExplore': _hideFromExplore,
                'disableNotifications': _disableNotifications,
                'audience': _selectedAudience,
              });
            },
            child: Text(
              '저장',
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
            // Privacy Settings
            _buildSectionHeader('개인정보 설정'),
            _buildSwitchTile(
              title: '공개 게시물',
              subtitle: '모든 사용자가 이 게시물을 볼 수 있습니다',
              value: _isPublic,
              onChanged: (value) {
                setState(() {
                  _isPublic = value;
                });
              },
            ),
            _buildDropdownTile(
              title: '대상',
              subtitle: '게시물을 볼 수 있는 사용자',
              value: _selectedAudience,
              items: _audienceOptions,
              onChanged: (value) {
                setState(() {
                  _selectedAudience = value!;
                });
              },
            ),

            const SizedBox(height: 24),

            // Interaction Settings
            _buildSectionHeader('상호작용 설정'),
            _buildSwitchTile(
              title: '댓글 허용',
              subtitle: '사용자가 댓글을 달 수 있습니다',
              value: _allowComments,
              onChanged: (value) {
                setState(() {
                  _allowComments = value;
                });
              },
            ),
            _buildSwitchTile(
              title: '좋아요 허용',
              subtitle: '사용자가 좋아요를 누를 수 있습니다',
              value: _allowLikes,
              onChanged: (value) {
                setState(() {
                  _allowLikes = value;
                });
              },
            ),
            _buildSwitchTile(
              title: '공유 허용',
              subtitle: '사용자가 게시물을 공유할 수 있습니다',
              value: _allowShares,
              onChanged: (value) {
                setState(() {
                  _allowShares = value;
                });
              },
            ),

            const SizedBox(height: 24),

            // Visibility Settings
            _buildSectionHeader('표시 설정'),
            _buildSwitchTile(
              title: '탐색에서 숨기기',
              subtitle: '탐색 탭에 게시물이 표시되지 않습니다',
              value: _hideFromExplore,
              onChanged: (value) {
                setState(() {
                  _hideFromExplore = value;
                });
              },
            ),

            const SizedBox(height: 24),

            // Notification Settings
            _buildSectionHeader('알림 설정'),
            _buildSwitchTile(
              title: '알림 비활성화',
              subtitle: '이 게시물에 대한 알림을 받지 않습니다',
              value: _disableNotifications,
              onChanged: (value) {
                setState(() {
                  _disableNotifications = value;
                });
              },
            ),

            const SizedBox(height: 24),

            // Additional Options
            _buildSectionHeader('추가 옵션'),
            _buildListTile(
              title: '게시물 편집',
              subtitle: '게시물 내용을 수정합니다',
              icon: Icons.edit,
              onTap: () {
                // TODO: Implement edit functionality
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('편집 기능은 준비 중입니다')),
                );
              },
            ),
            _buildListTile(
              title: '게시물 삭제',
              subtitle: '게시물을 영구적으로 삭제합니다',
              icon: Icons.delete,
              onTap: () {
                _showDeleteConfirmation();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: AppTypography.body1.copyWith(
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: SwitchListTile(
        title: Text(
          title,
          style: AppTypography.body1.copyWith(
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: AppTypography.body2.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.primary,
      ),
    );
  }

  Widget _buildDropdownTile({
    required String title,
    required String subtitle,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTypography.body1.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: AppTypography.body2.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: value,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColors.primary),
              ),
            ),
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildListTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(
          title,
          style: AppTypography.body1.copyWith(
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: AppTypography.body2.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('게시물 삭제'),
        content: const Text('이 게시물을 삭제하시겠습니까? 이 작업은 되돌릴 수 없습니다.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement delete functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('게시물이 삭제되었습니다')),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('삭제'),
          ),
        ],
      ),
    );
  }
}
