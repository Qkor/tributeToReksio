import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class Enemy extends StatefulWidget{
  @override
  State<Enemy> createState() => _EnemyState();
}

class _EnemyState extends State<Enemy> {
  final double gooseSize = 200;
  Timer? _timer;
  double _top = 0;
  double _left = 0;
  double screenHeight = 0;
  double screenWidth = 0;

  _move(){
    setState(() {
      _top = Random().nextDouble() * (MediaQuery.of(context).size.height - gooseSize);
      _left = Random().nextDouble() * (MediaQuery.of(context).size.width - gooseSize);
    });
  }

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(milliseconds: 500), (_)=>_move());
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      top: _top,
      left: _left,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      child: GestureDetector(
        onTap: (){
          print('hit');
        },
        child: Image.asset('assets/goose.png', width: gooseSize),
      ),
    );
  }
}