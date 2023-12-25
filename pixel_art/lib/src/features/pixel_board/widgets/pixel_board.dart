import 'package:flutter/material.dart';
import 'package:pixel_art/src/features/pixel_board/models/tools.dart';
import 'package:pixel_art/src/features/pixel_board/pixel_art_view_model.dart';
import 'package:pixel_art/src/features/pixel_board/widgets/pixel.dart';
import 'package:provider/provider.dart';

class PixelBoard extends StatefulWidget {
  final int width;
  final int height;
  final List<List<int>> pixels;
  final double cellSize;

  const PixelBoard({
    super.key,
    required this.width,
    required this.height,
    required this.cellSize,
    required this.pixels,
  });

  @override
  State<PixelBoard> createState() => _PixelBoardState();
}

class _PixelBoardState extends State<PixelBoard> {
  late Size boardSize;
  double translateX = 0;
  double translateY = 0;
  late final PixelArtViewModel viewModel;
  late final ArrayFlowDelegate flowDelegate;

  @override
  void initState() {
    super.initState();
    viewModel = context.read<PixelArtViewModel>();
    flowDelegate = ArrayFlowDelegate(viewModel: viewModel);
  }

  // @override
  // void didUpdateWidget(covariant PixelBoard oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   // boardSize = Size(widget.width * widget.cellSize, widget.height * widget.cellSize);
  //   // WidgetsBinding.instance.addPostFrameCallback((_) {
  //   //   _centerContent();
  //   // });
  // }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  // void _centerContent() {
  //   final size = context.size!;

  //   final double translateX = size.width / 2 - boardSize.width / 2;
  //   final double translateY = size.height / 2 - boardSize.height / 2;

  //   _controller.value = Matrix4.translationValues(translateX, translateY, 0.0);
  // }

  void selectCell(BuildContext context, Offset position, Tools tool) {
    if (tool != Tools.pen) {
      return;
    }
    final i = (position.dx / widget.cellSize).floor();
    final j = (position.dy / widget.cellSize).floor();
    context.read<PixelArtViewModel>().selectCell(i, j);
  }

  void verticalDrag(double y, double viewPortHeight, double boardHeight, Tools tool) {
    if (tool != Tools.pan) {
      return;
    }

    if (viewPortHeight > boardHeight) {
      return;
    }

    setState(() {
      translateY += y;
    });
  }

  void horizontalDrag(double x, double viewPortWidth, double boardWidth, Tools tool) {
    if (tool != Tools.pan) {
      return;
    }

    if (viewPortWidth > boardWidth) {
      return;
    }

    setState(() {
      translateX += x;
    });
  }

  void fillCells(BuildContext context, Tools tool) {
    if (tool != Tools.fill) {
      return;
    }
    context.read<PixelArtViewModel>().fillPixels();
  }

  void scroll(BuildContext context, Offset delta, Size viewPortSize, Size boardSize, Tools tool) {
    if (tool != Tools.pan) {
      return;
    }
    context.read<PixelArtViewModel>().changeScrollOffset(delta);
  }

  @override
  Widget build(BuildContext context) {
    boardSize = Size(widget.width * widget.cellSize, widget.height * widget.cellSize);
    // final selectedTool = context.watch<PixelArtViewModel>().selectedTool;
    final colors = context.read<PixelArtViewModel>().getColors();

    return GestureDetector(
      // onTap: () => fillCells(context, selectedTool),
      // // onPanStart: (details) =>
      // //     selectedTool == Tools.pen ? selectCell(context, details.localPosition, selectedTool) : null,
      // onPanUpdate: (details) =>
      //     // selectedTool == Tools.pen ? selectCell(context, details.localPosition, selectedTool) : null,
      //     scroll(details.delta.dx, details.delta.dy, size, boardSize, selectedTool),
      // onTapDown: (details) => selectCell(context, details.localPosition, selectedTool),
      // // onVerticalDragUpdate: (details) => selectedTool == Tools.pan
      // //     ? verticalDrag(details.delta.dy, size.height, boardSize.height, selectedTool)
      // //     : null,
      // // onHorizontalDragUpdate: (details) => selectedTool == Tools.pan
      // //     ? horizontalDrag(details.delta.dx, size.width, boardSize.width, selectedTool)
      // //     : null,
      onPanUpdate: (details) => scroll(context, details.delta, MediaQuery.of(context).size, boardSize, Tools.pan),
      child: Flow(
          delegate: flowDelegate,
          children: widget.pixels.expand((row) {
            return row.map((value) {
              return Pixel(
                size: widget.cellSize,
                color: Color(colors[value]),
                borderColor: value == 0 ? Colors.black : Colors.white,
                borderWidth: widget.cellSize * 0.035,
              );
            });
          }).toList()),
    );
  }
}

class ArrayFlowDelegate extends FlowDelegate {
  final PixelArtViewModel viewModel;

  ArrayFlowDelegate({required this.viewModel}) : super(repaint: viewModel);

  @override
  void paintChildren(FlowPaintingContext context) {
    int childIndex = 0;
    double x;
    double y;
    final cellSize = viewModel.cellSize;
    final scrollOffset = viewModel.scrollOffset;
    final pixels = viewModel.pixels;
    final width = pixels.length;
    final height = pixels[0].length;
    final scrollX = scrollOffset.dx;
    final scrollY = scrollOffset.dy;

    for (int i = 0; i < width; i++) {
      for (int j = 0; j < height; j++) {
        x = cellSize * i + 300 + scrollX;
        y = cellSize * j + 150 + scrollY;
        context.paintChild(childIndex, transform: Matrix4.translationValues(x, y, 0.0));
        childIndex++;
      }
    }
  }

  @override
  bool shouldRepaint(ArrayFlowDelegate oldDelegate) =>
      !identical(oldDelegate.viewModel.pixels, viewModel.pixels) &&
      !identical(oldDelegate.viewModel.scrollOffset, viewModel.scrollOffset);
}
