import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:radio_station/services/audioplayer_service.dart';
import 'package:radio_station/services/station_service.dart';

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
    final stationApiService = Provider.of<StationService>(context);
    final audioPlayerService = Provider.of<AudioPlayerService>(context);
    audioPlayerService.isPlaying ? playAnimation.forward() : playAnimation.reverse();
    return Stack(
      alignment: Alignment.center,
      children: [
        Lottie.asset('assets/click.json', height: 120, width: 120, controller: musicalNotesAnimation),
        IconButton(
          iconSize: 40,
          onPressed: () {
            if (audioPlayerService.isPlaying) {
              audioPlayerService.stop();
              audioPlayerService.isPlaying = false;
            } else {
              audioPlayerService.play(stationApiService.currentStation.url);
              audioPlayerService.isPlaying = true;
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
        audioPlayerService.isLoading
            ? const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              )
            : const SizedBox(),
      ],
    );
  }
}
