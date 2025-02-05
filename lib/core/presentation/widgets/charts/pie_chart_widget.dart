// lib/presentation/widgets/charts/advanced_pie_chart.dart
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/core/theme/app_color.dart';

class DepartmentData {
  final String name;
  final double percentage;
  final Color color;
  final IconData icon;
  final int employeeCount;

  const DepartmentData({
    required this.name,
    required this.percentage,
    required this.color,
    required this.icon,
    required this.employeeCount,
  });
}

class AdvancedPieChart extends StatefulWidget {
  const AdvancedPieChart({super.key});

  @override
  State<AdvancedPieChart> createState() => _AdvancedPieChartState();
}

class _AdvancedPieChartState extends State<AdvancedPieChart> {
  int touchedIndex = -1;

  final departments = [
    const DepartmentData(
      name: 'Marketing',
      percentage: 15.2,
      color: Color(0xFF4287f5),
      icon: Icons.campaign_outlined,
      employeeCount: 45,
    ),
    const DepartmentData(
      name: 'Sales',
      percentage: 18.2,
      color: Color(0xFFf59642),
      icon: Icons.trending_up_outlined,
      employeeCount: 54,
    ),
    const DepartmentData(
      name: 'Finance',
      percentage: 12.1,
      color: Color(0xFFf54242),
      icon: Icons.attach_money_outlined,
      employeeCount: 36,
    ),
    const DepartmentData(
      name: 'Human Resources',
      percentage: 9.1,
      color: Color(0xFF42f5ef),
      icon: Icons.people_outline,
      employeeCount: 27,
    ),
    const DepartmentData(
      name: 'IT',
      percentage: 24.2,
      color: Color(0xFF42f587),
      icon: Icons.computer_outlined,
      employeeCount: 72,
    ),
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
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Employee Distribution',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Department wise employee count',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          // Chart Section
          Row(
            children: [
              // Pie Chart
              Expanded(
                flex: 2,
                child: AspectRatio(
                  aspectRatio: 1.5,
                  child: PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                          setState(() {
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              touchedIndex = -1;
                              return;
                            }
                            touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                          });
                        },
                      ),
                      borderData: FlBorderData(show: false),
                      sectionsSpace: 2,
                      centerSpaceRadius: 60,
                      sections: _generateSections(),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 48),
              // Legend
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: departments.asMap().entries.map((entry) {
                    final index = entry.key;
                    final dept = entry.value;
                    final isSelected = touchedIndex == index;

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
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? dept.color.withOpacity(0.1)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: isSelected
                                    ? dept.color
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        dept.name,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: isSelected
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '${dept.employeeCount} Employees',
                                        style: TextStyle(
                                          color: Colors.grey[400],
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
          const SizedBox(height: 24),
          // Total Employees
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.blue.withOpacity(0.2),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.groups_outlined,
                  color: Colors.blue,
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
                          color: Colors.grey,
                        ),
                      ),
                      TextSpan(
                        text: '297',
                        style: TextStyle(
                          color: Colors.white,
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

  List<PieChartSectionData> _generateSections() {
    return departments.asMap().entries.map((entry) {
      final index = entry.key;
      final dept = entry.value;
      final isTouched = index == touchedIndex;
      final radius = isTouched ? 110.0 : 100.0;
      final fontSize = isTouched ? 16.0 : 14.0;

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
        badgeWidget: isTouched ? _Badge(
          dept.icon,
          size: 40,
          borderColor: dept.color,
        ) : null,
        badgePositionPercentageOffset: 1.2,
        titlePositionPercentageOffset: 0.6,
      );
    }).toList();
  }
}

class _Badge extends StatelessWidget {
  const _Badge(
    this.icon, {
    required this.size,
    required this.borderColor,
  });

  final IconData icon;
  final double size;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
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
            color: borderColor.withOpacity(0.3),
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

