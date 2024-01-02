import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pixel_art/src/features/pixel_board/models/pixel_data.dart';
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

  List<int> _colors = [
    const Color.fromARGB(255, 0, 0, 0).value,
    const Color.fromARGB(255, 255, 255, 255).value,
  ];

  List<int> get colors => _colors;

  int _selectedColor = 0;

  int get selectedColor => _selectedColor;

  void changeWidth(int newWidth) {
    if (newWidth == _boardWidth) {
      return;
    }

    if (_pixels.isNotEmpty) {
      _pixels = List.generate(newWidth, (index) => List.generate(_boardHeight, (index) => 1))
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
        _pixels[i] = List.generate(newHeight, (index) => 1)..setRange(0, min(newHeight, _boardHeight), _pixels[i]);
      }
    }

    _boardHeight = newHeight;
    notifyListeners();
  }

  void start() {
    _pixels = List.generate(_boardWidth, (_) => List.generate(_boardHeight, (_) => 1), growable: true);
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

  void increaseCellSize() {
    _cellSize++;
    notifyListeners();
  }

  void decreaseCellSize() {
    _cellSize--;
    notifyListeners();
  }

  void selectColor(int colorIndex) {
    _selectedColor = colorIndex;
    notifyListeners();
  }

  void addColor(int colorValue) {
    _colors.add(colorValue);
    _selectedColor = _colors.length - 1;
    notifyListeners();
  }

  void deleteColor(int index) {
    _pixels = _pixels.map((row) {
      return row.map((element) => element == index ? 1 : element).toList();
    }).toList();
    _colors.removeAt(index);
    _selectedColor = 0;
    notifyListeners();
  }

  void changeTool(Tools tool) {
    _selectedTool = tool;
    notifyListeners();
  }

  String export() {
    final PixelData data = PixelData(pixels: _pixels, colors: _colors);
    return data.toRawJson();
  }

  void import(String json) {
    if (json.isEmpty) {
      return;
    }
    final PixelData data = PixelData.fromRawJson(json);
    _pixels = data.pixels;
    if (data.colors != null) {
      _colors = data.colors!;
    }
    notifyListeners();
  }

  void newBoard() {
    _pixels = List.empty();
    _boardHeight = 5;
    _boardWidth = 5;
    notifyListeners();
  }
}
