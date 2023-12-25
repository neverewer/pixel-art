// import 'package:flutter/material.dart';
// import 'package:pixel_art/src/features/pixel_board/widgets/pixel_board.dart';

// class CenterInterectiveViewer extends StatefulWidget {
//   final Widget child;
//   final bool isScrollEnabled;

//   const CenterInterectiveViewer({
//     super.key,
//     required this.child,
//     required this.isScrollEnabled,
//   });

//   @override
//   State<CenterInterectiveViewer> createState() => _CenterInterectiveViewerState();
// }

// class _CenterInterectiveViewerState extends State<CenterInterectiveViewer> {
//   final TransformationController _controller = TransformationController();



//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return InteractiveViewer(
//       transformationController: _controller,
//       constrained: true,
//       minScale: 0.5,
//       maxScale: 2.5,
//       panEnabled: widget.isScrollEnabled,
//       scaleEnabled: widget.isScrollEnabled,
//       clipBehavior: Clip.none,
//       boundaryMargin: const EdgeInsets.all(5),
//       child: PixelBoard(width: width, height: height, cellSize: cellSize, pixels: pixels),
//     );
//   }
// }
