import 'dart:ui';

extension ColorExtension on Color {
  Color invertColor() => Color.fromARGB(alpha, 255 - red, 255 - green, 255 - blue);
}
