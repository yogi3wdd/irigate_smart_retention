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
  bool animationTextDone = false;

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
            child: animationTextDone
                ? Text(
                    "IriGate\nSmart\nRetention",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.ruda(
                      fontSize: 40,
                      height: 1.15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.text,
                    ),
                  )
                : AnimatedTextKit(
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
                    onFinished: () {
                      setState(() {
                        animationTextDone = true;
                      });
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
