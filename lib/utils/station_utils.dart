import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_station/services/audioplayer_service.dart';
import 'package:radio_station/services/station_service.dart';

class StationUtils {
  static void onTap(BuildContext context, int index) async {
    final stationApiService = Provider.of<StationService>(context, listen: false);
    final audioPlayerService = Provider.of<AudioPlayerService>(context, listen: false);

    stationApiService.currentStationIndex = index;
    audioPlayerService.play(stationApiService.stations[index].url);
    await Navigator.pushNamed(context, 'station');
    audioPlayerService.stop();
  }
}
