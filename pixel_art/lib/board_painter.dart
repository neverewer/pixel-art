// import 'package:flutter/material.dart';

// class BoardPainter extends CustomPainter {
//   final List<List<int>> board;
//   final double cellSize;
//   final Paint fillPaint = Paint()..color = Colors.black..str

//   final Paint defaultPaint = Paint()
//     ..color = Colors.black
//     ..style = PaintingStyle.stroke;

//   BoardPainter(this.board, this.cellSize);

//   @override
//   void paint(Canvas canvas, Size size) {
//     for (int i = 0; i < board.length; i++) {
//       for (int j = 0; j < board[i].length; j++) {
//         final rect = Rect.fromLTWH(j * cellSize, i * cellSize, cellSize, cellSize);
//         if (board[i][j] == 1) {
//           canvas.drawRect(rect, fillPaint);
//         }
//         canvas.drawRect(rect, defaultPaint);
//       }
//     }
//   }

//   @override
//   bool shouldRepaint(BoardPainter oldDelegate) {
//     bool shoudRepaint = oldDelegate.board != board;
//     return shoudRepaint;
//   }
// }
