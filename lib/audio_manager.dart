import 'dart:math';

import 'package:audioplayers/audioplayers.dart';

class AudioManager{
  static AudioPlayer audioPlayer = AudioPlayer();
  static AudioPlayer sfxPlayer = AudioPlayer();
  static AudioPlayer magicPlayer = AudioPlayer();

  static setup() async{
    audioPlayer.setReleaseMode(ReleaseMode.loop);
    magicPlayer.setReleaseMode(ReleaseMode.loop);
    audioPlayer.play(AssetSource('pojedynek.wav'));

    sfxPlayer.setPlayerMode(PlayerMode.lowLatency);
  }

  static playSpellRecognized(){
    AudioManager.sfxPlayer.play(AssetSource('CzarRR.wav'));
  }

  static playSpellCasting(){
    AudioManager.magicPlayer.play(AssetSource('czar.wav'));
  }

  static stopSpellCasting(){
    AudioManager.magicPlayer.stop();
  }

  static playSpellCasted(){
    AudioManager.sfxPlayer.play(AssetSource('czarStrzR.wav'));
  }

  static playHenDefeated(){
    AudioManager.sfxPlayer.play(AssetSource('henDefeat.wav'));
  }

  static playHenSound(){
    var rand = Random().nextInt(3)+1;
    AudioManager.sfxPlayer.play(AssetSource('hen$rand.wav'));
  }
}