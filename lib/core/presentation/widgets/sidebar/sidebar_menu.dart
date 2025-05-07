import 'package:flutter/material.dart';
import 'package:flutter_ui/core/light_theme/app_color.dart';

class SidebarMenu extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const SidebarMenu({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 1200;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: isSmallScreen ? 220 : 280,
      constraints: const BoxConstraints(
        minWidth: 220,
        maxWidth: 280,
      ),
      color: Colors.white, // Changed to white for light theme
      child: Column(
        children: [
          // Logo and Brand
          _buildLogoSection(isSmallScreen),
          const Divider(color: AppColors.border, height: 1),

          // Menu Items
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: isSmallScreen ? 8 : 16,
                ),
                child: Column(
                  children: [
                    _buildMenuSection(isSmallScreen),
                    _buildDivider(),
                    _buildWorkspaceSection(isSmallScreen),
                    _buildDivider(),
                    _buildTeamSection(isSmallScreen),
                  ],
                ),
              ),
            ),
          ),

          // User Profile Section
          _buildProfileSection(isSmallScreen),
        ],
      ),
    );
  }

  Widget _buildLogoSection(bool isSmallScreen) {
    return Container(
      height: 70,
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 16 : 24,
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(isSmallScreen ? 6 : 8),
            decoration: BoxDecoration(
              color: AppColors.primary.withAlpha(50),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.analytics_rounded,
              color: AppColors.primary,
              size: isSmallScreen ? 20 : 24,
            ),
          ),
          SizedBox(width: isSmallScreen ? 12 : 16),
          Expanded(
            child: Text(
              isSmallScreen ? 'Analytics' : 'Analytics Pro',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: isSmallScreen ? 16 : 20,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection(bool isSmallScreen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildMenuItem(0, Icons.dashboard_rounded, 'Dashboard', isSmallScreen),
        _buildMenuItem(1, Icons.analytics_rounded, 'Analytics', isSmallScreen),
        _buildMenuItem(2, Icons.folder_rounded, 'Projects', isSmallScreen),
        _buildMenuItem(3, Icons.task_rounded, 'Tasks', isSmallScreen),
        _buildMenuItem(4, Icons.message_rounded, 'Messages', isSmallScreen),
      ],
    );
  }

  Widget _buildWorkspaceSection(bool isSmallScreen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
          child: const Text(
            'WORKSPACE',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        _buildMenuItem(
            5, Icons.folder_shared_rounded, 'Shared Files', isSmallScreen),
        _buildMenuItem(6, Icons.star_rounded, 'Starred', isSmallScreen),
        _buildExpandableMenuItem(
          'Teams',
          Icons.people_rounded,
          [
            _buildSubMenuItem('Design Team', 7, isSmallScreen),
            _buildSubMenuItem('Development Team', 8, isSmallScreen),
            _buildSubMenuItem('Marketing Team', 9, isSmallScreen),
          ],
          isSmallScreen,
        ),
      ],
    );
  }

  Widget _buildTeamSection(bool isSmallScreen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
          child: const Text(
            'TEAM',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        _buildMenuItem(10, Icons.settings_rounded, 'Settings', isSmallScreen),
        _buildMenuItem(
            11, Icons.help_outline_rounded, 'Help Center', isSmallScreen),
      ],
    );
  }

  Widget _buildMenuItem(
      int index, IconData icon, String title, bool isSmallScreen) {
    final isSelected = selectedIndex == index;
    return Material(
      color: Colors.transparent,
      child: ListTile(
        onTap: () => onItemSelected(index),
        selected: isSelected,
        selectedTileColor: AppColors.primary.withAlpha(50),
        leading: Icon(
          icon,
          color: isSelected ? AppColors.primary : AppColors.textSecondary,
          size: isSmallScreen ? 18 : 20,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? AppColors.primary : AppColors.textPrimary,
            fontSize: isSmallScreen ? 13 : 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 16 : 24,
          vertical: isSmallScreen ? 6 : 8,
        ),
        visualDensity:
            isSmallScreen ? VisualDensity.compact : VisualDensity.standard,
      ),
    );
  }

  Widget _buildExpandableMenuItem(
    String title,
    IconData icon,
    List<Widget> children,
    bool isSmallScreen,
  ) {
    return Theme(
      data: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: AppColors.primary,
        ),
      ),
      child: ExpansionTile(
        leading: Icon(
          icon,
          color: AppColors.textSecondary,
          size: isSmallScreen ? 18 : 20,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: isSmallScreen ? 13 : 14,
          ),
        ),
        childrenPadding: EdgeInsets.only(
          left: isSmallScreen ? 12 : 16,
        ),
        iconColor: AppColors.textSecondary,
        collapsedIconColor: AppColors.textSecondary,
        children: children,
      ),
    );
  }

  Widget _buildSubMenuItem(String title, int index, bool isSmallScreen) {
    final isSelected = selectedIndex == index;
    return ListTile(
      onTap: () => onItemSelected(index),
      selected: isSelected,
      selectedTileColor: AppColors.primary.withAlpha(50),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? AppColors.primary : AppColors.textPrimary,
          fontSize: isSmallScreen ? 13 : 14,
        ),
      ),
      contentPadding: EdgeInsets.only(
        left: isSmallScreen ? 56 : 72,
        right: isSmallScreen ? 16 : 24,
      ),
      visualDensity:
          isSmallScreen ? VisualDensity.compact : VisualDensity.standard,
    );
  }

  Widget _buildProfileSection(bool isSmallScreen) {
    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.border),
        ),
        color: Colors.white,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: isSmallScreen ? 16 : 20,
            backgroundColor: AppColors.primary.withAlpha(50),
            child: Text(
              'JD',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: isSmallScreen ? 12 : 14,
              ),
            ),
          ),
          SizedBox(width: isSmallScreen ? 8 : 12),
          if (!isSmallScreen)
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'John Doe',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Administrator',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: AppColors.textSecondary,
              size: isSmallScreen ? 20 : 24,
            ),
            onPressed: () {},
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Divider(
        color: AppColors.border,
        height: 1,
      ),
    );
  }
}
