import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

Future<int?> showColorPicker({
  required BuildContext context,
  required Color initialColor,
}) {
  final Widget dialog = CustomColorPicker(initialColor: initialColor);

  return showDialog<int>(
    context: context,
    builder: (context) => dialog,
  );
}

class CustomColorPicker extends StatefulWidget {
  final Color initialColor;

  const CustomColorPicker({
    super.key,
    required this.initialColor,
  });

  @override
  State<CustomColorPicker> createState() => _CustomColorPickerState();
}

class _CustomColorPickerState extends State<CustomColorPicker> {
  late Color pickedColor;

  @override
  void initState() {
    pickedColor = widget.initialColor;
    super.initState();
  }

  void _onColorChanged(Color color) {
    setState(() {
      pickedColor = color;
    });
  }

  void _handleCancel() {
    Navigator.pop(context, null);
  }

  void _handleOk() {
    Navigator.pop(context, pickedColor.value);
  }

  @override
  Widget build(BuildContext context) {
    final picker = ColorPicker(
      pickerColor: pickedColor,
      onColorChanged: _onColorChanged,
    );

    final actions = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: _handleCancel,
          child: const Text('CANCEL'),
        ),
        TextButton(
          onPressed: _handleOk,
          child: const Text('OK'),
        ),
      ],
    );

    return Dialog(
      child: Padding(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: picker),
            actions,
          ],
        ),
      ),
    );
  }
}
