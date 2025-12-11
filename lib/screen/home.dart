import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import '../constants/color.dart';
import '../widget/navbar.dart';
import '../widget/switch.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final db = FirebaseDatabase.instance.ref();

  List<StreamSubscription> listeners = [];

  // Switch Gate
  bool switchInlet = false;
  bool switchIrrigation = false;

  // Variabel Status
  String kategori = "Aman";
  double tinggiSungai = 0.0;
  double tinggiKolam = 0.0;

  // Variabel Tinggi Maks
  double tinggiMaksSungai = 40;
  double tinggiMaksKolam = 20;

  // Variabel User
  String namaUser = "";

  @override
  void initState() {
    super.initState();
    listenGate();
    listenMonitoring();
    getUserName();
  }

  @override
  void dispose() {
    for (var sub in listeners.toList()) {
      sub.cancel();
    }
    listeners.clear();
    super.dispose();
  }

  // Ambil nama user dari Firestore
  void getUserName() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final uid = user.uid;

    final doc = await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .get();

    if (doc.exists) {
      final fullName = doc.data()?["nama"] ?? "";
      setState(() {
        namaUser = fullName.split(" ").first; // Nama depan
      });
    }
  }

  // Listener untuk Gate
  void listenGate() {
    listeners.add(
      db.child("gate/inlet").onValue.listen((event) {
        final value = event.snapshot.value;
        if (mounted) setState(() => switchInlet = value == true);
      }),
    );

    listeners.add(
      db.child("gate/irigasi").onValue.listen((event) {
        final value = event.snapshot.value;
        if (mounted) setState(() => switchIrrigation = value == true);
      }),
    );
  }

  // Listener untuk Data Monitoring
  void listenMonitoring() {
    listeners.add(
      db.child("monitoring/status/kategori").onValue.listen((event) {
        final value = event.snapshot.value;
        if (value != null) setState(() => kategori = value.toString());
      }),
    );

    listeners.add(
      db.child("monitoring/status/tinggiSungai").onValue.listen((event) {
        final value = event.snapshot.value;
        if (value != null)
          setState(() => tinggiSungai = (value as num).toDouble());
      }),
    );

    listeners.add(
      db.child("monitoring/status/tinggiKolam").onValue.listen((event) {
        final value = event.snapshot.value;
        if (value != null)
          setState(() => tinggiKolam = (value as num).toDouble());
      }),
    );

    listeners.add(
      db.child("monitoring/status/tinggiMaksSungai").onValue.listen((event) {
        final value = event.snapshot.value;
        if (value != null)
          setState(() => tinggiMaksSungai = (value as num).toDouble());
      }),
    );

    listeners.add(
      db.child("monitoring/status/tinggiMaksKolam").onValue.listen((event) {
        final value = event.snapshot.value;
        if (value != null)
          setState(() => tinggiMaksKolam = (value as num).toDouble());
      }),
    );
  }

  // Warna kategori
  Color kategoriColor() {
    switch (kategori.toLowerCase()) {
      case "bahaya":
        return Colors.redAccent;
      case "siaga":
        return Colors.orangeAccent;
      default:
        return Colors.greenAccent;
    }
  }

  // Pesan kategori
  String kategoriMessage() {
    switch (kategori.toLowerCase()) {
      case "bahaya":
        return "Air sungai telah meluap";
      case "siaga":
        return "Air sungai menyentuh ambang batas";
      case "aman":
        return "Kondisi sungai sedang tenang dan aman";
      default:
        return "Status sungai tidak diketahui";
    }
  }

  @override
  Widget build(BuildContext context) {
    // Hitung persen kapasitas
    final persenSungai = (tinggiSungai / tinggiMaksSungai) * 100;
    final persenKolam = (tinggiKolam / tinggiMaksKolam) * 100;

    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(26),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width: 30),
                        Text(
                          "Selamat datang, ${namaUser.isEmpty ? "..." : namaUser}",
                          style: GoogleFonts.ruda(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.text,
                          ),
                        ),
                        Text(
                          "IriGate Smart Resistance",
                          style: GoogleFonts.ruda(
                            fontSize: 14,
                            color: AppColors.text,
                          ),
                        ),
                      ],
                    ),

                    // Icon Notif
                    Align(
                      alignment: Alignment.topRight,
                      child: LiquidGlassLayer(
                        settings: LiquidGlassSettings(
                          thickness: 64,
                          blur: 54,
                          glassColor: Colors.transparent,
                        ),
                        child: LiquidGlass(
                          shape: LiquidOval(),
                          child: Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  AppColors.primaryOpacity,
                                  AppColors.secondaryOpacity,
                                ],
                              ),
                            ),
                            child: Center(
                              child: HugeIcon(
                                icon: HugeIcons.strokeRoundedNotification01,
                                color: AppColors.textOpacity,
                                size: 20,
                                strokeWidth: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Alert Panel
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 0,
                  child: Container(
                    width: double.infinity,
                    height: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.secondaryOpacity,
                          AppColors.primaryOpacity,
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          HugeIcon(
                            icon: HugeIcons.strokeRoundedAlertDiamond,
                            color: kategoriColor(),
                            size: 80,
                          ),
                          const SizedBox(height: 20),

                          // KATEGORI
                          Text(
                            kategori.toUpperCase(),
                            style: GoogleFonts.ruda(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: kategoriColor(),
                            ),
                          ),

                          const SizedBox(height: 10),

                          Text(
                            kategoriMessage(),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.ruda(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.text,
                            ),
                          ),

                          const SizedBox(height: 40),

                          Row(
                            children: [
                              // Kapasitas Sungai (%)
                              Expanded(
                                child: kapasitasCard(
                                  title: "Kapasitas Sungai",
                                  persen: persenSungai,
                                  cardColor: AppColors.primaryOpacity,
                                ),
                              ),
                              const SizedBox(width: 10),

                              // Kapasitas Kolam (%)
                              Expanded(
                                child: kapasitasCard(
                                  title: "Kapasitas Kolam",
                                  persen: persenKolam,
                                  cardColor: AppColors.secondaryOpacity,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Tinggi Sungai & Kolam
                Row(
                  children: [
                    Expanded(
                      child: tinggiCard(
                        title: "Sungai",
                        value: tinggiSungai,
                        icon: Icons.water_rounded,
                        color: AppColors.primaryOpacity,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: tinggiCard(
                        title: "Kolam\nRetensi",
                        value: tinggiKolam,
                        icon: Icons.water_drop_rounded,
                        color: AppColors.secondaryOpacity,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // Gate Control
                Row(
                  children: [
                    Expanded(
                      child: gateCard(
                        title: "Gate Inlet",
                        value: switchInlet,
                        color: AppColors.secondary,
                        onChanged: (val) => db.child("gate/inlet").set(val),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: gateCard(
                        title: "Gate Irigasi",
                        value: switchIrrigation,
                        color: AppColors.primary,
                        onChanged: (val) => db.child("gate/irigasi").set(val),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),

      // Navbar
      bottomNavigationBar: Navbar(
        currentIndex: 0,
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

  // WIDGET KAPASITAS CARD
  Widget kapasitasCard({
    required String title,
    required double persen,
    required Color cardColor,
  }) {
    return LiquidGlassLayer(
      settings: LiquidGlassSettings(
        thickness: 54,
        blur: 30,
        glassColor: Colors.transparent,
      ),
      child: LiquidGlass(
        shape: LiquidRoundedRectangle(borderRadius: 20),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: cardColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: GoogleFonts.ruda(fontSize: 12, color: AppColors.text),
                ),
                const SizedBox(height: 2),
                Text(
                  "${persen.toStringAsFixed(0)}%",
                  style: GoogleFonts.ruda(
                    fontSize: 24,
                    color: AppColors.text,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // WIDGET TINGGI CARD
  Widget tinggiCard({
    required String title,
    required double value,
    required IconData icon,
    required Color color,
  }) {
    return Stack(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
          child: Container(
            height: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: color,
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 25, left: 12, right: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.ruda(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.text,
                    ),
                  ),
                  Icon(icon, size: 34, color: AppColors.text),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: 90,
          child: LiquidGlassLayer(
            settings: LiquidGlassSettings(
              thickness: 48,
              blur: 24,
              glassColor: Colors.transparent,
            ),
            child: LiquidGlass(
              shape: LiquidRoundedRectangle(borderRadius: 20),
              child: Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: value.toStringAsFixed(1),
                        style: GoogleFonts.ruda(
                          fontSize: 40,
                          color: AppColors.text,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      WidgetSpan(child: SizedBox(width: 6)),
                      TextSpan(
                        text: "meter",
                        style: GoogleFonts.ruda(
                          fontSize: 14,
                          color: AppColors.text,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // WIDGET GATE CARD
  Widget gateCard({
    required String title,
    required bool value,
    required Color color,
    required Function(bool) onChanged,
  }) {
    return Container(
      height: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color,
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: GoogleFonts.ruda(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),
            ),
            liquidSwitch(value: value, onChanged: onChanged),
          ],
        ),
      ),
    );
  }
}
