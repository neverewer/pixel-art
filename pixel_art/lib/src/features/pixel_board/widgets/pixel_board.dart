import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pixel_art/src/common/utils/extensions/color_extension.dart';
import 'package:pixel_art/src/features/pixel_board/models/tools.dart';
import 'package:pixel_art/src/features/pixel_board/pixel_art_view_model.dart';
import 'package:pixel_art/src/features/pixel_board/widgets/pixel.dart';
import 'package:pixel_art/src/features/pixel_board/widgets/pixel_render_object.dart';
import 'package:pixel_art/src/features/pixel_board/widgets/two_dimensional_grid_view.dart';
import 'package:provider/provider.dart';

class PixelBoard extends StatefulWidget {
  final List<List<int>> pixels;
  final List<int> colors;

  const PixelBoard({
    super.key,
    required this.pixels,
    required this.colors,
  });

  @override
  State<PixelBoard> createState() => _PixelBoardState();
}

class _PixelBoardState extends State<PixelBoard> {
  final GlobalKey _gridKey = GlobalKey();
  late final RenderBox gridRenderBox;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      gridRenderBox = _gridKey.currentContext!.findRenderObject() as RenderBox;
    });
    super.initState();
  }

  void paintCell(Offset pointerPosition) {
    final result = BoxHitTestResult();
    Offset local = gridRenderBox.globalToLocal(pointerPosition);
    if (gridRenderBox.hitTest(result, position: local)) {
      for (final HitTestEntry entry in result.path) {
        final HitTestTarget target = entry.target;
        if (target is PixelProxyBox) {
          context.read<PixelArtViewModel>().selectCell(target.xIndex, target.yIndex);
          return;
        }
      }
    }
  }

  void fillCells(BuildContext context, Tools tool) {
    if (tool != Tools.fill) {
      return;
    }
    context.read<PixelArtViewModel>().fillPixels();
  }

  void fillOrPaint(Offset pointerPosition, Tools tool) {
    if (tool == Tools.pan) {
      return;
    } else if (tool == Tools.pen) {
      paintCell(pointerPosition);
    } else {
      fillCells(context, tool);
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedTool = context.watch<PixelArtViewModel>().selectedTool;
    final double cellSize = context.watch<PixelArtViewModel>().cellSize;
    final physics = selectedTool == Tools.pan ? const ClampingScrollPhysics() : const NeverScrollableScrollPhysics();

    return Listener(
      onPointerDown: (event) => fillOrPaint(event.position, selectedTool),
      onPointerMove: (event) => selectedTool == Tools.pen ? paintCell(event.position) : null,
      child: TwoDimensionalGridView(
        key: _gridKey,
        itemSize: cellSize,
        horizontalDetails: ScrollableDetails.horizontal(physics: physics),
        verticalDetails: ScrollableDetails.vertical(physics: physics),
        delegate: TwoDimensionalChildBuilderDelegate(
          maxXIndex: widget.pixels.length - 1,
          maxYIndex: widget.pixels.first.length - 1,
          builder: (BuildContext context, ChildVicinity vicinity) {
            final int value = widget.pixels.elementAt(vicinity.xIndex).elementAt(vicinity.yIndex);
            final backgroundCellColor = Color(widget.colors[value]);
            return PixelRenderObject(
              xIndex: vicinity.xIndex,
              yIndex: vicinity.yIndex,
              child: Pixel(
                size: cellSize,
                color: backgroundCellColor,
                borderColor: backgroundCellColor.invertColor(),
                borderWidth: cellSize * 0.035,
              ),
            );
          },
        ),
      ),
    );
  }
}

// class ArrayFlowDelegate extends FlowDelegate {
//   final Size size;
//   final PixelArtViewModel viewModel;

//   ArrayFlowDelegate({
//     required this.size,
//     required this.viewModel,
//   }) : super(repaint: viewModel);

//   @override
//   void paintChildren(FlowPaintingContext context) {
//     int childIndex = 0;
//     double x;
//     double y;
//     final cellSize = viewModel.cellSize;
//     final scrollOffset = viewModel.scrollOffset;
//     final pixels = viewModel.pixels;
//     final width = pixels.length;
//     final height = pixels[0].length;
//     final scrollX = scrollOffset.dx;
//     final scrollY = scrollOffset.dy;

//     for (int i = 0; i < width; i++) {
//       for (int j = 0; j < height; j++) {
//         x = cellSize * i + size.width / 2 - (width * cellSize / 2) + scrollX;
//         y = cellSize * j + size.height / 2 - (height * cellSize / 2) + scrollY;
//         context.paintChild(childIndex, transform: Matrix4.translationValues(x, y, 0.0));
//         childIndex++;
//       }
//     }
//   }

//   @override
//   bool shouldRepaint(ArrayFlowDelegate oldDelegate) =>
//       !identical(oldDelegate.viewModel.pixels, viewModel.pixels) &&
//       !identical(oldDelegate.viewModel.scrollOffset, viewModel.scrollOffset);
// }

// Flow(
//                   delegate: flowDelegate,
//                   children: widget.pixels.expand((row) {
//                     return row.map((value) {
//                       return Pixel(
//                         size: widget.cellSize,
//                         color: Color(colors[value]),
//                         borderColor: value == 0 ? Colors.black : Colors.white,
//                         borderWidth: widget.cellSize * 0.035,
//                       );
//                     });
//                   }).toList()),

