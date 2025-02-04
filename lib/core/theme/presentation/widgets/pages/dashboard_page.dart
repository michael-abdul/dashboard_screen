import 'package:flutter/material.dart';
import 'package:flutter_ui/core/theme/app_color.dart';
import 'package:flutter_ui/core/theme/presentation/widgets/charts/line_chart_widget.dart';
import 'package:flutter_ui/core/theme/presentation/widgets/dashboard/stats_card.dart';
import 'package:flutter_ui/core/theme/presentation/widgets/header/app_header.dart';
import 'package:flutter_ui/core/theme/presentation/widgets/sidebar/sidebar_menu.dart';
import 'package:flutter_ui/core/theme/text_styles.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Row(
        children: [
          // Sidebar Menu
          SidebarMenu(
            selectedIndex: _selectedIndex,
            onItemSelected: (index) {
              setState(() => _selectedIndex = index);
            },
          ),

          // Main Content
          Expanded(
            child: Column(
              children: [
                // Header
                const AppHeader(),

                // Scrollable Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Welcome Message
                        _buildWelcomeSection(),
                        const SizedBox(height: 32),

                        // Stats Cards
                        _buildStatsSection(),
                        const SizedBox(height: 32),

                        // Charts Section
                        _buildChartsSection(),
                        const SizedBox(height: 32),

                        // Recent Activity Section
                        _buildRecentActivitySection(),
                      ],
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

  Widget _buildWelcomeSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Good Morning, John! 👋',
              style: TextStyles.heading1,
            ),
            const SizedBox(height: 8),
            Text(
              'Heres whats happening with your projects today',
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 16,
              ),
            ),
          ],
        ),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add),
          label: const Text('Add New Project'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsSection() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 4,
      crossAxisSpacing: 24,
      mainAxisSpacing: 24,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        StatsCard(
          title: 'Total Revenue',
          value: '\$54,239',
          subValue: '428 orders',
          icon: Icons.attach_money,
          iconColor: Colors.green,
          isIncreased: true,
          percentageChange: '12.5%',
        ),
        StatsCard(
          title: 'Active Projects',
          value: '95',
          subValue: '32 in progress',
          icon: Icons.work,
          iconColor: Colors.blue,
          isIncreased: true,
          percentageChange: '8.2%',
        ),
        StatsCard(
          title: 'Team Members',
          value: '248',
          subValue: '24 new this month',
          icon: Icons.people,
          iconColor: Colors.purple,
          isIncreased: false,
          percentageChange: '2.4%',
        ),
        StatsCard(
          title: 'Total Tasks',
          value: '1,257',
          subValue: '158 completed',
          icon: Icons.task,
          iconColor: Colors.orange,
          isIncreased: true,
          percentageChange: '4.3%',
        ),
      ],
    );
  }

  Widget _buildChartsSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Revenue Chart
        Expanded(
          flex: 2,
          child: _buildChartCard(
            title: 'Revenue Overview',
            subtitle: 'Monthly Revenue Statistics',
            chart: const LineChartWidget(),
          ),
        ),
        const SizedBox(width: 24),
        // Weekly Activity Chart
        Expanded(
          child: _buildChartCard(
            title: 'Weekly Activity',
            subtitle: 'Task Completion Rate',
            chart: const BarChartWidget(),
          ),
        ),
      ],
    );
  }

  Widget _buildChartCard({
    required String title,
    required String subtitle,
    required Widget chart,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyles.heading2,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              PopupMenuButton(
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.grey[400],
                ),
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    child: Text('Download Report'),
                  ),
                  const PopupMenuItem(
                    child: Text('Share'),
                  ),
                  const PopupMenuItem(
                    child: Text('View Details'),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 300,
            child: chart,
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivitySection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent Activity',
                style: TextStyles.heading2,
              ),
              TextButton(
                onPressed: () {},
                child: const Text('View All'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildActivityItem(
            icon: Icons.update,
            color: Colors.blue,
            title: 'Project Update',
            description: 'New version released for App Design',
            time: '2 hours ago',
          ),
          _buildActivityItem(
            icon: Icons.task_alt,
            color: Colors.green,
            title: 'Task Completed',
            description: 'Mark completed the developer dashboard design',
            time: '5 hours ago',
          ),
          _buildActivityItem(
            icon: Icons.comment,
            color: Colors.orange,
            title: 'New Comment',
            description: 'Sarah commented on Project Overview',
            time: '8 hours ago',
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem({
    required IconData icon,
    required Color color,
    required String title,
    required String description,
    required String time,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
