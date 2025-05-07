import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/core/light_theme/app_color.dart';

// Department data model
class DepartmentData {
  final String name; // Department name
  final double percentage; // Department percentage
  final Color color; // Department color
  final IconData icon; // Department icon
  final int employeeCount; // Employee count

  // Constructor - all fields required
  const DepartmentData({
    required this.name,
    required this.percentage,
    required this.color,
    required this.icon,
    required this.employeeCount,
  });
}

// Main widget - creates Pie Chart
class AdvancedPieChart extends StatefulWidget {
  const AdvancedPieChart({super.key});

  @override
  State<AdvancedPieChart> createState() => _AdvancedPieChartState();
}

class _AdvancedPieChartState extends State<AdvancedPieChart> {
  // Selected department index (-1 means none selected)
  int touchedIndex = -1;

  // Department list with their data
  final departments = [
    // Marketing department data
    const DepartmentData(
      name: 'Marketing',
      percentage: 15.2,
      color: Color(0xFF4287f5),
      icon: Icons.campaign_outlined,
      employeeCount: 45,
    ),
    // Sales department data
    const DepartmentData(
      name: 'Sales',
      percentage: 18.2,
      color: Color(0xFFf59642),
      icon: Icons.trending_up_outlined,
      employeeCount: 54,
    ),
    // Finance department data
    const DepartmentData(
      name: 'Finance',
      percentage: 12.1,
      color: Color(0xFFf54242),
      icon: Icons.attach_money_outlined,
      employeeCount: 36,
    ),
    // HR department data
    const DepartmentData(
      name: 'Human Resources',
      percentage: 9.1,
      color: Color(0xFF42f5ef),
      icon: Icons.people_outline,
      employeeCount: 27,
    ),
    // IT department data
    const DepartmentData(
      name: 'IT',
      percentage: 24.2,
      color: Color(0xFF42f587),
      icon: Icons.computer_outlined,
      employeeCount: 72,
    ),
    // Operations department data
    const DepartmentData(
      name: 'Operations',
      percentage: 21.2,
      color: Color(0xFFa742f5),
      icon: Icons.engineering_outlined,
      employeeCount: 63,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Main container
    return Container(
      padding: const EdgeInsets.all(24),
      // Container design
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.border,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(26),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Title section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Title and subtitle
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Employee Distribution',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Department wise employee count',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              // Options button
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_vert,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          // Chart section
          Row(
            children: [
              // Pie Chart placement
              Expanded(
                flex: 2,
                child: AspectRatio(
                  aspectRatio: 1.5,
                  child: PieChart(
                    PieChartData(
                      // Touch data
                      pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                          setState(() {
                            // Check touch state
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              touchedIndex = -1;
                              return;
                            }
                            // Update selected section
                            touchedIndex = pieTouchResponse
                                .touchedSection!.touchedSectionIndex;
                          });
                        },
                      ),
                      borderData: FlBorderData(show: false),
                      sectionsSpace: 2,
                      centerSpaceRadius: 100,
                      sections: _generateSections(),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 38),
              // Chart legend
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: departments.asMap().entries.map((entry) {
                    final index = entry.key;
                    final dept = entry.value;
                    final isSelected = touchedIndex == index;

                    // Create department element
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              touchedIndex = index;
                            });
                          },
                          // Department element design
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? dept.color.withAlpha(26)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: isSelected
                                    ? dept.color
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            // Department data
                            child: Row(
                              children: [
                                Icon(
                                  dept.icon,
                                  color: dept.color,
                                  size: 24,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        dept.name,
                                        style: TextStyle(
                                          color: AppColors.textPrimary,
                                          fontSize: 14,
                                          fontWeight: isSelected
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '${dept.employeeCount} Employees',
                                        style: const TextStyle(
                                          color: AppColors.textSecondary,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  '${dept.percentage}%',
                                  style: TextStyle(
                                    color: dept.color,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 34),
          // Total employee count
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary.withAlpha(26),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.primary.withAlpha(51),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.groups_outlined,
                  color: AppColors.primary,
                  size: 24,
                ),
                const SizedBox(width: 12),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(fontSize: 16),
                    children: [
                      TextSpan(
                        text: 'Total Employees: ',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      TextSpan(
                        text: '297',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Generate Pie Chart sections
  List<PieChartSectionData> _generateSections() {
    return departments.asMap().entries.map((entry) {
      final index = entry.key;
      final dept = entry.value;
      final isTouched = index == touchedIndex;
      final radius = isTouched ? 110.0 : 100.0;
      final fontSize = isTouched ? 16.0 : 14.0;

      // Data for each section
      return PieChartSectionData(
        color: dept.color,
        value: dept.percentage,
        title: '${dept.percentage}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        badgeWidget: isTouched
            ? _Badge(
                dept.icon,
                size: 40,
                borderColor: dept.color,
              )
            : null,
        badgePositionPercentageOffset: 1.2,
        titlePositionPercentageOffset: 0.6,
      );
    }).toList();
  }
}

// Badge widget - shows for selected section
class _Badge extends StatelessWidget {
  const _Badge(
    this.icon, {
    required this.size,
    required this.borderColor,
  });

  final IconData icon; // Badge icon
  final double size; // Badge size
  final Color borderColor; // Border color

  @override
  Widget build(BuildContext context) {
    // Badge design
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: borderColor.withAlpha(76),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Center(
        child: Icon(
          icon,
          color: borderColor,
          size: size * 0.6,
        ),
      ),
    );
  }
}
