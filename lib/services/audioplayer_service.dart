import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioPlayerService with ChangeNotifier {
  late final AudioPlayer player;

  AudioPlayerService() {
    initConfig();
  }

  void initConfig() async {
    print('Init config AudioPlayer');

    player = AudioPlayer();
    await player.play(UrlSource('https://ais-nzme.streamguys1.com/nz_002_aac'));
  }
}
