import 'package:ttr/managers/spells.dart';

class SpellManager {
  static Spell? spell;
  static int playerHit=0;

  static getHit(){
    playerHit++;
  }
  static reset(){
    spell = null;
    playerHit = 0;
  }
}