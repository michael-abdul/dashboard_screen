import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/core/theme/app_color.dart';

class LineChartWidget extends StatelessWidget {
  const LineChartWidget({super.key});

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
                    return const SizedBox();
                }
                return Text(text, style: style);
              },
               interval: 2, 
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
         lineTouchData: LineTouchData(
    getTouchedSpotIndicator: (LineChartBarData barData, List<int> spotIndexes) {
      return spotIndexes.map((index) {
        return TouchedSpotIndicatorData(
        const  FlLine(
            color: Colors.blue,  // liniya rangi
            strokeWidth: 1,      // liniya qalinligi - buni kamaytirib ko'ring
            dashArray: [3, 3],   // uzuq-uzuq chiziq uchun
          ),
          FlDotData(
            show: true,
            getDotPainter: (spot, percent, barData, index) =>
              FlDotCirclePainter(
                radius: 4,
                color: Colors.white,
                strokeWidth: 2,
                strokeColor: Colors.blue,
              ),
          ),
        );
      }).toList();
    },
  ),
      ),
    );
  }
}