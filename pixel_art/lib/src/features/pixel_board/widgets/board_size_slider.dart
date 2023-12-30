import 'package:flutter/material.dart';

class BoardSizeSlider extends StatelessWidget {
  final double value;
  final Function(double)? onChanged;

  const BoardSizeSlider({
    super.key,
    required this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Slider(
        min: 1,
        max: 32,
        label: value.toString(),
        value: value.toDouble(),
        onChanged: onChanged,
      ),
    );
  }
}
