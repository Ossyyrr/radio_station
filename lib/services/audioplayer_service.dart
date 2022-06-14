import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioPlayerService with ChangeNotifier {
  late final AudioPlayer _player;
  bool _isPlaying = false;
  bool _isLoading = false;

  bool get isPlaying => _isPlaying;
  set isPlaying(bool value) {
    _isPlaying = value;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  AudioPlayerService() {
    initConfig();
  }

  void initConfig() async {
    print('Init config AudioPlayer');
    _player = AudioPlayer();
  }

  void play(String url) async {
    _isLoading = true;
    await _player.play(UrlSource(url));
    _isLoading = false;
    _isPlaying = true;
    notifyListeners();
  }

  // void pause() async {
  //   await _player.pause();
  // }

  // void resume() async {
  //   await _player.resume();
  // }

  void stop() async {
    await _player.stop();
    _isPlaying = false;
    notifyListeners();
  }
}