//  Rect axisAlignedBoundingBox(Quad quad) {
//     double? xMin;
//     double? xMax;
//     double? yMin;
//     double? yMax;
//     for (final Vector3 point in <Vector3>[quad.point0, quad.point1, quad.point2, quad.point3]) {
//       if (xMin == null || point.x < xMin) {
//         xMin = point.x;
//       }
//       if (xMax == null || point.x > xMax) {
//         xMax = point.x;
//       }
//       if (yMin == null || point.y < yMin) {
//         yMin = point.y;
//       }
//       if (yMax == null || point.y > yMax) {
//         yMax = point.y;
//       }
//     }
//     return Rect.fromLTRB(xMin!, yMin!, xMax!, yMax!);
//   }

//   late int _firstVisibleColumn;
//   late int _firstVisibleRow;
//   late int _lastVisibleColumn;
//   late int _lastVisibleRow;

//   bool isCellVisible(int x, int y, Quad viewport) {
//     final Rect aabb = axisAlignedBoundingBox(viewport);
//     _firstVisibleRow = (aabb.top / 30).floor();
//     _firstVisibleColumn = (aabb.left / 30).floor();
//     _lastVisibleRow = (aabb.bottom / 30).floor();
//     _lastVisibleColumn = (aabb.right / 30).floor();

//     return x >= _firstVisibleRow && x <= _lastVisibleRow && y >= _firstVisibleColumn && y <= _lastVisibleColumn;
//   }

// return InteractiveViewer.builder(
//         boundaryMargin: const EdgeInsets.all(100),
//         panEnabled: selectedTool == Tools.pan,
//         scaleEnabled: selectedTool == Tools.pan,
//         builder: (context, viewport) {
//           return SizedBox(
//             width: boardSize.width,
//             height: boardSize.height,
//             child: IgnorePointer(
//                 ignoring: selectedTool == Tools.pan,
//                 child: GestureDetector(
//                   onPanUpdate: (details) => selectCell(context, details.localPosition, selectedTool),
//                   onTapDown: (details) => selectCell(context, details.localPosition, selectedTool),
//                   child:
//                       // onTap: () => fillCells(context, selectedTool),
//                       // // onPanStart: (details) =>
//                       // //     selectedTool == Tools.pen ? selectCell(context, details.localPosition, selectedTool) : null,
//                       //     scroll(details.delta.dx, details.delta.dy, size, boardSize, selectedTool),
//                       // // onVerticalDragUpdate: (details) => selectedTool == Tools.pan
//                       // //     ? verticalDrag(details.delta.dy, size.height, boardSize.height, selectedTool)
//                       // //     : null,
//                       // // onHorizontalDragUpdate: (details) => selectedTool == Tools.pan
//                       // //     ? horizontalDrag(details.delta.dx, size.width, boardSize.width, selectedTool)
//                       // //     : null,
//                       // onPanUpdate: (details) => scroll(context, details.delta, MediaQuery.of(context).size, boardSize, Tools.pan),

//                       Column(children: [
//                     for (int i = 0; i < widget.pixels.length; i++)
//                       Row(children: [
//                         for (int j = 0; j < widget.pixels[0].length; j++)
//                           Pixel(
//                             isVisible: isCellVisible(i, j, viewport),
//                             size: widget.cellSize,
//                             color: Color(colors[widget.pixels[i][j]]),
//                             borderColor: widget.pixels[i][j] == 0 ? Colors.black : Colors.white,
//                             borderWidth: widget.cellSize * 0.035,
//                           )
//                       ])
//                   ]),
//                 )),
//           );
//         });

// LayoutBuilder(
//       builder: (context, constraints) {
//         return GestureDetector(
//           onPanUpdate: (details) => scroll(context, details.delta, constraints.biggest, boardSize, selectedTool),
//           child: Flow(
//               delegate: flowDelegate,
//               children: widget.pixels.asMap().entries.expand(
//                 (rowEntry) {
//                   return rowEntry.value.asMap().entries.map(
//                     (entry) {
//                       final viewPort = constraints.biggest;
//                       final cellSize = widget.cellSize;
//                       final int i = rowEntry.key;
//                       final int j = entry.key;
//                       final int value = entry.value;
//                       final x = (cellSize * i) + (viewPort.width / 2) - (boardSize.width / 2) + scrollOffset.dx;
//                       final y = (cellSize * j) + (viewPort.height / 2) - (boardSize.height / 2) + scrollOffset.dy;
//                       print(x);
//                       print(y);

//                       final isVisible = x + widget.cellSize > 0 &&
//                           y + widget.cellSize > 0 &&
//                           x < viewPort.width &&
//                           y < viewPort.height;

//                       print(isVisible);

//                       return Pixel(
//                         isVisible: isVisible,
//                         size: widget.cellSize,
//                         color: Color(colors[value]),
//                         borderColor: value == 0 ? Colors.black : Colors.white,
//                         borderWidth: widget.cellSize * 0.035,
//                       );
//                     },
//                   );
//                 },
//               ).toList()),
//         );
//       },
//     );
