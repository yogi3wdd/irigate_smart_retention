import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/color.dart';

class Navbar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const Navbar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
      child: LiquidGlassLayer(
        settings: LiquidGlassSettings(
          thickness: 80,
          blur: 56,
          glassColor: Colors.transparent,
        ),
        child: LiquidGlass(
          shape: LiquidRoundedRectangle(borderRadius: 50),
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.transparent,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavItem(Icons.home_rounded, "Home", 0),
                _buildNavItem(Icons.bar_chart_rounded, "Statistik", 1),
                _buildNavItem(Icons.settings_rounded, "Setting", 2),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool active = index == currentIndex;

    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 28,
            color: active ? AppColors.text : AppColors.text.withAlpha(180),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.ruda(
              fontSize: 10,
              color: active ? AppColors.text : AppColors.text.withAlpha(180),
            ),
          ),
        ],
      ),
    );
  }
}
