import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import '../constants/color.dart';

class liquidSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const liquidSwitch({super.key, required this.value, required this.onChanged});

  @override
  State<liquidSwitch> createState() => _liquidSwitchState();
}

class _liquidSwitchState extends State<liquidSwitch> {
  @override
  Widget build(BuildContext context) {
    const double width = 90;
    const double height = 50;
    const double knobSize = 60;

    return GestureDetector(
      onTap: () => widget.onChanged(!widget.value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: widget.value ? Color(0xFFA8FBD3) : AppColors.textOpacity,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Stack(
          children: [
            AnimatedAlign(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOutExpo,
              alignment: widget.value
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: _glassKnob(knobSize),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _glassKnob(double size) {
    return LiquidGlassLayer(
      settings: LiquidGlassSettings(
        thickness: 60,
        blur: 20,
        glassColor: Colors.transparent,
      ),
      child: LiquidGlass(
        shape: LiquidRoundedRectangle(borderRadius: 100),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }
}
