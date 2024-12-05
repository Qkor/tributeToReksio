import 'dart:math';

import 'package:audioplayers/audioplayers.dart';

class AudioManager{
  static AudioPlayer audioPlayer = AudioPlayer();
  static AudioPlayer magicPlayer = AudioPlayer();

  static setup() async{
    audioPlayer.setReleaseMode(ReleaseMode.loop);
    magicPlayer.setReleaseMode(ReleaseMode.loop);
  }

  static playDuelMusic(){
    audioPlayer.play(AssetSource('wavs/pojedynek.wav'));
  }

  static playIdleMusic(){
    audioPlayer.play(AssetSource('wavs/intro.wav'));
  }

  static playSpellRecognized(){
    AudioPlayer().play(AssetSource('wavs/CzarRR.wav'));
  }

  static playSpellCasting(){
    AudioManager.magicPlayer.play(AssetSource('wavs/czar.wav'));
  }

  static stopSpellCasting(){
    AudioManager.magicPlayer.stop();
  }

  static playSpellCasted(){
    AudioPlayer().play(AssetSource('wavs/czarStrzR.wav'));
  }

  static playEnemySpellCasted(){
    AudioPlayer().play(AssetSource('wavs/czarStrzW.wav'));
  }

  static playHenDefeated(){
    AudioPlayer().play(AssetSource('wavs/henDefeat.wav'));
  }

  static playHenSound(){
    var rand = Random().nextInt(3)+1;
    AudioPlayer().play(AssetSource('wavs/hen$rand.wav'));
  }

  static playDefeat(){
    AudioPlayer().play(AssetSource('wavs/defeat.wav'));
  }

  static playVictory(){
    AudioPlayer().play(AssetSource('wavs/victory.wav'));
  }
}