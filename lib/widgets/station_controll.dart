import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_station/providers/audioplayer_provider.dart';
import 'package:radio_station/providers/station_provider.dart';
import 'package:radio_station/services/station_api_service.dart';
import 'package:radio_station/widgets/play_button.dart';

class StationControll extends StatelessWidget {
  const StationControll({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    final stationProvider = Provider.of<StationProvider>(context);
    final audioPlayerProvider = Provider.of<AudioPlayerProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          iconSize: 30,
          onPressed: () {
            stationProvider.currentStationIndex =
                (stationProvider.currentStationIndex - 1) % StationApiService().stations.length;
            audioPlayerProvider.play(stationProvider.previousStation.url);
            //  print(stationProvider.currentStationIndex);
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
            stationProvider.currentStationIndex =
                (stationProvider.currentStationIndex + 1) % StationApiService().stations.length;
            audioPlayerProvider.play(stationProvider.nextStation.url);
            //   print(stationProvider.currentStationIndex);
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
