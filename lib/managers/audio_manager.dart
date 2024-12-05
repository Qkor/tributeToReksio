import 'dart:math';

import 'package:audioplayers/audioplayers.dart';

class AudioManager{
  static AudioPlayer audioPlayer = AudioPlayer();
  static AudioPlayer sfxPlayer = AudioPlayer();
  static AudioPlayer henPlayer = AudioPlayer();
  static AudioPlayer magicPlayer = AudioPlayer();

  static setup() async{
    audioPlayer.setReleaseMode(ReleaseMode.loop);
    magicPlayer.setReleaseMode(ReleaseMode.loop);
    sfxPlayer.setPlayerMode(PlayerMode.lowLatency);
  }

  static playDuelMusic(){
    audioPlayer.play(AssetSource('wavs/pojedynek.wav'));
  }

  static playIdleMusic(){
    audioPlayer.play(AssetSource('wavs/intro.wav'));
  }

  static playSpellRecognized(){
    AudioManager.sfxPlayer.play(AssetSource('wavs/CzarRR.wav'));
  }

  static playSpellCasting(){
    AudioManager.magicPlayer.play(AssetSource('wavs/czar.wav'));
  }

  static stopSpellCasting(){
    AudioManager.magicPlayer.stop();
  }

  static playSpellCasted(){
    AudioManager.sfxPlayer.play(AssetSource('wavs/czarStrzR.wav'));
  }

  static playEnemySpellCasted(){
    AudioManager.henPlayer.play(AssetSource('wavs/czarStrzW.wav'));
  }

  static playHenDefeated(){
    AudioManager.henPlayer.play(AssetSource('wavs/henDefeat.wav'));
  }

  static playHenSound(){
    var rand = Random().nextInt(3)+1;
    AudioManager.henPlayer.play(AssetSource('wavs/hen$rand.wav'));
  }
}