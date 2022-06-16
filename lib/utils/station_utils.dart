import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_station/providers/audioplayer_provider.dart';
import 'package:radio_station/providers/station_provider.dart';
import 'package:radio_station/services/station_api_service.dart';

class StationUtils {
  static void onTap(BuildContext context, int index) async {
    final stationProvider = Provider.of<StationProvider>(context, listen: false);
    final audioPlayerProvider = Provider.of<AudioPlayerProvider>(context, listen: false);
    print('on TAP - $index');
    stationProvider.currentStationIndex = index;
    audioPlayerProvider.play(StationApiService().stations[index].url);
    await Navigator.pushNamed(context, 'station');
    audioPlayerProvider.stop();
  }
}
