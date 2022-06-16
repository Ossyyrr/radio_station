import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_station/services/audioplayer_service.dart';
import 'package:radio_station/services/station_service.dart';
import 'package:radio_station/widgets/play_button.dart';

class StationControll extends StatelessWidget {
  const StationControll({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stationApiService = Provider.of<StationService>(context);
    final audioPlayerService = Provider.of<AudioPlayerService>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          iconSize: 30,
          onPressed: () {
            audioPlayerService.play(stationApiService.previousStation.url);
            stationApiService.currentStationIndex =
                (stationApiService.currentStationIndex - 1) % stationApiService.stations.length;
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white.withOpacity(0.9),
          ),
        ),
        const PlayButton(),
        IconButton(
          iconSize: 30,
          onPressed: () {
            audioPlayerService.play(stationApiService.nextStation.url);
            stationApiService.currentStationIndex =
                (stationApiService.currentStationIndex + 1) % stationApiService.stations.length;
          },
          icon: Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.white.withOpacity(0.9),
          ),
        ),
      ],
    );
  }
}
