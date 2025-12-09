import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFFEEEEEE);
  static const Color text = Color(0xFF1B1B1B);
  static const Color primary = Color(0xFF8CE4FF);
  static const Color secondary = Color(0xFFFEEE91);
  static Color get primaryOpacity =>
      Color.alphaBlend(const Color.fromARGB(78, 140, 228, 255), background);

  static Color get secondaryOpacity =>
      Color.alphaBlend(const Color.fromARGB(78, 254, 238, 145), background);

  static Color get textOpacity =>
      Color.alphaBlend(const Color.fromARGB(192, 27, 27, 27), background);
}
