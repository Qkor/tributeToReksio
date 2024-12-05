import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ttr/managers/spell_manager.dart';
import 'package:ttr/managers/audio_manager.dart';

class Enemy extends StatefulWidget{
  final Function rebuildParent;
  const Enemy({super.key, required this.rebuildParent});
  @override
  State<Enemy> createState() => _EnemyState();
}

class _EnemyState extends State<Enemy> {
  Timer? _timer;
  Timer? _spellTimer;
  double size = 200;
  int moveFrequency = 400;
  int spellFrequency = 10;
  double _top = 200;
  double _left = 100;
  double screenHeight = 0;
  double screenWidth = 0;
  Image? _image;
  int hitCount = 0;

  _move(){
    if(hitCount<3){
      setState(() {
        _top = Random().nextDouble() * (MediaQuery.of(context).size.height - size);
        _left = Random().nextDouble() * (MediaQuery.of(context).size.width - size);
      });
    }
  }

  _die(){
    _timer?.cancel();
    _spellTimer?.cancel();
    AudioManager.playHenDefeated();
    setState(() {
      _top = MediaQuery.of(context).size.height + size * 4;
    });
    widget.rebuildParent(()=>SpellManager.reset());
    _timer = Timer(const Duration(seconds: 2), (){
      AudioManager.playVictory();
      if(context.mounted){
        Navigator.of(context).pop();
      }
    });
  }

  @override
  void initState() {
    moveFrequency = 2000 ~/ SpellManager.enemySpeed;
    spellFrequency = 50000 ~/ SpellManager.enemySpellCastingSpeed;
    size = SpellManager.enemySize;
    _image = Image.asset('assets/images/hen.png', width: size);
    _timer = Timer.periodic(Duration(milliseconds: moveFrequency), (_)=>_move());
    _spellTimer = Timer.periodic(Duration(milliseconds: spellFrequency), (_)=>_castSpell());
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _spellTimer?.cancel();
    super.dispose();
  }

  _hit(){
    AudioManager.playHenSound();
    setState(() {
      if(hitCount<3 && SpellManager.spell != null){
        AudioManager.playSpellCasted();
        SpellManager.spell = null;
        hitCount++;
        _image = Image.asset('assets/images/hen$hitCount.png', width: size);
        if(hitCount==3){
          _die();
        }
      }
    });
  }

  _castSpell(){
    AudioManager.playEnemySpellCasted();
    widget.rebuildParent(()=>SpellManager.getHit());
    if(SpellManager.playerHit>=3){
      _timer?.cancel();
      _spellTimer?.cancel();
      _timer = Timer(const Duration(seconds: 1), (){
        AudioManager.playDefeat();
        if(context.mounted){
          Navigator.of(context).pop();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      top: _top,
      left: _left,
      duration: Duration(milliseconds: moveFrequency),
      curve: Curves.easeInOut,
      child: GestureDetector(
        onTap: _hit,
        child: _image,
      ),
    );
  }
}