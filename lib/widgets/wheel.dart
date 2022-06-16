import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_station/services/station_api_service.dart';
import 'package:radio_station/widgets/station_image.dart';

class Wheel extends StatelessWidget {
  const Wheel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.5),
        borderRadius: BorderRadius.circular(1000),
      ),
      child: Stack(
        children: [
          const _WheelStation(index: 0),
          Transform.rotate(angle: 0.75, child: const _WheelStation(index: 1)),
          Transform.rotate(angle: 1.5, child: const _WheelStation(index: 2)),
          // Transform.rotate(angle: 2.25, child: const _WheelStation()),
          // Transform.rotate(angle: 3, child: const _WheelStation()),
          // Transform.rotate(angle: 3.75, child: const _WheelStation()),
          // Transform.rotate(angle: 4.5, child: const _WheelStation()),
          // Transform.rotate(angle: 5.25, child: const _WheelStation()),
        ],
      ),
    );
  }
}

class _WheelStation extends StatelessWidget {
  const _WheelStation({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    final stationApiService = Provider.of<StationApiService>(context);

    return SizedBox(
      width: 300,
      height: 300,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              print('**********');
            },
            onPanStart: (DragStartDetails detailsStart) {
              print('detailsStart - $detailsStart');
            },
            onPanUpdate: (DragUpdateDetails detailsUpdate) {
              print('detailsUpdate - $detailsUpdate');
            },
            onPanEnd: (DragEndDetails detailsEnd) {
              print('detailsEnd - $detailsEnd');
            },
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1000),
                color: Colors.blue,
              ),
              child: stationApiService.stations.isEmpty
                  ? const SizedBox()
                  : StationImage(image: stationApiService.stations[index].favicon),
            ),
          ),
        ],
      ),
    );
  }
}
