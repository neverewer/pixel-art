import 'package:flutter/material.dart';
import 'package:pixel_art/src/features/pixel_board/models/tools.dart';
import 'package:pixel_art/src/features/pixel_board/pixel_art_view_model.dart';
import 'package:provider/provider.dart';

class ToolsBar extends StatelessWidget {
  const ToolsBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(color: Colors.black),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () => context.read<PixelArtViewModel>().changeTool(Tools.pan),
              icon: const Icon(
                Icons.pan_tool,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () => context.read<PixelArtViewModel>().changeTool(Tools.pen),
              icon: const Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () => context.read<PixelArtViewModel>().changeTool(Tools.fill),
              icon: const Icon(
                Icons.format_color_fill,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
