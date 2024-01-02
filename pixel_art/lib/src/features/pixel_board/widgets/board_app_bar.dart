import 'package:flutter/material.dart';
import 'package:pixel_art/src/features/dialogs/selectable_text_dialog.dart';
import 'package:pixel_art/src/features/dialogs/text_input_dialog.dart';
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
            onPressed: () => context.read<PixelArtViewModel>().newBoard(),
          ),
          BoardAppBarLeadingButton(
              text: 'Import',
              onPressed: () async {
                var vm = context.read<PixelArtViewModel>();
                final text = await showTextInputDialog(context: context);
                if (text != null) {
                  vm.import(text);
                }
              }),
          BoardAppBarLeadingButton(
            text: 'Export',
            onPressed: () {
              var data = context.read<PixelArtViewModel>().export();
              return showSelectableTextDialog(context: context, data: data);
            },
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
