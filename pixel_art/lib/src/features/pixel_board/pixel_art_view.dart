import 'package:flutter/material.dart';
import 'package:pixel_art/src/features/pixel_board/pixel_art_view_model.dart';
import 'package:pixel_art/src/features/pixel_board/widgets/board_app_bar.dart';
import 'package:pixel_art/src/features/pixel_board/widgets/colors_list_item.dart';
import 'package:pixel_art/src/features/pixel_board/widgets/pixel_board.dart';
import 'package:pixel_art/src/features/pixel_board/widgets/tools_bar.dart';
import 'package:provider/provider.dart';

class PixelArtView extends StatelessWidget {
  const PixelArtView({super.key});

  @override
  Widget build(BuildContext context) {
    final int boardWidth = context.watch<PixelArtViewModel>().boardWidth;
    final int boardHeight = context.watch<PixelArtViewModel>().boardHeight;
    final List<List<int>> pixels = context.watch<PixelArtViewModel>().pixels;
    final List<int> colors = context.watch<PixelArtViewModel>().colors;
    final double cellSize = context.watch<PixelArtViewModel>().cellSize;

    return Scaffold(
      appBar: const BoardAppBar(),
      body: SizedBox.expand(
        child: DecoratedBox(
          decoration: const BoxDecoration(color: Colors.black),
          child: Stack(
            children: [
              pixels.isEmpty
                  ? Positioned.fill(
                      child: Center(
                      child: ElevatedButton(
                        onPressed: () => context.read<PixelArtViewModel>().start(),
                        child: const Text('Start'),
                      ),
                    ))
                  : Positioned.fill(
                      child: Center(
                        child: PixelBoard(
                          width: boardWidth,
                          height: boardHeight,
                          cellSize: cellSize,
                          pixels: pixels,
                        ),
                      ),
                    ),
              Positioned(
                top: 5,
                left: 5,
                child: SizedBox(
                  width: 150,
                  child: Slider(
                    min: 1,
                    max: 32,
                    label: boardWidth.toString(),
                    value: boardWidth.toDouble(),
                    onChanged: (value) {
                      context.read<PixelArtViewModel>().changeWidth(value.toInt());
                    },
                  ),
                ),
              ),
              Positioned(
                top: 35,
                left: 5,
                child: SizedBox(
                  width: 150,
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
              const Positioned(
                top: 70,
                left: 15,
                child: ToolsBar(),
              ),
              Positioned(
                top: 10,
                bottom: 10,
                right: 5,
                child: SizedBox(
                  width: 65,
                  child: ListView.builder(
                    itemCount: colors.length,
                    itemExtent: 35,
                    itemBuilder: (context, index) => ColorsListItem(
                      onTap: () => context.read<PixelArtViewModel>().selectColor(index),
                      colorValue: colors[index],
                    ),
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
