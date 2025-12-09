import 'dart:ui';
import 'package:flutter/material.dart';

class Circle extends StatelessWidget {
  final double size;
  final Color color;
  final double opacity;
  final double blur;

  const Circle({
    super.key,
    required this.size,
    required this.color,
    this.opacity = 0.3,
    this.blur = 30,
  });

  Color _opacity(Color base, double opacity) {
    final int alpha = (opacity * 255).round().clamp(0, 255);
    return base.withAlpha(alpha);
  }

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _opacity(color, opacity),
        ),
      ),
    );
  }
}
