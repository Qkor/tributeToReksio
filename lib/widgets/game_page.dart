import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:one_dollar_unistroke_recognizer/one_dollar_unistroke_recognizer.dart' as unistroke;
import 'package:ttr/managers/assets_manager.dart';
import 'package:ttr/managers/audio_manager.dart';
import 'package:ttr/widgets/enemy.dart';
import 'package:ttr/managers/spell_manager.dart';
import 'package:ttr/widgets/spell_painter.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});
  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {

  final List<Offset> _points = [];
  bool ready = false;

  _loadAssets() async {
    await AssetsManager.loadAssets();
    setState(() {
      ready = true;
    });
  }

  _setupAudioPlayer() async {
    await AudioManager.setup();
  }

  @override
  void initState() {
    super.initState();
    _loadAssets();
    _setupAudioPlayer();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.bottom
    ]);
  }

  _rebuild(Function? callback){
    setState(() {
      if(callback != null){
        callback();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if(!ready){
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            RenderBox renderBox = context.findRenderObject() as RenderBox;
            Offset localPosition = renderBox.globalToLocal(details.globalPosition);
            _points.add(localPosition);
          });
        },
        onPanStart: (_){
          AudioManager.playSpellCasting();
        },
        onPanEnd: (_) {
          AudioManager.stopSpellCasting();
          final recognized = unistroke.recognizeCustomUnistroke(_points);
          if (recognized != null && recognized.score>0.85) {
            if (kDebugMode) {
              print('Stroke recognized as ${recognized.name} with score ${recognized.score}');
            }
            SpellManager.spell = recognized.name;
            AudioManager.playSpellRecognized();
          } else{
            SpellManager.spell = null;
          }
          setState(() {
            _points.clear();
          });
        },
        onTap: (){
          if(SpellManager.spell != null){
            AudioManager.playSpellCasted();
            SpellManager.spell = null;
          }
        },
        child: Stack(
          children: [
            Image.asset(
              "assets/images/mury.png",
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            Enemy(rebuildParent: _rebuild),
            IgnorePointer(
              child: Center(
                child: Image.asset(
                  "assets/images/darkness.gif",
                  height: MediaQuery.of(context).size.height * SpellManager.playerHit
                      * (MediaQuery.of(context).orientation == Orientation.portrait ? 0.5 : 1),
                  width: MediaQuery.of(context).size.width * SpellManager.playerHit
                      * (MediaQuery.of(context).orientation == Orientation.portrait ? 1 : 0.5),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            IgnorePointer(
              child: CustomPaint(
                size: Size.infinite,
                painter: SpellPainter(_points),
              ),
            ),
          ],
        ),
      ),
    );
  }
}