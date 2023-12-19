import 'package:flutter/material.dart';

class Board extends ChangeNotifier {
  List<List<int>> _value;

  List<List<int>> get value => _value;

  Board(this._value);

  void changeWidth(int newWidth) {
    final int listWidth = value[0].length;

    if (newWidth == listWidth) {
      return;
    }

    bool isIncrease = newWidth > listWidth;

    for (int i = 0; i < value.length; i++) {
      if (isIncrease) {
        value[i].addAll(List.filled(newWidth - listWidth, 0));
      } else {
        value[i].removeRange(value.length - newWidth, listWidth);
      }
    }
    notifyListeners();
  }

  void changeHeight(int newHeight) {
    final int listHeight = value.length;

    if (newHeight == listHeight) {
      return;
    }

    final bool isIncrease = newHeight > listHeight;

    if (isIncrease) {
      int increaseListLength = value[0].length;

      value.addAll(List.filled(newHeight - listHeight, List.filled(increaseListLength, 0)));
    } else {
      value.removeRange(listHeight - newHeight, listHeight);
    }

    notifyListeners();
  }

  void updateBoard(int i, int j) {
    if (i > value.length - 1 || j > value[0].length - 1) {
      return;
    }

    List<List<int>> newValue = List.from(_value);
    newValue[i][j] = 1;
    _value = newValue;
    notifyListeners();
  }
}
