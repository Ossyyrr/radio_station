import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:radio_station/providers/audioplayer_provider.dart';

class SoundAnimation extends StatefulWidget {
  const SoundAnimation({Key? key}) : super(key: key);

  @override
  State<SoundAnimation> createState() => _SoundAnimationState();
}

class _SoundAnimationState extends State<SoundAnimation> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final audioPlayerProvider = Provider.of<AudioPlayerProvider>(context);
    print('audioPlayerProvider.isPlaying: ${audioPlayerProvider.isPlaying}');
    audioPlayerProvider.isPlaying ? _controller.repeat() : _controller.stop();
    return Lottie.asset(
      'assets/sound.json',
      controller: _controller,
      onLoaded: (composition) => _controller.duration = composition.duration,
    );
  }
}
