import 'package:flutter/material.dart';

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
          onPressed: () {},
          icon: const Icon(Icons.remove),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.equalizer),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
