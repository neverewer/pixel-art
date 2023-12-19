import 'package:flutter/material.dart';
import 'package:pixel_art/src/features/pixel_board/pixel_art_view.dart';
import 'package:pixel_art/src/features/pixel_board/pixel_art_view_model.dart';
import 'package:provider/provider.dart';

class PixelArtPage extends StatelessWidget {
  const PixelArtPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PixelArtViewModel(),
      child: const PixelArtView(),
    );
  }
}
