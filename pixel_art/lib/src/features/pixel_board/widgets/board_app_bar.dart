import 'package:flutter/material.dart';
import 'package:pixel_art/src/features/pixel_board/pixel_art_view_model.dart';
import 'package:provider/provider.dart';

class BoardAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BoardAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: double.infinity,
      leading: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: 5),
          Text('New'),
          SizedBox(width: 5),
          Text('Import'),
          SizedBox(width: 5),
          Text('Export'),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () => context.read<PixelArtViewModel>().decreaseCellSize(),
          icon: const Icon(Icons.remove),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.equalizer),
        ),
        IconButton(
          onPressed: () => context.read<PixelArtViewModel>().increaseCellSize(),
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
