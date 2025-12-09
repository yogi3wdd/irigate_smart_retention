import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:fl_chart/fl_chart.dart';
import '../constants/color.dart';
import '../widget/navbar.dart';
import '../widget/circle.dart';

class Statistik extends StatelessWidget {
  const Statistik({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Positioned(
            top: -224,
            left: -44,
            child: Circle(size: 500, color: AppColors.secondaryOpacity),
          ),
          Positioned(
            top: 574,
            left: -44,
            child: Circle(size: 500, color: AppColors.primaryOpacity),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(26),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Data Statistik Mingguan',
                      style: GoogleFonts.ruda(
                        color: AppColors.text,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      "Ketinggian Sungai",
                      style: GoogleFonts.ruda(
                        color: AppColors.text,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 12),
                    LiquidGlassLayer(
                      settings: LiquidGlassSettings(
                        blur: 48,
                        thickness: 84,
                        glassColor: Colors.transparent,
                      ),
                      child: LiquidGlass(
                        shape: LiquidRoundedRectangle(borderRadius: 20),
                        child: Container(
                          width: double.infinity,
                          height: 280,
                          padding: EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.transparent,
                          ),
                          child: LineChart(
                            LineChartData(
                              backgroundColor: Colors.transparent,
                              titlesData: FlTitlesData(
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    interval: 1,
                                    getTitlesWidget: (value, meta) {
                                      return Text(
                                        value.toInt().toString(),
                                        style: GoogleFonts.ruda(
                                          color: AppColors.text,
                                          fontSize: 12,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    interval: 1,
                                    getTitlesWidget: (value, meta) {
                                      return Text(
                                        value.toInt().toString(),
                                        style: GoogleFonts.ruda(
                                          color: AppColors.text,
                                          fontSize: 12,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                rightTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                topTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                              ),
                              lineBarsData: [
                                LineChartBarData(
                                  isCurved: true,
                                  barWidth: 2,
                                  color: AppColors.primary,
                                  belowBarData: BarAreaData(show: false),
                                  dotData: FlDotData(show: true),
                                  spots: const [
                                    FlSpot(0, 2),
                                    FlSpot(1, 3),
                                    FlSpot(2, 1.2),
                                    FlSpot(3, 4),
                                    FlSpot(4, 3.3),
                                    FlSpot(5, 5),
                                  ],
                                ),
                              ],
                              gridData: FlGridData(show: true),
                              borderData: FlBorderData(show: false),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      "Ketinggian Kolam Retensi",
                      style: GoogleFonts.ruda(
                        color: AppColors.text,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 12),
                    LiquidGlassLayer(
                      settings: LiquidGlassSettings(
                        blur: 48,
                        thickness: 84,
                        glassColor: Colors.transparent,
                      ),
                      child: LiquidGlass(
                        shape: LiquidRoundedRectangle(borderRadius: 20),
                        child: Container(
                          width: double.infinity,
                          height: 280,
                          padding: EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.transparent,
                          ),
                          child: LineChart(
                            LineChartData(
                              backgroundColor: Colors.transparent,
                              titlesData: FlTitlesData(
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    interval: 1,
                                    getTitlesWidget: (value, meta) {
                                      return Text(
                                        value.toInt().toString(),
                                        style: GoogleFonts.ruda(
                                          color: AppColors.text,
                                          fontSize: 12,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    interval: 1,
                                    getTitlesWidget: (value, meta) {
                                      return Text(
                                        value.toInt().toString(),
                                        style: GoogleFonts.ruda(
                                          color: AppColors.text,
                                          fontSize: 12,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                rightTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                topTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                              ),
                              lineBarsData: [
                                LineChartBarData(
                                  isCurved: true,
                                  barWidth: 2,
                                  color: AppColors.primary,
                                  belowBarData: BarAreaData(show: false),
                                  dotData: FlDotData(show: true),
                                  spots: const [
                                    FlSpot(0, 2),
                                    FlSpot(1, 3),
                                    FlSpot(2, 1.2),
                                    FlSpot(3, 4),
                                    FlSpot(4, 3.3),
                                    FlSpot(5, 5),
                                  ],
                                ),
                              ],
                              gridData: FlGridData(show: true),
                              borderData: FlBorderData(show: false),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Navbar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/statistik');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/setting');
          }
        },
      ),
    );
  }
}
