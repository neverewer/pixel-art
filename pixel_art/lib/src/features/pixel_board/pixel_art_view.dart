import 'package:flutter/material.dart';
import 'package:pixel_art/src/features/pixel_board/pixel_art_view_model.dart';
import 'package:pixel_art/src/features/pixel_board/widgets/board_app_bar.dart';
import 'package:pixel_art/src/features/pixel_board/widgets/pixel_board.dart';
import 'package:provider/provider.dart';

class PixelArtView extends StatelessWidget {
  const PixelArtView({super.key});

  @override
  Widget build(BuildContext context) {
    final int boardWidth = context.watch<PixelArtViewModel>().boardWidth;
    final int boardHeight = context.watch<PixelArtViewModel>().boardHeight;
    final double cellSize = context.watch<PixelArtViewModel>().cellSize;
    final List<List<int>> pixels = context.watch<PixelArtViewModel>().pixels;

    return Scaffold(
      appBar: const BoardAppBar(),
      body: SizedBox.expand(
        child: DecoratedBox(
          decoration: const BoxDecoration(color: Colors.black),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned.fill(
                child: Center(
                  child: pixels.isEmpty
                      ? ElevatedButton(
                          onPressed: () => context.read<PixelArtViewModel>().start(),
                          child: const Text('Start'),
                        )
                      : PixelBoard(
                          width: boardWidth,
                          height: boardHeight,
                          cellSize: cellSize,
                          pixels: pixels,
                        ),
                ),
              ),
              Positioned(
                top: 10,
                child: SizedBox(
                  width: 300,
                  child: Slider(
                    min: 1,
                    max: 32,
                    value: boardWidth.toDouble(),
                    onChanged: (value) {
                      context.read<PixelArtViewModel>().changeWidth(value.toInt());
                    },
                  ),
                ),
              ),
              Positioned(
                top: 50,
                child: SizedBox(
                  width: 300,
                  child: Slider(
                    min: 1,
                    max: 32,
                    value: boardHeight.toDouble(),
                    onChanged: (value) {
                      context.read<PixelArtViewModel>().changeHeight(value.toInt());
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
