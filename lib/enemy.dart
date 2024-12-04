import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class Enemy extends StatefulWidget{
  @override
  State<Enemy> createState() => _EnemyState();
}

class _EnemyState extends State<Enemy> {
  final double enemySize = 200;
  Timer? _timer;
  double _top = 0;
  double _left = 0;
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

  @override
  void initState() {
    _image = Image.asset('assets/hen.png', width: enemySize);
    _timer = Timer.periodic(const Duration(milliseconds: 500), (_)=>_move());
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  _hit(){
    setState(() {
      if(hitCount<3){
        hitCount++;
        _image = Image.asset('assets/hen$hitCount.png', width: enemySize);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      top: _top,
      left: _left,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      child: GestureDetector(
        onTap: _hit,
        child: _image,
      ),
    );
  }
}