import 'package:flutter/material.dart';

class Pixel extends StatelessWidget {
  final double size;
  final Color color;
  final Color borderColor;
  final double borderWidth;

  const Pixel({
    super.key,
    required this.size,
    required this.color,
    required this.borderColor,
    required this.borderWidth,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          border: Border.all(
            color: borderColor,
            width: borderWidth,
          ),
        ),
      ),
    );
  }
}
