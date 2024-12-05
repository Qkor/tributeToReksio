import 'package:ttr/managers/spells.dart';

class SpellManager {
  static Spell? spell;
  static int playerHit=0;
  // game settings
  static double spellSensitivity = 0.8;
  static double enemySize = 200;
  static double enemySpeed = 5;
  static double enemySpellCastingSpeed = 5;

  static getHit(){
    playerHit++;
  }
  static reset(){
    spell = null;
    playerHit = 0;
  }
}