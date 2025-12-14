import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import '../../widget/circle.dart';
import '../../constants/color.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final nameController = TextEditingController();
  final roleController = TextEditingController();

  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();

    final data = doc.data();

    if (data != null) {
      nameController.text = data["nama"] ?? "";
      roleController.text = data["jabatan"] ?? "";
    }

    setState(() => loading = false);
  }

  Future<void> saveProfile() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      "nama": nameController.text,
      "jabatan": roleController.text,
    });

    Navigator.pop(context); // kembali ke halaman Setting
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Edit Profil",
          style: GoogleFonts.ruda(
            color: AppColors.text,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: AppColors.text),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                Positioned(
                  top: -78,
                  left: -114,
                  child: Circle(size: 400, color: AppColors.secondary),
                ),
                Positioned(
                  top: 620,
                  left: 108,
                  child: Circle(size: 400, color: AppColors.primary),
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        LiquidGlassLayer(
                          settings: LiquidGlassSettings(
                            thickness: 54,
                            blur: 28,
                            glassColor: Colors.transparent,
                          ),
                          child: LiquidGlass(
                            shape: LiquidRoundedRectangle(borderRadius: 20),
                            child: Container(
                              width: 300,
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextField(
                                    controller: nameController,
                                    style: TextStyle(color: AppColors.text),
                                    decoration: InputDecoration(
                                      labelText: "Nama",
                                      labelStyle: TextStyle(
                                        color: AppColors.text,
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppColors.text,
                                        ),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  TextField(
                                    controller: roleController,
                                    style: TextStyle(color: AppColors.text),
                                    decoration: InputDecoration(
                                      labelText: "Jabatan",
                                      labelStyle: TextStyle(
                                        color: AppColors.text,
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppColors.text,
                                        ),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 36),
                        LiquidGlassLayer(
                          settings: LiquidGlassSettings(
                            thickness: 54,
                            blur: 28,
                            glassColor: Colors.transparent,
                          ),
                          child: LiquidGlass(
                            shape: LiquidRoundedRectangle(borderRadius: 50),
                            child: ElevatedButton(
                              onPressed: saveProfile,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 130,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                "Simpan",
                                style: GoogleFonts.ruda(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
