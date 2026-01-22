import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:fl_chart/fl_chart.dart';
import '../constants/color.dart';
import '../widget/navbar.dart';
import '../widget/circle.dart';

class Statistik extends StatefulWidget {
  const Statistik({super.key});

  @override
  State<Statistik> createState() => _StatistikState();
}

class _StatistikState extends State<Statistik> {
  late DatabaseReference _db;

  List<FlSpot> _spotsKolam = [];
  List<FlSpot> _spotsSungai = [];

  List<String> _labelJamKolam = [];
  List<String> _labelJamSungai = [];

  @override
  void initState() {
    super.initState();
    _db = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL:
          "https://irigate-smart-retention-default-rtdb.asia-southeast1.firebasedatabase.app",
    ).ref("IriGateSystem");

    _loadKolam();
    _loadSungai();
  }

  void _loadGeneric(String path, Function(List<FlSpot>, List<String>) onData) {
    _db.child(path).onValue.listen((event) {
      final raw = event.snapshot.value;
      if (raw == null || raw is! Map) return;

      final map = Map<String, dynamic>.from(raw);

      List<Map<String, dynamic>> parsed = [];

      map.forEach((key, value) {
        if (value is Map && value["height"] != null) {
          final height = (value["height"] as num).toDouble();
          final timeMs = int.tryParse(key.toString()) ?? 0;

          if (timeMs > 0) {
            parsed.add({
              "height": height,
              "time": DateTime.fromMillisecondsSinceEpoch(timeMs, isUtc: false),
            });
          }
        }
      });

      parsed.sort((a, b) => a["time"].compareTo(b["time"]));

      final last = parsed.length > 7
          ? parsed.sublist(parsed.length - 7)
          : parsed;

      List<FlSpot> spots = [];
      List<String> labels = [];

      for (int i = 0; i < last.length; i++) {
        spots.add(FlSpot(i.toDouble(), last[i]["height"]));
        final t = last[i]["time"] as DateTime;
        labels.add(
          "${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}",
        );
      }

      setState(() => onData(spots, labels));
    });
  }

  void _loadKolam() {
    _loadGeneric("monitoring/statistik/kolam", (spots, labels) {
      _spotsKolam = spots;
      _labelJamKolam = labels;
    });
  }

  void _loadSungai() {
    _loadGeneric("monitoring/statistik/sungai", (spots, labels) {
      _spotsSungai = spots;
      _labelJamSungai = labels;
    });
  }

  LineChartData _chartData(
    List<FlSpot> spots,
    List<String> labels,
    double maxY,
  ) {
    return LineChartData(
      minX: 0,
      maxX: spots.length > 1 ? spots.length - 1 : 1,
      minY: 0,
      maxY: maxY,
      lineBarsData: spots.isEmpty
          ? []
          : [
              LineChartBarData(
                spots: spots,
                isCurved: true,
                barWidth: 3,
                dotData: FlDotData(show: true),
                color: AppColors.primary,
              ),
            ],
      titlesData: FlTitlesData(
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: maxY / 5,
            getTitlesWidget: (v, meta) => Text(
              v.toInt().toString(),
              style: GoogleFonts.ruda(fontSize: 10, color: AppColors.text),
            ),
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            reservedSize: 32,
            getTitlesWidget: (value, meta) {
              final index = value.round();

              if (index < 0 || index >= labels.length) {
                return const SizedBox();
              }

              return Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  labels[index],
                  style: GoogleFonts.ruda(fontSize: 10, color: AppColors.text),
                ),
              );
            },
          ),
        ),

        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      gridData: FlGridData(show: true),
      borderData: FlBorderData(show: false),
    );
  }

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
              padding: const EdgeInsets.all(26),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Data Statistik Per Jam",
                      style: GoogleFonts.ruda(
                        color: AppColors.text,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 14),
                    Text(
                      "Kedalaman Sungai",
                      style: GoogleFonts.ruda(color: AppColors.text),
                    ),
                    const SizedBox(height: 12),

                    LiquidGlassLayer(
                      settings: LiquidGlassSettings(
                        blur: 34,
                        thickness: 68,
                        glassColor: Colors.transparent,
                      ),
                      child: LiquidGlass(
                        shape: LiquidRoundedRectangle(borderRadius: 20),
                        child: Container(
                          height: 280,
                          padding: const EdgeInsets.all(24),
                          child: LineChart(
                            _chartData(_spotsSungai, _labelJamSungai, 10),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),
                    Text(
                      "Kedalaman Kolam Retensi",
                      style: GoogleFonts.ruda(color: AppColors.text),
                    ),
                    const SizedBox(height: 12),

                    LiquidGlassLayer(
                      settings: LiquidGlassSettings(
                        blur: 34,
                        thickness: 68,
                        glassColor: Colors.transparent,
                      ),
                      child: LiquidGlass(
                        shape: LiquidRoundedRectangle(borderRadius: 20),
                        child: Container(
                          height: 280,
                          padding: const EdgeInsets.all(24),
                          child: LineChart(
                            _chartData(_spotsKolam, _labelJamKolam, 10),
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
          if (index == 0) Navigator.pushReplacementNamed(context, "/home");
          if (index == 1) Navigator.pushReplacementNamed(context, "/statistik");
          if (index == 2) Navigator.pushReplacementNamed(context, "/setting");
        },
      ),
    );
  }
}
