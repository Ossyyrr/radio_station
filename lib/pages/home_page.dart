import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_station/services/audioplayer_service.dart';
import 'package:radio_station/services/station_api_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stationApiService = Provider.of<StationApiService>(context);
    final audioPlayerService = Provider.of<AudioPlayerService>(context);

    return Scaffold(
      body: Center(
          child: ListView.builder(
        itemCount: stationApiService.stations.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(stationApiService.stations[index].name),
          );
        },
      )),
    );
  }
}