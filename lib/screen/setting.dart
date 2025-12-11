import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import '../constants/color.dart';
import '../widget/navbar.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  Future<Map<String, dynamic>?> getUserData() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();

    return doc.data();
  }

  @override
  void initState() {
    super.initState();
    _handlePermission();
  }

  Future<void> _handlePermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      print("Izin lokasi ditolak permanen");
    }
  }

  Stream<Position> getPositionStream() {
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
    );

    return Geolocator.getPositionStream(locationSettings: locationSettings);
  }

  Future<String> getAddressFromPosition(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      Placemark place = placemarks.first;

      String desa = place.subLocality ?? "";
      String kecamatan = place.locality ?? "";
      String kabupaten = place.subAdministrativeArea ?? "";
      String provinsi = place.administrativeArea ?? "";

      return "$desa, Kec. $kecamatan, Kab. $kabupaten, $provinsi";
    } catch (e) {
      print("Error geocoding: $e");
      return "Tidak dapat memproses alamat";
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> data = [
      {"title": "Nomor Darurat", "number": "112"},
      {"title": "Nomor Posko Bencana", "number": "129"},
      {"title": "Nomor Basarnas", "number": "115"},
      {"title": "Nomor Ambulans", "number": "118"},
    ];

    final List<Color> bgColors = [
      AppColors.primary.withAlpha(34),
      AppColors.secondary.withAlpha(34),
    ];
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(26),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    LiquidGlassLayer(
                      settings: LiquidGlassSettings(
                        blur: 34,
                        thickness: 64,
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
                            width: double.infinity,
                            height: 228,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadiusDirectional.circular(
                                20,
                              ),
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  AppColors.secondaryOpacity,
                                  AppColors.primaryOpacity,
                                ],
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 24,
                                left: 16,
                                right: 16,
                              ),
                              child: FutureBuilder<Map<String, dynamic>?>(
                                future: getUserData(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }

                                  final user =
                                      FirebaseAuth.instance.currentUser!;
                                  final data = snapshot.data!;

                                  return Column(
                                    children: [
                                      HugeIcon(
                                        icon: HugeIcons.strokeRoundedUserCircle,
                                        size: 65,
                                        color: AppColors.text,
                                        strokeWidth: 1.5,
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        data["nama"] ?? "Nama tidak tersedia",
                                        style: GoogleFonts.ruda(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.text,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        data["jabatan"] ??
                                            "Jobdesk tidak tersedia",
                                        style: GoogleFonts.ruda(
                                          fontSize: 12,
                                          color: AppColors.text,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        user.email ?? "Email tidak tersedia",
                                        style: GoogleFonts.ruda(
                                          fontSize: 12,
                                          color: AppColors.text,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 16,
                      bottom: 16,
                      child: LiquidGlassLayer(
                        settings: LiquidGlassSettings(
                          blur: 34,
                          thickness: 64,
                          glassColor: Colors.transparent,
                        ),
                        child: LiquidGlass(
                          shape: LiquidOval(),
                          child: Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.transparent,
                            ),
                            child: GestureDetector(
                              onTap: () async {
                                Navigator.pushNamed(context, '/edit-profile');
                              },
                              child: Center(
                                child: HugeIcon(
                                  icon: HugeIcons.strokeRoundedPencilEdit02,
                                  color: AppColors.text,
                                  size: 18,
                                  strokeWidth: 1.5,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.secondaryOpacity,
                  ),
                  child: StreamBuilder<Position>(
                    stream: getPositionStream(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return _loadingLocationTile();
                      }

                      final pos = snapshot.data!;

                      return FutureBuilder<String>(
                        future: getAddressFromPosition(pos),
                        builder: (context, addressSnapshot) {
                          final alamat =
                              addressSnapshot.data ?? "Memproses alamat...";

                          return _locationTile(alamat);
                        },
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return LiquidGlassLayer(
                      settings: LiquidGlassSettings(
                        blur: 46,
                        thickness: 78,
                        glassColor: Colors.transparent,
                      ),
                      child: LiquidGlass(
                        shape: LiquidRoundedRectangle(borderRadius: 20),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: bgColors[index % bgColors.length],
                          ),
                          padding: EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                data[index]["title"]!,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.ruda(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.text,
                                ),
                              ),
                              Text(
                                data[index]["number"]!,
                                style: GoogleFonts.ruda(
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.text,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: LiquidGlassLayer(
                    settings: LiquidGlassSettings(
                      blur: 46,
                      thickness: 78,
                      glassColor: Colors.transparent,
                    ),
                    child: LiquidGlass(
                      shape: LiquidRoundedRectangle(borderRadius: 30),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.redAccent.withAlpha(24),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            HugeIcon(
                              icon: HugeIcons.strokeRoundedLogout02,
                              color: AppColors.text,
                              size: 32,
                              strokeWidth: 1.5,
                            ),
                            SizedBox(width: 16),
                            Text(
                              "Keluar dari akun",
                              style: GoogleFonts.ruda(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.text,
                              ),
                            ),
                          ],
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
      bottomNavigationBar: Navbar(
        currentIndex: 2,
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

  Widget _loadingLocationTile() {
    return ListTile(
      contentPadding: EdgeInsets.all(16),
      title: Text(
        "Lokasi",
        style: GoogleFonts.ruda(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: AppColors.text,
        ),
      ),
      subtitle: Text(
        "Mengambil lokasi...",
        style: GoogleFonts.ruda(fontSize: 16, color: AppColors.text),
      ),
    );
  }

  Widget _locationTile(String alamat) {
    return ListTile(
      contentPadding: EdgeInsets.all(16),
      leading: HugeIcon(
        icon: HugeIcons.strokeRoundedLocation03,
        color: AppColors.text,
        size: 36,
      ),
      title: Text(
        "Lokasi Sekarang",
        style: GoogleFonts.ruda(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: AppColors.text,
        ),
      ),
      subtitle: Text(
        alamat,
        style: GoogleFonts.ruda(fontSize: 16, color: AppColors.text),
      ),
    );
  }
}
