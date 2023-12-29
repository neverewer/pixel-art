import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PixelRenderObject extends SingleChildRenderObjectWidget {
  final int xIndex;
  final int yIndex;

  const PixelRenderObject({required this.xIndex, required this.yIndex, Key? key, required Widget child})
      : super(child: child, key: key);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return PixelProxyBox(xIndex: xIndex, yIndex: yIndex);
  }

  @override
  void updateRenderObject(BuildContext context, PixelProxyBox renderObject) {
    renderObject
      ..xIndex = xIndex
      ..yIndex = yIndex;
  }
}

class PixelProxyBox extends RenderProxyBox {
  int xIndex;
  int yIndex;

  PixelProxyBox({required this.xIndex, required this.yIndex});
}
