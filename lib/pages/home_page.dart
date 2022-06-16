import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_station/models/station.dart';
import 'package:radio_station/providers/home_provider.dart';
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
                    const Spacer(),
                    const Search(),

                    // Expanded(
                    //   child: ListView.builder(
                    //     itemCount: stations!.length,
                    //     itemBuilder: (context, index) {
                    //       return _StationListItem(index: index);
                    //     },
                    //   ),
                    // ),
                    const Spacer(),

                    const Text(
                      'Radio Station',
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                    const Spacer(),
                    const _nextButton(),
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

class _nextButton extends StatelessWidget {
  const _nextButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final homeProvider = Provider.of<HomeProvider>(context, listen: false);

        StationUtils.onTap(context, homeProvider.wheelIndex);
      },
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
            Colors.purple,
            Colors.orange,
          ]),
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: const Icon(
          Icons.arrow_forward_ios_rounded,
          color: Colors.white,
          size: 35,
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
