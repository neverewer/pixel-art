import 'package:flutter/material.dart';
import 'package:pixel_art/src/features/pixel_board/models/cell.dart';

class PixelArtViewModel extends ChangeNotifier {
  Color _painColor = Colors.black;

  Color get painColor => _painColor;

  int _boardWidth = 5;

  int get boardWidth => _boardWidth;

  int _boardHeight = 2;

  int get boardHeight => _boardHeight;

  double _cellSize = 30;

  double get cellSize => _cellSize;

  List<List<Cell>> _board = List.empty();

  List<List<Cell>> get board => _board;

  void changeWidth(int newWidth) {
    if (newWidth == _boardWidth) {
      return;
    }

    if (board.isEmpty) {
      _boardWidth = newWidth;
    } else {
      bool isIncrease = newWidth > _boardWidth;

      if (isIncrease) {
        if (newWidth - _boardWidth == 1) {
          _board.add(List.generate(_boardHeight, (_) => Cell.empty()));
        } else {
          _board.addAll(List.generate(newWidth - _boardWidth, (_) => List.generate(_boardHeight, (_) => Cell.empty())));
        }
      } else {
        if (_boardWidth - newWidth == 1) {
          _board.removeLast();
        } else {
          _board.removeRange(newWidth, _boardWidth);
        }
      }
      _boardWidth = newWidth;
      print('boardWidth:   $_boardWidth');
      print('board.length :  ${_board.length}');
    }
    notifyListeners();
  }

  void changeHeight(int newHeight) {
    if (newHeight == _boardHeight) {
      return;
    }

    if (board.isEmpty) {
      _boardHeight = newHeight;
    } else {
      bool isIncrease = newHeight > _boardHeight;

      for (int i = 0; i < _boardWidth; i++) {
        if (isIncrease) {
          if (newHeight - _boardHeight == 1) {
            _board[i].add(Cell.empty());
          } else {
            _board[i].addAll(List.generate(newHeight - _boardHeight, (_) => Cell.empty()));
          }
        } else {
          if (_boardHeight - newHeight == 1) {
            _board[i].removeLast();
          } else {
            _board[i].removeRange(newHeight, _boardHeight);
          }
        }
      }
      _boardHeight = newHeight;
      print('boardHeight:   $_boardHeight');
      print('board[0].length :  ${_board[0].length}');
    }
    notifyListeners();
  }

  void start() {
    _board = List.generate(_boardWidth, (_) => List<Cell>.generate(_boardHeight, (_) => Cell.empty()), growable: true);
    notifyListeners();
  }

  void selectCell(int i, int j) {
    if (board.isEmpty) {
      return;
    }

    if (i < 0 || j < 0 || j >= _boardHeight || i >= _boardWidth) {
      return;
    }

    if (board[i][j].value == 1) {
      return;
    }

    board[i][j].select(_painColor);
    notifyListeners();
  }

  void increaseCellSize() {
    _cellSize++;
    notifyListeners();
  }

  void decreaseCellSize() {
    _cellSize--;
    notifyListeners();
  }
}
