import 'package:flutter/material.dart';
import 'package:pixel_art/src/features/pixel_board/pixel_art_view_model.dart';
import 'package:provider/provider.dart';

class BoardAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BoardAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: double.infinity,
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          BoardAppBarLeadingButton(
            text: 'New',
            onPressed: () {},
          ),
          BoardAppBarLeadingButton(
            text: 'Import',
            onPressed: () {},
          ),
          BoardAppBarLeadingButton(
            text: 'Export',
            onPressed: () {},
          )
        ],
      ),
      actions: [
        IconButton(
          onPressed: () => context.read<PixelArtViewModel>().decreaseCellSize(),
          icon: const Icon(Icons.remove),
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

class BoardAppBarLeadingButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;

  const BoardAppBarLeadingButton({
    super.key,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          shape: const LinearBorder(),
          elevation: 0,
        ),
        child: Text(text),
      ),
    );
  }
}
