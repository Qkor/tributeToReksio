import 'package:flutter/material.dart';
import 'package:ttr/assets_manager.dart';

class SpellPainter extends CustomPainter {
  final List<Offset> points;
  static const double starSize = 150;
  SpellPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint();
    Rect srcRect = Rect.fromLTWH(0, 0,AssetsManager.star!.width.toDouble(),AssetsManager.star!.height.toDouble());
    for(int i=0;i<points.length;i++){
      if(i%2==0){
        Rect destRect = Rect.fromLTWH(points[i].dx,points[i].dy,starSize,starSize);
        canvas.drawImageRect(AssetsManager.star!, srcRect, destRect, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}