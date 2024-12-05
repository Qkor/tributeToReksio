import 'package:flutter/material.dart';
import 'package:one_dollar_unistroke_recognizer/one_dollar_unistroke_recognizer.dart' as unistroke;
import 'package:ttr/managers/spells.dart';
import 'package:ttr/widgets/settings_page.dart';

void main() {
  unistroke.referenceUnistrokes = spells;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Tribute to Reksio',
      home: SettingsPage(),
    );
  }
}


