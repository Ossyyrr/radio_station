import 'package:flutter/material.dart';
import 'package:radio_station/models/station.dart';
import 'package:radio_station/services/station_api_service.dart';
import 'package:radio_station/utils/station_utils.dart';
import 'package:radio_station/widgets/search.dart';
import 'package:radio_station/widgets/station_image.dart';
import 'package:radio_station/widgets/wheel.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
        Colors.orange,
        Colors.purple,
      ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder<List<Station>>(
          future: StationApiService().getStations(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final stations = snapshot.data;
              return SafeArea(
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //TODO  const Text('Buscador'),
                    const Search(),
                    Expanded(
                      child: ListView.builder(
                        itemCount: stations!.length,
                        itemBuilder: (context, index) {
                          return _StationListItem(index: index);
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
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

class _StationListItem extends StatelessWidget {
  const _StationListItem({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final station = StationApiService().stations[index];

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
