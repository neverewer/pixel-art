import 'package:flutter/material.dart';
import 'package:pixel_art/src/features/pixel_board/pixel_art_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PixelArtPage(),
    );
  }
}
