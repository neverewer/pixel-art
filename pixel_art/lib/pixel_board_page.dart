import 'package:flutter/material.dart';
import 'package:pixel_art/board_app_bar.dart';
import 'package:pixel_art/pixel_board.dart';

class PixelBoardPage extends StatefulWidget {
  const PixelBoardPage({super.key});

  @override
  State<PixelBoardPage> createState() => _PixelBoardPageState();
}

class _PixelBoardPageState extends State<PixelBoardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BoardAppBar(),
      body: SizedBox.expand(
        child: DecoratedBox(
          decoration: const BoxDecoration(color: Colors.black),
          child: Stack(
            children: [
              Positioned.fill(
                  child:
                      // InteractiveViewer(
                      //   alignment: Alignment.center,
                      //   constrained: false,
                      //   child: const PixelBoard(),
                      // ),
                      TwoDimensionalScrollable(
                horizontalDetails: const ScrollableDetails.horizontal(),
                verticalDetails: const ScrollableDetails.vertical(),
                viewportBuilder: ((context, verticalPosition, horizontalPosition) {
                  return const Center(child: PixelBoard());
                }),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
