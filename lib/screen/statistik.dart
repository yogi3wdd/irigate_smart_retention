import 'package:flutter/material.dart';
import '../constants/color.dart';
import '../widget/navbar.dart';

class Statistik extends StatelessWidget {
  const Statistik({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(child: Padding(padding: EdgeInsetsGeometry.all(26))),
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
