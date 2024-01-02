import 'package:flutter/material.dart';

Future<String?> showTextInputDialog({
  required BuildContext context,
}) {
  const Widget dialog = TextInputDialog();

  return showDialog<String>(
    context: context,
    builder: (context) => dialog,
  );
}

class TextInputDialog extends StatefulWidget {
  const TextInputDialog({super.key});

  @override
  State<TextInputDialog> createState() => _TextInputDialogState();
}

class _TextInputDialogState extends State<TextInputDialog> {
  final TextEditingController _controller = TextEditingController();

  void _handleCancel() {
    Navigator.pop(context, null);
  }

  void _handleOk() {
    Navigator.pop(context, _controller.text);
  }

  @override
  Widget build(BuildContext context) {
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
        child: SizedBox(
          width: 300,
          height: 300,
          child: Column(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  expands: true,
                  maxLines: null,
                  textAlignVertical: TextAlignVertical.top,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(border: OutlineInputBorder()),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              actions,
            ],
          ),
        ),
      ),
    );
  }
}
