import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_station/providers/station_provider.dart';
import 'package:radio_station/services/station_api_service.dart';
import 'package:radio_station/widgets/sound_animation.dart';
import 'package:radio_station/widgets/station_controll.dart';
import 'package:radio_station/widgets/station_image.dart';

class StationPage extends StatefulWidget {
  const StationPage({Key? key}) : super(key: key);

  @override
  State<StationPage> createState() => _StationPageState();
}

class _StationPageState extends State<StationPage> {
  @override
  Widget build(BuildContext context) {
    final stationProvider = Provider.of<StationProvider>(context);

    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Colors.purple, Colors.orange])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  const SoundAnimation(),
                  StationImage(image: StationApiService().stations[stationProvider.currentStationIndex].favicon),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        StationApiService().stations[stationProvider.currentStationIndex].name.trim(),
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        StationApiService().stations[stationProvider.currentStationIndex].country.trim(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
              Transform.translate(
                offset: const Offset(0, 35),
                child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      topLeft: Radius.circular(40),
                    ),
                    color: Colors.black38,
                  ),
                  child: Column(
                    children: [
                      StationControll(index: stationProvider.currentStationIndex),
                      const SizedBox(height: 18),
                    ],
                  ),
                ),
              ),
              const Expanded(
                child: _createdBy(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _createdBy extends StatelessWidget {
  const _createdBy({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(40),
          topLeft: Radius.circular(40),
        ),
        color: Color(0xfffafafa),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Center(
              child: Text(
            'Created by',
            style: TextStyle(color: Colors.black87, fontSize: 16),
          )),
          Center(
              child: Text(
            'Patricia Manzanero',
            style: TextStyle(color: Colors.black87, fontSize: 20),
          )),
        ],
      ),
    );
  }
}
