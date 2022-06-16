import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_station/services/station_service.dart';
import 'package:radio_station/utils/station_utils.dart';
import 'package:radio_station/widgets/station_image.dart';
import 'package:radio_station/widgets/wheel.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stationApiService = Provider.of<StationService>(context, listen: false);

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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //TODO  const Text('Buscador'),

                  Expanded(
                    child: ListView.builder(
                      itemCount: stationApiService.stations.length,
                      itemBuilder: (context, index) {
                        return StationListItem(index: index);
                      },
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(0, MediaQuery.of(context).size.width / 2),
                    child: const Wheel(),
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

class StationListItem extends StatelessWidget {
  const StationListItem({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final stationApiService = Provider.of<StationService>(context);
    final station = stationApiService.stations[index];

    return GestureDetector(
      onTap: () => StationUtils.onTap(context, index),
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
