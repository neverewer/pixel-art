import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pixel_art/src/features/pixel_board/models/tools.dart';

class PixelArtViewModel extends ChangeNotifier {
  int _boardWidth = 5;

  int get boardWidth => _boardWidth;

  int _boardHeight = 5;

  int get boardHeight => _boardHeight;

  double _cellSize = 30;

  double get cellSize => _cellSize;

  List<List<int>> _pixels = List.empty();

  List<List<int>> get pixels => _pixels;

  Tools _selectedTool = Tools.pan;

  Tools get selectedTool => _selectedTool;

  Offset _scrollOffset = Offset.zero;

  Offset get scrollOffset => _scrollOffset;

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

    if (_pixels.isNotEmpty) {
      _pixels = List.generate(newWidth, (index) => List.generate(_boardHeight, (index) => 0))
        ..setRange(0, min(newWidth, _boardWidth), _pixels);
    }

    _boardWidth = newWidth;
    notifyListeners();
  }

  void changeHeight(int newHeight) {
    if (newHeight == _boardHeight) {
      return;
    }

    if (_pixels.isNotEmpty) {
      for (int i = 0; i < _boardWidth; i++) {
        _pixels[i] = List.generate(newHeight, (index) => 0)..setRange(0, min(newHeight, _boardHeight), _pixels[i]);
      }
    }

    _boardHeight = newHeight;
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

    _pixels[i][j] = _selectedColor;
    notifyListeners();
  }

  void fillPixels() {
    if (_pixels.isEmpty) {
      return;
    }

    _pixels = List.generate(_boardWidth, (_) => List.generate(_boardHeight, (_) => _selectedColor), growable: true);
    notifyListeners();
  }

  List<int> getColors() => _colors;

  void increaseCellSize() {
    _cellSize++;
    notifyListeners();
  }

  void decreaseCellSize() {
    _cellSize--;
    notifyListeners();
  }

  int getPixelColor(int colorIndex) => _colors[colorIndex];

  void selectColor(int colorIndex) {
    _selectedColor = colorIndex;
    notifyListeners();
  }

  void addColor(int colorValue) {
    _colors.add(colorValue);
    notifyListeners();
  }

  void deleteColor(int index) {
    _colors.removeAt(index);
    notifyListeners();
  }

  void changeTool(Tools tool) {
    _selectedTool = tool;
    notifyListeners();
  }
}
