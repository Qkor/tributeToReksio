import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ttr/spell_manager.dart';
import 'audio_manager.dart';

class Enemy extends StatefulWidget{
  final Function rebuildParent;
  const Enemy({super.key, required this.rebuildParent});
  @override
  State<Enemy> createState() => _EnemyState();
}

class _EnemyState extends State<Enemy> {
  final double enemySize = 200;
  Timer? _timer;
  Timer? _spellTimer;
  double _top = 200;
  double _left = 100;
  double screenHeight = 0;
  double screenWidth = 0;
  Image? _image;
  int hitCount = 0;

  _move(){
    if(hitCount<3){
      setState(() {
        _top = Random().nextDouble() * (MediaQuery.of(context).size.height - enemySize);
        _left = Random().nextDouble() * (MediaQuery.of(context).size.width - enemySize);
      });
    }
  }

  _die(){
    _timer?.cancel();
    _spellTimer?.cancel();
    AudioManager.playHenDefeated();
    setState(() {
      _top = MediaQuery.of(context).size.height + enemySize * 4;
    });
    widget.rebuildParent(()=>SpellManager.reset());
  }

  @override
  void initState() {
    _image = Image.asset('assets/hen.png', width: enemySize);
    _timer = Timer.periodic(const Duration(milliseconds: 400), (_)=>_move());
    _spellTimer = Timer.periodic(const Duration(seconds: 10), (_)=>_castSpell());
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
        _image = Image.asset('assets/hen$hitCount.png', width: enemySize);
        if(hitCount==3){
          _die();
        }
      }
    });
  }

  _castSpell(){
    AudioManager.playEnemySpellCasted();
    widget.rebuildParent(()=>SpellManager.getHit());
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      top: _top,
      left: _left,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      child: GestureDetector(
        onTap: _hit,
        child: _image,
      ),
    );
  }
}