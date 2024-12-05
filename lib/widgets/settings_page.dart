import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ttr/widgets/game_page.dart';

import '../managers/assets_manager.dart';
import '../managers/audio_manager.dart';

class SettingsPage extends StatefulWidget{
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  bool ready = false;

  _loadAssets() async {
    await AssetsManager.loadAssets();
    setState(() {
      ready = true;
    });
  }

  _setupAudioPlayer() async {
    await AudioManager.setup();
    AudioManager.playIdleMusic();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text('Polecam grać z włączonym dźwiękiem.'),
              const SizedBox(height: 20),
              const Text('Na razie jedynym zaimplementowanym czarem jest kula budyniu. Dla przypomnienia:'),
              const SizedBox(height: 20),
              Image.asset(
                "assets/images/sciaga.png",
                width: 100,
                height: 100,
              ),
              const SizedBox(height: 20),
              const Text('Chyba wiesz co robić. Powodzenia!'),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        onPressed: () {
          if(ready){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const GamePage()));
          }
        },
        child: Image.asset(
          "assets/images/continue.png",
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}