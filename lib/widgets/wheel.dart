import 'dart:math' as math;

import 'package:circle_list/circle_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_station/providers/home_provider.dart';
import 'package:radio_station/services/station_api_service.dart';
import 'package:radio_station/utils/station_utils.dart';
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
    final homeProvider = Provider.of<HomeProvider>(context);

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Transform.rotate(
          angle: 45 * math.pi / 180,
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1000),
                gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
                  Colors.orange,
                  Colors.purple,
                ])),
          ),
        ),
        CircleList(
          initialAngle: (3 * 180 / math.pi),
          showInitialAnimation: true,
          animationSetting: AnimationSetting(curve: Curves.easeOutBack),
          outerRadius: MediaQuery.of(context).size.width / 2,
          rotateMode: RotateMode.onlyChildrenRotate,
          centerWidget: Transform.translate(
            offset: const Offset(0, -40),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: StationApiService().stations.isEmpty
                  ? const SizedBox()
                  : Text(
                      StationApiService().stations[homeProvider.wheelIndex].name,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
            ),
          ),
          onDragStart: (PolarCoord polarCoord) {
            homeProvider.dragStartPosition = (polarCoord.angle * 180 / math.pi) + 180;
          },
          onDragUpdate: (PolarCoord polarCoord) {
            homeProvider.dragUpdatePosition = (polarCoord.angle * 180 / math.pi) + 180;
          },
          onDragEnd: () {
            homeProvider.calculatePositionWheel();
          },
          origin: const Offset(0, 0),
          children: List.generate(StationApiService().numberOfItems, (index) {
            return _WheelStation(index: index);
          }),
        ),
      ],
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
    return GestureDetector(
      onTap: () => StationUtils.onTap(context, index),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1000),
              border: Border.all(color: Colors.orange, width: 3),
            ),
            child: StationApiService().stations.isEmpty
                ? const SizedBox()
                : StationImage(image: StationApiService().stations[index].favicon),
          ),
        ],
      ),
    );
  }
}
