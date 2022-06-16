import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:radio_station/providers/audioplayer_provider.dart';
import 'package:radio_station/providers/station_provider.dart';

class PlayButton extends StatefulWidget {
  const PlayButton({Key? key}) : super(key: key);

  @override
  State<PlayButton> createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> with TickerProviderStateMixin {
  late AnimationController playAnimation;
  late AnimationController musicalNotesAnimation;

  @override
  void initState() {
    playAnimation = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    musicalNotesAnimation = AnimationController(vsync: this, duration: const Duration(milliseconds: 3000));
    musicalNotesAnimation.value = 0.1;
  }

  @override
  void dispose() {
    playAnimation.dispose();
    musicalNotesAnimation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stationProvider = Provider.of<StationProvider>(context);

    final audioPlayerProvider = Provider.of<AudioPlayerProvider>(context);
    audioPlayerProvider.isPlaying ? playAnimation.forward() : playAnimation.reverse();
    return Stack(
      alignment: Alignment.center,
      children: [
        Lottie.asset('assets/click.json', height: 120, width: 120, controller: musicalNotesAnimation),
        IconButton(
          iconSize: 40,
          onPressed: () {
            if (audioPlayerProvider.isPlaying) {
              audioPlayerProvider.stop();
              audioPlayerProvider.isPlaying = false;
            } else {
              audioPlayerProvider.play(stationProvider.currentStation.url);
              audioPlayerProvider.isPlaying = true;
              musicalNotesAnimation.forward().then((value) => musicalNotesAnimation.value = 0.1);
            }
            setState(() {});
          },
          icon: AnimatedIcon(
            icon: AnimatedIcons.play_pause,
            color: Colors.white.withOpacity(0.9),
            progress: playAnimation,
          ),
        ),
        audioPlayerProvider.isLoading
            ? const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              )
            : const SizedBox(),
      ],
    );
  }
}
