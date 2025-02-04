// lib/presentation/widgets/header/app_header.dart
import 'package:flutter/material.dart';
import 'package:flutter_ui/core/theme/app_color.dart';
import 'package:flutter_ui/core/theme/text_styles.dart';
class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.2),
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Page Title
          const Text(
            'Dashboard',
            style: TextStyles.heading2,
          ),
          const SizedBox(width: 40),
          
          // Search Bar
          _buildSearchBar(),
          
          // Action Buttons Section
          _buildActionButtons(),
          
          // Profile Menu
          _buildProfileMenu(),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Expanded(
      child: Container(
        height: 40,
        constraints: const BoxConstraints(maxWidth: 500),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.grey.withOpacity(0.2),
          ),
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(
              color: Colors.grey[400],
              fontSize: 14,
            ),
            prefixIcon: Icon(
              Icons.search_rounded,
              color: Colors.grey[400],
              size: 20,
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
          cursorColor: AppColors.primary,
          onChanged: (value) {
            // Implement search functionality
          },
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        const SizedBox(width: 24),
        _buildNotificationButton(
          icon: Icons.notifications_none_rounded,
          badge: '3',
          onTap: () {
            // Handle notifications
          },
        ),
        const SizedBox(width: 16),
        _buildNotificationButton(
          icon: Icons.email_outlined,
          badge: '5',
          onTap: () {
            // Handle messages
          },
        ),
        const SizedBox(width: 24),
      ],
    );
  }

  Widget _buildNotificationButton({
    required IconData icon,
    required String badge,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: Colors.grey[400],
                size: 22,
              ),
            ),
            if (badge.isNotEmpty)
              Positioned(
                right: 4,
                top: 4,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.error,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.cardBackground,
                      width: 2,
                    ),
                  ),
                  child: Text(
                    badge,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileMenu() {
    return PopupMenuButton<String>(
      offset: const Offset(0, 56),
      position: PopupMenuPosition.under,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: AppColors.cardBackground,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.grey.withOpacity(0.2),
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: AppColors.primary.withOpacity(0.1),
              child: const Text(
                'JD',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'John Doe',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Administrator',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Colors.grey[400],
              size: 20,
            ),
          ],
        ),
      ),
      itemBuilder: (context) => <PopupMenuEntry<String>>[
        _buildPopupMenuItem(
          value: 'profile',
          icon: Icons.person_outline_rounded,
          title: 'My Profile',
        ),
        _buildPopupMenuItem(
          value: 'settings',
          icon: Icons.settings_outlined,
          title: 'Settings',
        ),
        _buildPopupMenuItem(
          value: 'help',
          icon: Icons.help_outline_rounded,
          title: 'Help Center',
        ),
        const PopupMenuDivider(height: 0.5),
        _buildPopupMenuItem(
          value: 'logout',
          icon: Icons.logout_rounded,
          title: 'Log Out',
          isDestructive: true,
        ),
      ],
      onSelected: (value) {
        switch (value) {
          case 'profile':
            // Handle profile action
            break;
          case 'settings':
            // Handle settings action
            break;
          case 'help':
            // Handle help action
            break;
          case 'logout':
            // Handle logout action
            break;
        }
      },
    );
  }

  PopupMenuItem<String> _buildPopupMenuItem({
    required String value,
    required IconData icon,
    required String title,
    bool isDestructive = false,
  }) {
    return PopupMenuItem<String>(
      value: value,
      height: 40,
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: isDestructive ? AppColors.error : Colors.grey[400],
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(
              color: isDestructive ? AppColors.error : Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}