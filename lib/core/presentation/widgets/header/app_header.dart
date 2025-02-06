// lib/presentation/widgets/header/app_header.dart
import 'package:flutter/material.dart';
import 'package:flutter_ui/core/theme/app_color.dart';
import 'package:flutter_ui/core/theme/text_styles.dart';
// AppHeader klassi - asosiy header UI ni yaratadigan klass
class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 600;
        
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
            children: [
              // Left section - Always visible
              const Text('Dashboard', style: TextStyles.heading2),
              SizedBox(width: isSmallScreen ? 20 : 40),

              // Search bar - Hidden on small screens
              if (!isSmallScreen) 
                Expanded(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: _buildSearchBar(),
                  ),
                ),

              // Right section
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Only show notifications on medium and large screens
                  if (!isSmallScreen) ...[
                    _buildActionButtons(),
                    const SizedBox(width: 16),
                  ],
                  
                  // Profile menu - Simplified on small screens
                  isSmallScreen 
                    ? _buildSimpleProfileMenu() 
                    : _buildProfileMenu(),
                    
                  // Add search icon button on small screens
                  if (isSmallScreen) ...[
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: () {
                        // Show search dialog or navigate to search page
                      },
                      icon: Icon(
                        Icons.search_rounded,
                        color: Colors.grey[400],
                        size: 24,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        );
      }
    );
  }

  // Simplified profile menu for small screens
  Widget _buildSimpleProfileMenu() {
    return PopupMenuButton<String>(
      offset: const Offset(0, 56),
      position: PopupMenuPosition.under,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: AppColors.cardBackground,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
        ),
        child: CircleAvatar(
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
      ),
      itemBuilder: (context) => <PopupMenuEntry<String>>[
        _buildPopupMenuItem('profile', Icons.person_outline_rounded, 'My Profile'),
        _buildPopupMenuItem('notifications', Icons.notifications_none_rounded, 'Notifications'),
        _buildPopupMenuItem('messages', Icons.email_outlined, 'Messages'),
        _buildPopupMenuItem('settings', Icons.settings_outlined, 'Settings'),
        _buildPopupMenuItem('help', Icons.help_outline_rounded, 'Help Center'),
        const PopupMenuDivider(height: 0.5),
        _buildPopupMenuItem('logout', Icons.logout_rounded, 'Log Out', isDestructive: true),
      ],
      onSelected: (value) {
        // Handle menu item selection
      },
    );
  }

  // Original methods remain unchanged...
  Widget _buildSearchBar() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search...',
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
          prefixIcon: Icon(Icons.search_rounded, color: Colors.grey[400], size: 20),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        style: const TextStyle(color: Colors.white, fontSize: 14),
        cursorColor: AppColors.primary,
        onChanged: (value) {},
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildNotificationButton(
          icon: Icons.notifications_none_rounded,
          badge: '3',
          onTap: () {},
        ),
        const SizedBox(width: 16),
        _buildNotificationButton(
          icon: Icons.email_outlined,
          badge: '5',
          onTap: () {},
        ),
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
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(icon, color: Colors.grey[400], size: 22),
              if (badge.isNotEmpty)
                Positioned(
                  right: 4,
                  top: 4,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.error,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.cardBackground, width: 2),
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
      ),
    );
  }

  Widget _buildProfileMenu() {
    return PopupMenuButton<String>(
      offset: const Offset(0, 56),
      position: PopupMenuPosition.under,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: AppColors.cardBackground,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
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
                  style: TextStyle(color: Colors.grey[400], fontSize: 12),
                ),
              ],
            ),
            const SizedBox(width: 12),
            Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey[400], size: 20),
          ],
        ),
      ),
      itemBuilder: (context) => <PopupMenuEntry<String>>[
        _buildPopupMenuItem('profile', Icons.person_outline_rounded, 'My Profile'),
        _buildPopupMenuItem('settings', Icons.settings_outlined, 'Settings'),
        _buildPopupMenuItem('help', Icons.help_outline_rounded, 'Help Center'),
        const PopupMenuDivider(height: 0.5),
        _buildPopupMenuItem('logout', Icons.logout_rounded, 'Log Out', isDestructive: true),
      ],
      onSelected: (value) {
        switch (value) {
          case 'profile':
            break;
          case 'settings':
            break;
          case 'help':
            break;
          case 'logout':
            break;
        }
      },
    );
  }

  PopupMenuItem<String> _buildPopupMenuItem(
    String value,
    IconData icon,
    String title, {
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