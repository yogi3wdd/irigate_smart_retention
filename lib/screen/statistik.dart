import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_database/firebase_database.dart';
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
  final _statistik = FirebaseDatabase.instance.ref("IriGateSystem");

  List<LineChartBarData> _chartKolam = [];
  List<LineChartBarData> _chartSungai = [];

  List<String> _labelJamKolam = [];
  List<String> _labelJamSungai = [];

  @override
  void initState() {
    super.initState();
    _loadDataKolam();
    _loadDataSungai();
  }

  Map<String, dynamic> _convertSnapshot(dynamic raw) {
    if (raw == null) return {};

    if (raw is Map) {
      return Map<String, dynamic>.from(raw);
    }

    if (raw is List) {
      Map<String, dynamic> result = {};
      for (int i = 0; i < raw.length; i++) {
        if (raw[i] != null) {
          result[i.toString()] = raw[i];
        }
      }
      return result;
    }

    return {};
  }

  void _loadDataGeneric(
    String path,
    Function(List<FlSpot>, List<String>) setter,
  ) {
    _statistik.child(path).onValue.listen((event) {
      final dataRaw = event.snapshot.value;

      // Convert aman: Map OR List
      Map<String, dynamic> mapData = _convertSnapshot(dataRaw);
      if (mapData.isEmpty) return;

      List<Map<String, dynamic>> allData = [];

      mapData.forEach((key, value) {
        if (value is Map) {
          final height =
              double.tryParse(value["height"]?.toString() ?? "0") ?? 0;

          final timeMs =
              int.tryParse(value["unixtimeStamp"]?.toString() ?? "0") ?? 0;

          if (timeMs > 0) {
            allData.add({
              "height": height,
              "time": DateTime.fromMillisecondsSinceEpoch(timeMs),
            });
          }
        }
      });

      if (allData.isEmpty) return;

      // Urutkan berdasarkan waktu
      allData.sort((a, b) => a["time"].compareTo(b["time"]));

      // Ambil 7 data terakhir
      List<Map<String, dynamic>> lastData = allData.length > 7
          ? allData.sublist(allData.length - 7)
          : allData;

      List<FlSpot> spots = [];
      List<String> labels = [];

      for (int i = 0; i < lastData.length; i++) {
        spots.add(FlSpot(i.toDouble(), lastData[i]["height"]));

        final time = lastData[i]["time"];
        labels.add(
          "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}",
        );
      }

      setter(spots, labels);
    });
  }

  void _loadDataSungai() {
    _loadDataGeneric("monitoring/statistik/sungai", (spots, labels) {
      setState(() {
        _labelJamSungai = labels;
        _chartSungai = [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            barWidth: 3,
            dotData: FlDotData(show: true),
            color: AppColors.primary,
          ),
        ];
      });
    });
  }

  void _loadDataKolam() {
    _loadDataGeneric("monitoring/statistik/kolam", (spots, labels) {
      setState(() {
        _labelJamKolam = labels;
        _chartKolam = [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            barWidth: 3,
            dotData: FlDotData(show: true),
            color: AppColors.primary,
          ),
        ];
      });
    });
  }

  Widget _bottomTitle(double value, TitleMeta meta, List<String> labels) {
    int index = value.toInt();
    if (index < 0 || index >= labels.length) {
      return const SizedBox.shrink();
    }
    return Text(
      labels[index],
      style: const TextStyle(fontSize: 10, color: Colors.white),
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
                            LineChartData(
                              maxY: 60,
                              minY: 0,
                              lineBarsData: _chartSungai,
                              titlesData: FlTitlesData(
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, meta) {
                                      return Text(
                                        value.toInt().toString(),
                                        style: GoogleFonts.ruda(
                                          fontSize: 10,
                                          color: AppColors.text,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (v, meta) =>
                                        _bottomTitle(v, meta, _labelJamSungai),
                                  ),
                                ),
                                topTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                rightTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                              ),
                            ),
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
                            LineChartData(
                              maxY: 40,
                              minY: 0,
                              lineBarsData: _chartKolam,
                              titlesData: FlTitlesData(
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, meta) {
                                      return Text(
                                        value.toInt().toString(),
                                        style: GoogleFonts.ruda(
                                          fontSize: 10,
                                          color: AppColors.text,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (v, meta) =>
                                        _bottomTitle(v, meta, _labelJamKolam),
                                  ),
                                ),
                                topTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                rightTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                              ),
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
          if (index == 0) Navigator.pushReplacementNamed(context, "/home");
          if (index == 1) Navigator.pushReplacementNamed(context, "/statistik");
          if (index == 2) Navigator.pushReplacementNamed(context, "/setting");
        },
      ),
    );
  }
}
