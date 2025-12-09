import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../widget/circle.dart';
import '../constants/color.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
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
            child: AnimatedTextKit(
              isRepeatingAnimation: false,
              totalRepeatCount: 1,
              animatedTexts: [
                ColorizeAnimatedText(
                  "IriGate\nSmart\nResistance",
                  textStyle: GoogleFonts.ruda(
                    fontSize: 40,
                    height: 1.15,
                    fontWeight: FontWeight.bold,
                  ),
                  colors: [AppColors.primary, AppColors.secondary],
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
