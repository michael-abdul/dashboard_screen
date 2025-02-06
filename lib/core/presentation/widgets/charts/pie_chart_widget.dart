// Kerakli Flutter paketlarini import qilish
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/core/theme/app_color.dart';

// Bo'limlar uchun ma'lumotlar modeli
class DepartmentData {
  final String name;         // Bo'lim nomi
  final double percentage;   // Bo'limning foizdagi ulushi
  final Color color;        // Bo'lim rangi
  final IconData icon;      // Bo'lim ikonkasi
  final int employeeCount;  // Xodimlar soni

  // Konstruktor - barcha maydonlar majburiy
  const DepartmentData({
    required this.name,
    required this.percentage,
    required this.color,
    required this.icon,
    required this.employeeCount,
  });
}

// Asosiy widget - Pie Chart yaratish uchun
class AdvancedPieChart extends StatefulWidget {
  const AdvancedPieChart({super.key});

  @override
  State<AdvancedPieChart> createState() => _AdvancedPieChartState();
}

class _AdvancedPieChartState extends State<AdvancedPieChart> {
  // Tanlangan bo'lim indeksi (-1 hech qaysi tanlanmagan)
  int touchedIndex = -1;

  // Bo'limlar ro'yxati va ularning ma'lumotlari
  final departments = [
    // Marketing bo'limi ma'lumotlari
    const DepartmentData(
      name: 'Marketing',
      percentage: 15.2,
      color: Color(0xFF4287f5),
      icon: Icons.campaign_outlined,
      employeeCount: 45,
    ),
    // Sotuvlar bo'limi ma'lumotlari
    const DepartmentData(
      name: 'Sales',
      percentage: 18.2,
      color: Color(0xFFf59642),
      icon: Icons.trending_up_outlined,
      employeeCount: 54,
    ),
    // Moliya bo'limi ma'lumotlari
    const DepartmentData(
      name: 'Finance',
      percentage: 12.1,
      color: Color(0xFFf54242),
      icon: Icons.attach_money_outlined,
      employeeCount: 36,
    ),
    // HR bo'limi ma'lumotlari
    const DepartmentData(
      name: 'Human Resources',
      percentage: 9.1,
      color: Color(0xFF42f5ef),
      icon: Icons.people_outline,
      employeeCount: 27,
    ),
    // IT bo'limi ma'lumotlari
    const DepartmentData(
      name: 'IT',
      percentage: 24.2,
      color: Color(0xFF42f587),
      icon: Icons.computer_outlined,
      employeeCount: 72,
    ),
    // Operatsiyalar bo'limi ma'lumotlari
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
    // Asosiy konteyner
    return Container(
      padding: const EdgeInsets.all(24),
      // Konteyner dizayni
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.withOpacity(0.1),
        ),
      ),
      child: Column(
        children: [
          // Sarlavha qismi
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Sarlavha va tavsif matni
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
              // Qo'shimcha opsiyalar tugmasi
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
          // Diagramma qismi
          Row(
            children: [
              // Pie Chart joylashuvi
              Expanded(
                flex: 2,
                child: AspectRatio(
                  aspectRatio: 1.5,
                  child: PieChart(
                    PieChartData(
                      // Teginish uchun ma'lumotlar
                      pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                          setState(() {
                            // Teginish holatini tekshirish
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              touchedIndex = -1;
                              return;
                            }
                            // Tanlangan qismni yangilash
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
              // Diagramma elementi
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: departments.asMap().entries.map((entry) {
                    final index = entry.key;
                    final dept = entry.value;
                    final isSelected = touchedIndex == index;

                    // Bo'lim elementini yaratish
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
                          // Bo'lim elementi dizayni
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
                            // Bo'lim ma'lumotlari
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
          const SizedBox(height: 74),
          // Jami xodimlar soni
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

  // Pie Chart seksiyalarini generatsiya qilish
  List<PieChartSectionData> _generateSections() {
    return departments.asMap().entries.map((entry) {
      final index = entry.key;
      final dept = entry.value;
      final isTouched = index == touchedIndex;
      final radius = isTouched ? 110.0 : 100.0;
      final fontSize = isTouched ? 16.0 : 14.0;

      // Har bir seksiya uchun ma'lumotlar
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

// Badge widget - tanlangan seksiya uchun ko'rsatiladigan belgi
class _Badge extends StatelessWidget {
  const _Badge(
    this.icon, {
    required this.size,
    required this.borderColor,
  });

  final IconData icon;      // Belgi ikonkasi
  final double size;        // Belgi o'lchami
  final Color borderColor;  // Chegara rangi

  @override
  Widget build(BuildContext context) {
    // Badge dizayni
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