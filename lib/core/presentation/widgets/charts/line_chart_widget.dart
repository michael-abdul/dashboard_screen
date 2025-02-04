import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/core/theme/app_color.dart';

class LineChartWidget extends StatelessWidget {
  const LineChartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.grey.withOpacity(0.1),
              strokeWidth: 1,
            );
          },
          getDrawingVerticalLine: (value) {
            return FlLine(
              color: Colors.grey.withOpacity(0.1),
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (value, meta) {
                const style = TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                );
                String text;
                switch (value.toInt()) {
                  case 0:
                    text = 'Jan';
                    break;
                  case 2:
                    text = 'Mar';
                    break;
                  case 4:
                    text = 'May';
                    break;
                  case 6:
                    text = 'Jul';
                    break;
                  case 8:
                    text = 'Sep';
                    break;
                  case 10:
                    text = 'Nov';
                    break;
                  default:
                    return Container();
                }
                return Text(text, style: style);
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                return Text(
                  '\$${value.toInt()}k',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                );
              },
              reservedSize: 40,
            ),
          ),
          rightTitles:const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles:const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        borderData: FlBorderData(show: false),
        minX: 0,
        maxX: 11,
        minY: 0,
        maxY: 6,
        lineBarsData: [
          LineChartBarData(
            spots: [
              const FlSpot(0, 3),
              const FlSpot(2.6, 2),
              const FlSpot(4.9, 5),
              const FlSpot(6.8, 3.1),
              const FlSpot(8, 4),
              const FlSpot(9.5, 3),
              const FlSpot(11, 4),
            ],
            isCurved: true,
            color: AppColors.primary,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData:const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: AppColors.primary.withOpacity(0.1),
            ),
          ),
        ],
      ),
    );
  }
}

// lib/presentation/widgets/charts/bar_chart_widget.dart
class BarChartWidget extends StatelessWidget {
  const BarChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 20,
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.grey[800]!,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                '${rod.toY.round()}k',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                const style = TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                );
                String text;
                switch (value.toInt()) {
                  case 0:
                    text = 'Mon';
                    break;
                  case 1:
                    text = 'Tue';
                    break;
                  case 2:
                    text = 'Wed';
                    break;
                  case 3:
                    text = 'Thu';
                    break;
                  case 4:
                    text = 'Fri';
                    break;
                  case 5:
                    text = 'Sat';
                    break;
                  case 6:
                    text = 'Sun';
                    break;
                  default:
                    return Container();
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(text, style: style),
                );
              },
              reservedSize: 38,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                return Text(
                  '\$${value.toInt()}k',
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                );
              },
            ),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        gridData: FlGridData(
          show: true,
          drawHorizontalLine: true,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.grey.withOpacity(0.1),
              strokeWidth: 1,
            );
          },
          drawVerticalLine: false,
        ),
        borderData: FlBorderData(show: false),
        barGroups: [
          BarChartGroupData(
            x: 0,
            barRods: [
              BarChartRodData(
                toY: 15,
                color: AppColors.primary,
                width: 16,
                borderRadius: BorderRadius.circular(4),
              ),
            ],
          ),
          BarChartGroupData(
            x: 1,
            barRods: [
              BarChartRodData(
                toY: 12,
                color: AppColors.primary,
                width: 16,
                borderRadius: BorderRadius.circular(4),
              ),
            ],
          ),
          BarChartGroupData(
            x: 2,
            barRods: [
              BarChartRodData(
                toY: 18,
                color: AppColors.primary,
                width: 16,
                borderRadius: BorderRadius.circular(4),
              ),
            ],
          ),
          BarChartGroupData(
            x: 3,
            barRods: [
              BarChartRodData(
                toY: 14,
                color: AppColors.primary,
                width: 16,
                borderRadius: BorderRadius.circular(4),
              ),
            ],
          ),
          BarChartGroupData(
            x: 4,
            barRods: [
              BarChartRodData(
                toY: 16,
                color: AppColors.primary,
                width: 16,
                borderRadius: BorderRadius.circular(4),
              ),
            ],
          ),
          BarChartGroupData(
            x: 5,
            barRods: [
              BarChartRodData(
                toY: 13,
                color: AppColors.primary,
                width: 16,
                borderRadius: BorderRadius.circular(4),
              ),
            ],
          ),
          BarChartGroupData(
            x: 6,
            barRods: [
              BarChartRodData(
                toY: 10,
                color: AppColors.primary,
                width: 16,
                borderRadius: BorderRadius.circular(4),
              ),
            ],
          ),
        ],
      ),
    );
  }
}