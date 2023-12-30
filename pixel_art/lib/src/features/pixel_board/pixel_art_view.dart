import 'package:flutter/material.dart';
import 'package:pixel_art/src/features/pixel_board/pixel_art_view_model.dart';
import 'package:pixel_art/src/features/pixel_board/widgets/add_color_button.dart';
import 'package:pixel_art/src/features/pixel_board/widgets/board_app_bar.dart';
import 'package:pixel_art/src/features/pixel_board/widgets/board_size_slider.dart';
import 'package:pixel_art/src/features/pixel_board/widgets/colors_list_item.dart';
import 'package:pixel_art/src/features/pixel_board/widgets/pixel_board.dart';
import 'package:pixel_art/src/features/pixel_board/widgets/start_button.dart';
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

    return Scaffold(
      appBar: const BoardAppBar(),
      body: SizedBox.expand(
        child: DecoratedBox(
          decoration: const BoxDecoration(color: Colors.black),
          child: Stack(
            children: [
              Positioned.fill(
                child: pixels.isEmpty
                    ? const Center(child: StartButton())
                    : PixelBoard(
                        pixels: pixels,
                      ),
              ),
              Positioned(
                top: 5,
                left: 5,
                child: BoardSizeSlider(
                  value: boardWidth.toDouble(),
                  onChanged: (value) {
                    context.read<PixelArtViewModel>().changeWidth(value.toInt());
                  },
                ),
              ),
              Positioned(
                top: 35,
                left: 5,
                child: BoardSizeSlider(
                  value: boardHeight.toDouble(),
                  onChanged: (value) {
                    context.read<PixelArtViewModel>().changeHeight(value.toInt());
                  },
                ),
              ),
              const Positioned(
                top: 70,
                left: 15,
                child: ToolsBar(),
              ),
              const Positioned(
                top: 5,
                right: 5,
                child: AddColorButton(),
              ),
              Positioned(
                top: 50,
                bottom: 10,
                right: 5,
                child: SizedBox(
                  width: 110,
                  child: ListView.separated(
                    itemCount: colors.length,
                    itemBuilder: (context, index) => ColorsListItem(
                      onTap: () => context.read<PixelArtViewModel>().selectColor(index),
                      onDelete: () => context.read<PixelArtViewModel>().deleteColor(index),
                      colorValue: colors[index],
                    ),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 5,
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
