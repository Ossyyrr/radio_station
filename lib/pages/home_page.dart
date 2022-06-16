import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_station/services/audioplayer_service.dart';
import 'package:radio_station/services/station_api_service.dart';
import 'package:radio_station/widgets/station_image.dart';
import 'package:radio_station/widgets/wheel.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stationApiService = Provider.of<StationApiService>(context);

    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
        Colors.orange,
        Colors.purple,
      ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder(
          future: stationApiService.initConfig(),
          builder: (context, snapshot) {
            return SafeArea(
              child: Center(
                  child: Column(
                children: [
                  const Text('Buscador'),
                  const Wheel(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: stationApiService.stations.length,
                      itemBuilder: (context, index) {
                        return StationItem(index: index);
                      },
                    ),
                  ),
                ],
              )),
            );
          },
        ),
      ),
    );
  }
}

class StationItem extends StatelessWidget {
  const StationItem({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final stationApiService = Provider.of<StationApiService>(context);
    final audioPlayerService = Provider.of<AudioPlayerService>(context);
    final station = stationApiService.stations[index];
    final isPair = index % 2 == 0;

    return GestureDetector(
      onTap: () async {
        stationApiService.currentStationIndex = index;
        audioPlayerService.play(station.url);
        await Navigator.pushNamed(context, 'station');
        audioPlayerService.stop();
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  StationImage(image: station.favicon),
                  const SizedBox(width: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Text(
                      station.name.trim(),
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 4,
                    child: Text(
                      station.country.trim(),
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
