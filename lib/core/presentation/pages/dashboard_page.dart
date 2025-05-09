import 'package:flutter/material.dart';
import 'package:flutter_ui/core/light_theme/app_color.dart';
import 'package:flutter_ui/core/light_theme/text_styles.dart';
import 'package:flutter_ui/core/presentation/widgets/charts/bar_chart_widget.dart';
import 'package:flutter_ui/core/presentation/widgets/charts/pie_chart_widget.dart';
import 'package:flutter_ui/core/presentation/widgets/charts/line_chart_widget.dart';
import 'package:flutter_ui/core/presentation/widgets/dashboard/stats_card.dart';
import 'package:flutter_ui/core/presentation/widgets/header/app_header.dart';
import 'package:flutter_ui/core/presentation/widgets/sidebar/sidebar_menu.dart';

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
                        LayoutBuilder(
                          builder: (context, constraints) {
                            // Pie chart uchun standart o'lchamlar
                            final bool isLargeScreen =
                                constraints.maxWidth > 1350;
                            final bool isMediumScreen =
                                constraints.maxWidth > 650;

                            // Standart pie chart container
                            Widget pieChartSection = SizedBox(
                              height: 880, // Standart height
                              width: isLargeScreen ? null : double.infinity,
                              child: const AdvancedPieChart(),
                            );

                            if (isLargeScreen) {
                              // Katta ekran uchun
                              return SingleChildScrollView(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Pie Chart
                                    Expanded(
                                      child: Container(
                                        padding:
                                            const EdgeInsets.only(bottom: 24),
                                        child: pieChartSection,
                                      ),
                                    ),
                                    const SizedBox(width: 24),
                                    // Charts section
                                    Expanded(
                                      child: Column(
                                        children: [
                                          _buildChartCard(
                                            title: 'Revenue Overview',
                                            subtitle:
                                                'Monthly Revenue Statistics',
                                            chart: const LineChartWidget(),
                                          ),
                                          const SizedBox(height: 24),
                                          _buildChartCard(
                                            title: 'Weekly Activity',
                                            subtitle: 'Task Completion Rate',
                                            chart: const BarChartWidget(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else if (isMediumScreen) {
                              return SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      padding:
                                          const EdgeInsets.only(bottom: 24),
                                      child: pieChartSection,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: _buildChartCard(
                                            title: 'Revenue Overview',
                                            subtitle:
                                                'Monthly Revenue Statistics',
                                            chart: const LineChartWidget(),
                                          ),
                                        ),
                                        const SizedBox(width: 24),
                                        Expanded(
                                          child: _buildChartCard(
                                            title: 'Weekly Activity',
                                            subtitle: 'Task Completion Rate',
                                            chart: const BarChartWidget(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return Column(
                                children: [
                                  pieChartSection,
                                  const SizedBox(height: 24),
                                  _buildChartCard(
                                    title: 'Revenue Overview',
                                    subtitle: 'Monthly Revenue Statistics',
                                    chart: const LineChartWidget(),
                                  ),
                                  const SizedBox(height: 24),
                                  _buildChartCard(
                                    title: 'Weekly Activity',
                                    subtitle: 'Task Completion Rate',
                                    chart: const BarChartWidget(),
                                  ),
                                ],
                              );
                            }
                          },
                        ),
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
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 24),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        spacing: 20,
        runSpacing: 20,
        children: [
          // Left side - Welcome text
          Container(
            constraints: const BoxConstraints(
              maxWidth: 600, // Maximum width for text content
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Heading
                Text(
                  'Good Morning, John! 👋',
                  style: TextStyles.heading1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8),
                // Subheading
                Text(
                  'Here\'s what\'s happening with your projects today',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 16,
                    height: 1.5,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // Right side - Add New Project button
          SizedBox(
            height: 48, // Fixed height for button
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.add,
                color: Colors.white,
                size: 20,
              ),
              label: const Text(
                'Add New Project',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
                minimumSize: const Size(180, 48), // Minimum button width
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 1200;

    return Wrap(
      spacing: isSmallScreen ? 12 : 16,
      runSpacing: isSmallScreen ? 12 : 16,
      children: [
        _buildStatCard(
          width: _calculateCardWidth(screenWidth),
          title: 'Total Revenue',
          value: '\$54,239',
          subValue: '428 orders',
          icon: Icons.attach_money,
          iconColor: Colors.green,
          isIncreased: true,
          percentageChange: '12.5%',
        ),
        _buildStatCard(
          width: _calculateCardWidth(screenWidth),
          title: 'Active Projects',
          value: '95',
          subValue: '32 in progress',
          icon: Icons.work,
          iconColor: Colors.blue,
          isIncreased: true,
          percentageChange: '8.2%',
        ),
        _buildStatCard(
          width: _calculateCardWidth(screenWidth),
          title: 'Team Members',
          value: '248',
          subValue: '24 new this month',
          icon: Icons.people,
          iconColor: Colors.purple,
          isIncreased: false,
          percentageChange: '2.4%',
        ),
        _buildStatCard(
          width: _calculateCardWidth(screenWidth),
          title: 'Total Tasks',
          value: '1,257',
          subValue: '158 completed',
          icon: Icons.task,
          iconColor: Colors.orange,
          isIncreased: true,
          percentageChange: '4.3%',
        ),
        _buildStatCard(
          width: _calculateCardWidth(screenWidth),
          title: 'Completed Tasks',
          value: '845',
          subValue: '64 this week',
          icon: Icons.check_circle_outline,
          iconColor: Colors.teal,
          isIncreased: true,
          percentageChange: '5.8%',
        ),
        _buildStatCard(
          width: _calculateCardWidth(screenWidth),
          title: 'Total Hours',
          value: '2,450',
          subValue: '160 this month',
          icon: Icons.access_time,
          iconColor: Colors.amber,
          isIncreased: false,
          percentageChange: '1.2%',
        ),
      ],
    );
  }

  double _calculateCardWidth(double screenWidth) {
    if (screenWidth < 600) {
      return screenWidth - 32; // Full width - padding on mobile
    } else if (screenWidth < 900) {
      return (screenWidth - 48) / 2; // 2 cards per row
    } else if (screenWidth < 1200) {
      return (screenWidth - 64) / 3; // 3 cards per row
    } else {
      return (screenWidth - 80) / 4; // 4 cards per row
    }
  }

  Widget _buildStatCard({
    required double width,
    required String title,
    required String value,
    required String subValue,
    required IconData icon,
    required Color iconColor,
    required bool isIncreased,
    required String percentageChange,
  }) {
    return Container(
      width: width,
      constraints: const BoxConstraints(minHeight: 180),
      child: StatsCard(
        title: title,
        value: value,
        subValue: subValue,
        icon: icon,
        iconColor: iconColor,
        isIncreased: isIncreased,
        percentageChange: percentageChange,
      ),
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
          color: AppColors.border,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(50),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
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
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              PopupMenuButton(
                icon: const Icon(
                  Icons.more_vert,
                  color: AppColors.textSecondary,
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
          color: AppColors.border,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(50),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
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
              color: color.withAlpha(26),
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
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
