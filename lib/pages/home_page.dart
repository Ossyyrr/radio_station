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
      appBar: AppBar(
        title: const Text('as'),
      ),
      body: FutureBuilder(
        future: stationApiService.initConfig(),
        builder: (context, snapshot) {
          return Center(
              child: ListView.builder(
            itemCount: stationApiService.stations.length,
            itemBuilder: (context, index) {
              final station = stationApiService.stations[index];
              return ListTile(
                title: Text(station.name),
                onTap: () async {
                  // audioPlayerService.play(station.url);
                  stationApiService.currentStationIndex = index;
                  await Navigator.pushNamed(context, 'station');
                  audioPlayerService.stop();
                },
                trailing: IconButton(
                  icon: const Icon(Icons.stop),
                  onPressed: () {
                    audioPlayerService.stop();
                  },
                ),
              );
            },
          ));
        },
      ),
    );
  }
}
