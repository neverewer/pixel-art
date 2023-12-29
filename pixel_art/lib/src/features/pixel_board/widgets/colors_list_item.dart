import 'package:flutter/material.dart';
import 'package:pixel_art/src/common/utils/extensions/color_extension.dart';

class ColorsListItem extends StatelessWidget {
  final int colorValue;
  final Function() onTap;
  final Function() onDelete;

  const ColorsListItem({super.key, required this.colorValue, required this.onTap, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Color(colorValue);
    final borderColor = backgroundColor.invertColor();
    return SizedBox(
      height: 35,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: InkWell(
              onTap: onTap,
              child: SizedBox(
                height: double.infinity,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    border: Border.all(
                      color: borderColor,
                      width: 3,
                    ),
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: onDelete,
            padding: EdgeInsets.zero,
            icon: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
