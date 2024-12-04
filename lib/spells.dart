import 'dart:ui';

import 'package:one_dollar_unistroke_recognizer/one_dollar_unistroke_recognizer.dart';

enum Spell {
  budyn
}

List<Unistroke<Spell>> spells = [
  Unistroke(Spell.budyn, [
    Offset(100, 0),
    Offset(0, 0),
    Offset(0, 100),
    Offset(100, 100),
    Offset(100, 200),
    Offset(0, 200),
  ])
];