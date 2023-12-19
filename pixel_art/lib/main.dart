import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pixel_art/src/features/app/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const App());
}
