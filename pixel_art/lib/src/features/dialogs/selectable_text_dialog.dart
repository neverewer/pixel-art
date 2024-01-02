import 'package:flutter/material.dart';

Future<void> showSelectableTextDialog({
  required BuildContext context,
  required String data,
}) {
  final Widget dialog = SelectableTextDialog(data: data);

  return showDialog(
    context: context,
    builder: (context) => dialog,
  );
}

class SelectableTextDialog extends StatelessWidget {
  final String data;

  const SelectableTextDialog({
    super.key,
    required this.data,
  });

  void _handleOk(BuildContext context) => Navigator.pop(context);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 8),
        child: SizedBox(
          width: 300,
          height: 300,
          child: Column(
            children: [
              Expanded(
                child: SelectableText(
                  data,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              TextButton(
                onPressed: () => _handleOk(context),
                child: const Text('OK'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
