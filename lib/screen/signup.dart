import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widget/circle.dart';
import '../constants/color.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  Future<void> signup() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailCtrl.text.trim(),
        password: passCtrl.text.trim(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Akun berhasil dibuat! Silakan login.")),
      );

      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Gagal mendaftar: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
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
          Center(
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
                          Text(
                            "Daftar Akun",
                            style: GoogleFonts.ruda(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.text,
                            ),
                          ),
                          const SizedBox(height: 30),
                          //NAME FIELD
                          TextField(
                            controller: nameCtrl,
                            style: GoogleFonts.ruda(color: AppColors.text),
                            decoration: InputDecoration(
                              hintText: "Masukkan nama anda",
                              labelText: "Nama",
                              hintStyle: GoogleFonts.ruda(
                                color: AppColors.textOpacity,
                                fontSize: 12,
                              ),
                              labelStyle: GoogleFonts.ruda(
                                color: AppColors.text,
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: AppColors.text),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          //EMAIL FIELD
                          TextField(
                            controller: emailCtrl,
                            style: GoogleFonts.ruda(color: AppColors.text),
                            decoration: InputDecoration(
                              hintText: "Masukkan alamat email anda",
                              labelText: "Email",
                              hintStyle: GoogleFonts.ruda(
                                color: AppColors.textOpacity,
                                fontSize: 12,
                              ),
                              labelStyle: GoogleFonts.ruda(
                                color: AppColors.text,
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: AppColors.text),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          //PASSWORD FIELD
                          TextField(
                            controller: passCtrl,
                            obscureText: true,
                            style: GoogleFonts.ruda(color: AppColors.text),
                            decoration: InputDecoration(
                              hintText: "Masukkan password anda",
                              labelText: "Password",
                              hintStyle: GoogleFonts.ruda(
                                color: AppColors.textOpacity,
                                fontSize: 12,
                              ),
                              labelStyle: GoogleFonts.ruda(
                                color: AppColors.text,
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: AppColors.text),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[a-zA-Z0-9]'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Password harus terdiri dari huruf kecil, kapital dan angka",
                            style: GoogleFonts.ruda(
                              color: AppColors.text,
                              fontSize: 12,
                            ),
                            softWrap: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 36),
                LiquidGlassLayer(
                  settings: const LiquidGlassSettings(
                    thickness: 120,
                    blur: 34,
                    glassColor: Colors.transparent,
                  ),
                  child: LiquidGlass(
                    shape: LiquidRoundedRectangle(borderRadius: 50),
                    child:
                        //LOGIN BUTTON
                        ElevatedButton(
                          onPressed: signup,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 130,
                              vertical: 12,
                            ),
                            backgroundColor: AppColors.secondaryOpacity,
                          ),
                          child: Text(
                            "Daftar",
                            style: GoogleFonts.ruda(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.text,
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
    );
  }
}
