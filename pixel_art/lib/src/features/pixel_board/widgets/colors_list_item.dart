import 'package:flutter/material.dart';
import 'package:pixel_art/src/common/utils/extensions/color_extension.dart';

class ColorsListItem extends StatelessWidget {
  final int colorValue;
  final Function() onTap;

  const ColorsListItem({
    super.key,
    required this.colorValue,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Color(colorValue);
    final borderColor = backgroundColor.invertColor();
    return InkWell(
      onTap: onTap,
      child: SizedBox(
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
    );
  }
}
