import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:hugeicons/hugeicons.dart';
import '../constants/color.dart';
import '../widget/navbar.dart';
import '../widget/switch.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool switchInlet = false;
  bool switchIrrigation = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(26),
          child: SingleChildScrollView(
            child: Column(
              children: [
                //Notif panel
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width: 30),
                        Text(
                          "Selamat datang, Yogi",
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
                //Alert panel
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(20),
                  ),
                  elevation: 0,
                  child: Container(
                    width: double.infinity,
                    height: 358,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(20),
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
                      padding: EdgeInsetsGeometry.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          HugeIcon(
                            icon: HugeIcons.strokeRoundedAlertDiamond,
                            color: Colors.redAccent,
                            size: 80,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "BAHAYA",
                            style: GoogleFonts.ruda(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Air Sungai Meluap",
                            style: GoogleFonts.ruda(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.text,
                            ),
                          ),
                          const SizedBox(height: 40),
                          Row(
                            children: [
                              Expanded(
                                child: LiquidGlassLayer(
                                  settings: LiquidGlassSettings(
                                    thickness: 54,
                                    blur: 30,
                                    glassColor: Colors.transparent,
                                  ),
                                  child: LiquidGlass(
                                    shape: LiquidRoundedRectangle(
                                      borderRadius: 20,
                                    ),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadiusGeometry.circular(20),
                                      ),
                                      elevation: 0,
                                      child: Container(
                                        height: 68,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          color: AppColors.primary,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Kapasitas Sungai",
                                              style: GoogleFonts.ruda(
                                                fontSize: 12,
                                                color: AppColors.text,
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              "75%",
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
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: LiquidGlassLayer(
                                  settings: LiquidGlassSettings(
                                    thickness: 54,
                                    blur: 30,
                                    glassColor: Colors.transparent,
                                  ),
                                  child: LiquidGlass(
                                    shape: LiquidRoundedRectangle(
                                      borderRadius: 20,
                                    ),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadiusGeometry.circular(20),
                                      ),
                                      elevation: 0,
                                      child: Container(
                                        height: 68,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          color: AppColors.secondaryOpacity,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Kapasitas Kolam",
                                              style: GoogleFonts.ruda(
                                                fontSize: 12,
                                                color: AppColors.text,
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              "75%",
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
                Row(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(20),
                            ),
                            elevation: 0,
                            child: Container(
                              height: 160,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: AppColors.primary,
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: 25,
                                  left: 12,
                                  right: 12,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Sungai",
                                      style: GoogleFonts.ruda(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.text,
                                      ),
                                    ),
                                    Icon(
                                      Icons.water_rounded,
                                      size: 34,
                                      color: AppColors.text,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0, // mulai dari bawah
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
                                          text: "17,6",
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
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Stack(
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(20),
                            ),
                            elevation: 0,
                            child: Container(
                              height: 160,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: AppColors.secondary,
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: 16,
                                  left: 12,
                                  right: 12,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Kolam\nRetensi",
                                      style: GoogleFonts.ruda(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.text,
                                      ),
                                    ),
                                    Icon(
                                      Icons.water_drop_rounded,
                                      size: 34,
                                      color: AppColors.text,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0, // mulai dari bawah
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
                                          text: "15,8",
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
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.secondary,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Gate Inlet",
                                style: GoogleFonts.ruda(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.text,
                                ),
                              ),
                              liquidSwitch(
                                value: switchInlet,
                                onChanged: (newValue) {
                                  setState(() {
                                    switchInlet = newValue;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        height: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.primary,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Gate Irigasi",
                                style: GoogleFonts.ruda(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.text,
                                ),
                              ),
                              liquidSwitch(
                                value: switchIrrigation,
                                onChanged: (newValue) {
                                  setState(() {
                                    switchIrrigation = newValue;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
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
}
