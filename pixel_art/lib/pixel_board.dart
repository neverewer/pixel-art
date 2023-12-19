import 'package:flutter/material.dart';
import 'package:pixel_art/board.dart';

class PixelBoard extends StatefulWidget {
  const PixelBoard({super.key});

  @override
  State<PixelBoard> createState() => _PixelBoardState();
}

class _PixelBoardState extends State<PixelBoard> {
  final double cellSize = 40;
  final int boardWidht = 5;
  final int boardHeight = 5;
  late Board board;
  late Size boardSize;
  late ArrayFlowDelegate arrayFlowDelegate;

  @override
  void initState() {
    super.initState();
    board = Board(List.generate(boardWidht, (_) => List.filled(boardHeight, 0)));
    boardSize = Size(board.value.length * cellSize, board.value[0].length * cellSize);
    arrayFlowDelegate = ArrayFlowDelegate(board: board, cellSize: cellSize);
  }

  void paintCell(Offset position) {
    final i = (position.dy / cellSize).floor();
    final j = (position.dx / cellSize).floor();

    board.updateBoard(i, j);
  }

  @override
  void dispose() {
    board.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) {
        paintCell(details.localPosition);
      },
      onPanUpdate: (details) {
        paintCell(details.localPosition);
      },
      child: SizedBox(
        width: boardSize.width,
        height: boardSize.height,
        child: Flow(
          delegate: arrayFlowDelegate,
          children: [
            for (int i = 0; i < board.value.length; i++)
              for (int j = 0; j < board.value[i].length; j++)
                SizedBox(
                  width: cellSize,
                  height: cellSize,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: board.value[i][j] == 1 ? Colors.black : Colors.white,
                      border: Border.all(
                          color: board.value[i][j] == 1 ? Colors.white : Colors.black,
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
  final Board board;
  final double cellSize;

  ArrayFlowDelegate({
    required this.board,
    required this.cellSize,
  }) : super(repaint: board);

  @override
  void paintChildren(FlowPaintingContext context) {
    int childIndex = 0;
    double x;
    double y;

    for (int i = 0; i < board.value.length; i++) {
      for (int j = 0; j < board.value[i].length; j++) {
        y = cellSize * i;
        x = cellSize * j;
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
