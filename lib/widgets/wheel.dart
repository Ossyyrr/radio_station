import 'package:circle_list/circle_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_station/services/station_api_service.dart';
import 'package:radio_station/widgets/station_image.dart';

class Wheel extends StatefulWidget {
  const Wheel({
    Key? key,
  }) : super(key: key);

  @override
  State<Wheel> createState() => _WheelState();
}

class _WheelState extends State<Wheel> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleList(
          origin: const Offset(0, 0),
          children: List.generate(10, (index) {
            return _WheelStation(index: index);
          }),
        ),
        // Text(
        //   _movement > 0 ? 'Reloj' : 'contrareloj',
        //   style: Theme.of(context).textTheme.headline4,
        // ),
        // Text('$_movement'),
        // GestureDetector(
        //   onPanUpdate: _panHandler,
        //   child: Container(
        //     width: 300,
        //     height: 300,
        //     decoration: BoxDecoration(
        //       color: Colors.red.withOpacity(0.5),
        //       borderRadius: BorderRadius.circular(1000),
        //     ),
        //     child: Stack(
        //       children: [
        //         const _WheelStation(index: 0),
        //         Transform.rotate(angle: 0.75, child: const _WheelStation(index: 1)),
        //         Transform.rotate(angle: 1.5, child: const _WheelStation(index: 2)),
        //         // Transform.rotate(angle: 2.25, child: const _WheelStation()),
        //         // Transform.rotate(angle: 3, child: const _WheelStation()),
        //         // Transform.rotate(angle: 3.75, child: const _WheelStation()),
        //         // Transform.rotate(angle: 4.5, child: const _WheelStation()),
        //         // Transform.rotate(angle: 5.25, child: const _WheelStation()),
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );
  }

  // void _panHandler(DragUpdateDetails d) {
  //   /// Pan location on the wheel
  //   bool onTop = d.localPosition.dy <= radius;
  //   bool onLeftSide = d.localPosition.dx <= radius;
  //   bool onRightSide = !onLeftSide;
  //   bool onBottom = !onTop;

  //   /// Pan movements
  //   bool panUp = d.delta.dy <= 0.0;
  //   bool panLeft = d.delta.dx <= 0.0;
  //   bool panRight = !panLeft;
  //   bool panDown = !panUp;

  //   /// Absoulte change on axis
  //   double yChange = d.delta.dy.abs();
  //   double xChange = d.delta.dx.abs();

  //   /// Directional change on wheel
  //   double vert = (onRightSide && panUp) || (onLeftSide && panDown) ? yChange * -1 : yChange;
  //   double horz = (onTop && panLeft) || (onBottom && panRight) ? xChange * -1 : xChange;
  //   // Total computed change
  //   double rotationalChange = vert + horz;
  //   bool movingClockwise = rotationalChange > 0;
  //   bool movingCounterClockwise = rotationalChange < 0;
  //   setState(() {
  //     _movement = rotationalChange;
  //   });
  // }
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
              print(index);
            },
            // onPanStart: (DragStartDetails detailsStart) {
            //   print('detailsStart - $detailsStart');
            // },
            // onPanUpdate: (DragUpdateDetails detailsUpdate) {
            //   print('detailsUpdate - $detailsUpdate');
            // },
            // onPanEnd: (DragEndDetails detailsEnd) {
            //   print('detailsEnd - $detailsEnd');
            // },
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
