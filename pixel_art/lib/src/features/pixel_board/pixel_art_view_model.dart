import 'package:flutter/material.dart';

class PixelArtViewModel extends ChangeNotifier {
  int _boardWidth = 5;

  int get boardWidth => _boardWidth;

  int _boardHeight = 5;

  int get boardHeight => _boardHeight;

  double _cellSize = 30;

  double get cellSize => _cellSize;

  List<List<int>> _pixels = List.empty();

  List<List<int>> get pixels => _pixels;

  final List<int> _colors = [
    const Color.fromARGB(255, 255, 255, 255).value,
    const Color.fromARGB(255, 0, 0, 0).value,
  ];

  List<int> get colors => _colors;

  int _selectedColor = 1;

  int get selectedColor => _selectedColor;

  void changeWidth(int newWidth) {
    if (newWidth == _boardWidth) {
      return;
    }

    if (_pixels.isEmpty) {
      _boardWidth = newWidth;
    } else {
      bool isIncrease = newWidth > _boardWidth;

      if (isIncrease) {
        if (newWidth - _boardWidth == 1) {
          _pixels.add(List.generate(_boardHeight, (_) => 0));
        } else {
          _pixels.addAll(List.generate(newWidth - _boardWidth, (_) => List.generate(_boardHeight, (_) => 0)));
        }
      } else {
        if (_boardWidth - newWidth == 1) {
          _pixels.removeLast();
        } else {
          _pixels.removeRange(newWidth, _boardWidth);
        }
      }
      _boardWidth = newWidth;
      print('boardWidth:   $_boardWidth');
      print('board.length :  ${_pixels.length}');
    }
    notifyListeners();
  }

  void changeHeight(int newHeight) {
    if (newHeight == _boardHeight) {
      return;
    }

    if (_pixels.isEmpty) {
      _boardHeight = newHeight;
    } else {
      bool isIncrease = newHeight > _boardHeight;

      for (int i = 0; i < _boardWidth; i++) {
        if (isIncrease) {
          if (newHeight - _boardHeight == 1) {
            _pixels[i].add(0);
          } else {
            _pixels[i].addAll(List.generate(newHeight - _boardHeight, (_) => 0));
          }
        } else {
          if (_boardHeight - newHeight == 1) {
            _pixels[i].removeLast();
          } else {
            _pixels[i].removeRange(newHeight, _boardHeight);
          }
        }
      }
      _boardHeight = newHeight;
      print('boardHeight:   $_boardHeight');
      print('board[0].length :  ${_pixels[0].length}');
    }
    notifyListeners();
  }

  void start() {
    _pixels = List.generate(_boardWidth, (_) => List.generate(_boardHeight, (_) => 0), growable: true);
    notifyListeners();
  }

  void selectCell(int i, int j) {
    if (_pixels.isEmpty) {
      return;
    }

    if (i < 0 || j < 0 || j >= _boardHeight || i >= _boardWidth) {
      return;
    }

    if (_pixels[i][j] != 0) {
      return;
    }

    _pixels[i][j] = _selectedColor;
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

  int getPixelColor(int colorIndex) => _colors[colorIndex];

  void addColor(int colorValue) => _colors.add(colorValue);
}
