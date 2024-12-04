import 'dart:ui' as ui;

import 'package:flutter/services.dart';

class AssetsManager{
  static loadAssets() async {
    star = await _loadImageFromAssets('assets/star.png');
  }

  static Future<ui.Image> _loadImageFromAssets(String path) async {
    final ByteData data = await rootBundle.load(path);
    final ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
    );
    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    return frameInfo.image;
  }

  static ui.Image? star;
}