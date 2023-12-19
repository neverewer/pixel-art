import 'package:flutter/material.dart';
import 'package:pixel_art/src/features/pixel_board/models/cell.dart';
import 'package:pixel_art/src/features/pixel_board/pixel_art_view_model.dart';
import 'package:provider/provider.dart';

class PixelBoard extends StatelessWidget {
  final int width;
  final int height;
  final List<List<Cell>> board;
  final double cellSize;

  const PixelBoard({
    super.key,
    required this.width,
    required this.height,
    required this.cellSize,
    required this.board,
  });

// class _PixelBoardState extends State<PixelBoard> {
//   late double cellSize;
//   late Size boardSize;
//   late ArrayFlowDelegate arrayFlowDelegate;

//   @override
//   void initState() {
//     super.initState();
//     cellSize = widget.cellSize;
//     board = Board(List.generate(widget.width, (_) => List.filled(widget.height, 0)));
//     boardSize = Size(board.value.length * cellSize, board.value[0].length * cellSize);
//     arrayFlowDelegate = ArrayFlowDelegate(board: board, cellSize: cellSize);
//   }

  void selectCell(BuildContext context, Offset position) {
    final i = (position.dx / cellSize).floor();
    final j = (position.dy / cellSize).floor();

    print('i: $i, j: $j');
    context.read<PixelArtViewModel>().selectCell(i, j);
  }

  @override
  Widget build(BuildContext context) {
    final boardSize = Size(width * cellSize, height * cellSize);

    return GestureDetector(
      onPanStart: (details) {
        selectCell(context, details.localPosition);
      },
      onPanUpdate: (details) {
        selectCell(context, details.localPosition);
      },
      child: SizedBox(
        width: boardSize.width,
        height: boardSize.height,
        child: Flow(
          delegate: ArrayFlowDelegate(width: width, height: height, cellSize: cellSize),
          children: [
            for (int i = 0; i < width; i++)
              for (int j = 0; j < height; j++)
                SizedBox(
                  width: cellSize,
                  height: cellSize,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: board[i][j].color,
                      border: Border.all(
                          color: board[i][j].value == 1 ? Colors.white : Colors.black,
                          width: 1,
                          strokeAlign: BorderSide.strokeAlignInside),
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}

class ArrayFlowDelegate extends FlowDelegate {
  final int width;
  final int height;
  final double cellSize;

  ArrayFlowDelegate({
    required this.width,
    required this.height,
    required this.cellSize,
  });

  @override
  void paintChildren(FlowPaintingContext context) {
    int childIndex = 0;
    double x;
    double y;

    for (int i = 0; i < width; i++) {
      for (int j = 0; j < height; j++) {
        x = cellSize * i;
        y = cellSize * j;
        context.paintChild(childIndex, transform: Matrix4.translationValues(x, y, 0.0));
        childIndex++;
      }
    }
  }

  @override
  bool shouldRepaint(ArrayFlowDelegate oldDelegate) {
    return true;
  }
}
