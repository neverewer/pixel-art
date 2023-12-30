import 'package:flutter/material.dart';
import 'package:pixel_art/src/features/dialogs/custom_color_picker.dart';
import 'package:pixel_art/src/features/pixel_board/pixel_art_view_model.dart';
import 'package:provider/provider.dart';

class AddColorButton extends StatelessWidget {
  const AddColorButton({super.key});

  void showColorPickerDialog(BuildContext context) async {
    final vm = context.read<PixelArtViewModel>();
    final pickedColor = await showColorPicker(context: context, initialColor: Colors.black);
    if (pickedColor != null) {
      vm.addColor(pickedColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110,
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          shape: const LinearBorder(),
        ),
        onPressed: () => showColorPickerDialog(context),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
