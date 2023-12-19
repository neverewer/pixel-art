import 'package:flutter/material.dart';

class Cell {
  static const Color _defaultColor = Colors.white;
  int value = 0;
  Color color = _defaultColor;

  Cell(int value);

  static Cell empty() {
    return Cell(0);
  }

  void select(Color newColor) {
    value = 1;
    color = newColor;
  }

  void reset() {
    value = 0;
    color = _defaultColor;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Cell && other.value == value && other.color == color;
}
