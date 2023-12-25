import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pixel_art/src/features/app/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(const App());
}
