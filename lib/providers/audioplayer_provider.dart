import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioPlayerProvider with ChangeNotifier {
  late final AudioPlayer _player;
  bool _isPlaying = false;
  bool _isLoading = false;

  bool get isPlaying => _isPlaying;
  set isPlaying(bool value) {
    _isPlaying = value;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  AudioPlayerProvider() {
    initConfig();
  }

  void initConfig() async {
    print('Init config AudioPlayer');
    _player = AudioPlayer();
  }

  void play(String url) async {
    _isLoading = true;
    notifyListeners();
    await _player.play(UrlSource(url));
    _isLoading = false;
    _isPlaying = true;
    notifyListeners();
  }

  void stop() async {
    await _player.stop();
    _isPlaying = false;
    notifyListeners();
  }
}
