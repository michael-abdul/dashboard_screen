import 'package:flutter/material.dart';
import 'package:flutter_ui/core/theme/app_color.dart';


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
    return Container(
      width: 280,
      color: AppColors.cardBackground,
      child: Column(
        children: [
          // Logo and Brand
          _buildLogoSection(),
          const Divider(color: Colors.grey, height: 1),
          
          // Menu Items
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  _buildMenuSection(),
                  const Divider(color: Colors.grey, height: 1),
                  _buildWorkspaceSection(),
                  const Divider(color: Colors.grey, height: 1),
                  _buildTeamSection(),
                ],
              ),
            ),
          ),
          
          // User Profile Section
          _buildProfileSection(),
        ],
      ),
    );
  }

  Widget _buildLogoSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.analytics_rounded,
              color: AppColors.primary,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          const Text(
            'Analytics Pro',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildMenuItem(0, Icons.dashboard_rounded, 'Dashboard'),
        _buildMenuItem(1, Icons.analytics_rounded, 'Analytics'),
        _buildMenuItem(2, Icons.folder_rounded, 'Projects'),
        _buildMenuItem(3, Icons.task_rounded, 'Tasks'),
        _buildMenuItem(4, Icons.message_rounded, 'Messages'),
      ],
    );
  }

  Widget _buildWorkspaceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'WORKSPACE',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        _buildMenuItem(5, Icons.folder_shared_rounded, 'Shared Files'),
        _buildMenuItem(6, Icons.star_rounded, 'Starred'),
        _buildExpandableMenuItem(
          'Teams',
          Icons.people_rounded,
          [
            _buildSubMenuItem('Design Team', 7),
            _buildSubMenuItem('Development Team', 8),
            _buildSubMenuItem('Marketing Team', 9),
          ],
        ),
      ],
    );
  }

  Widget _buildTeamSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'TEAM',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        _buildMenuItem(10, Icons.settings_rounded, 'Settings'),
        _buildMenuItem(11, Icons.help_outline_rounded, 'Help Center'),
      ],
    );
  }

  Widget _buildMenuItem(int index, IconData icon, String title) {
    final isSelected = selectedIndex == index;
    return Material(
      color: Colors.transparent,
      child: ListTile(
        onTap: () => onItemSelected(index),
        selected: isSelected,
        selectedTileColor: AppColors.primary.withOpacity(0.1),
        leading: Icon(
          icon,
          color: isSelected ? AppColors.primary : Colors.grey,
          size: 20,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? AppColors.primary : Colors.grey,
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      ),
    );
  }

  Widget _buildExpandableMenuItem(
    String title,
    IconData icon,
    List<Widget> children,
  ) {
    return ExpansionTile(
      leading: Icon(icon, color: Colors.grey, size: 20),
      title: Text(
        title,
        style: const TextStyle(color: Colors.grey, fontSize: 14),
      ),
      childrenPadding: const EdgeInsets.only(left: 16),
      iconColor: Colors.grey,
      collapsedIconColor: Colors.grey,
      children: children,
    );
  }

  Widget _buildSubMenuItem(String title, int index) {
    final isSelected = selectedIndex == index;
    return ListTile(
      onTap: () => onItemSelected(index),
      selected: isSelected,
      selectedTileColor: AppColors.primary.withOpacity(0.1),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? AppColors.primary : Colors.grey,
          fontSize: 14,
        ),
      ),
      contentPadding: const EdgeInsets.only(left: 72, right: 24),
    );
  }

  Widget _buildProfileSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey.withOpacity(0.2)),
        ),
      ),
      child: Row(
        children: [
          // Profile Image
          CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.primary.withOpacity(0.1),
            child: const Text(
              'JD',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // User Info
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children:  [
                Text(
                  'John Doe',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Admin',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          // Menu Button
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.grey),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}