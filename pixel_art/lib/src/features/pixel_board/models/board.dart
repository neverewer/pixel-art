import 'package:flutter/foundation.dart';

@immutable
final class Board {
  late final List<List<int>> cells;

  final int width;
  final int height;

  Board({required this.width, required this.height}) {
    cells = List.generate(width, (_) => List.filled(height, 0));
  }

  @override
  bool operator ==(Object other) =>
      (identical(this, other)) ||
      other is Board && other.width == width && other.height == height && listEquals(other.cells, cells);

  @override
  int get hashCode => width.hashCode ^ height.hashCode ^ cells.hashCode;
}
