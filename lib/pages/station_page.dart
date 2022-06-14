import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_station/services/station_api_service.dart';
import 'package:radio_station/widgets/sound_animation.dart';
import 'package:radio_station/widgets/station_controll.dart';
import 'package:radio_station/widgets/station_image.dart';

class StationPage extends StatelessWidget {
  const StationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stationApiService = Provider.of<StationApiService>(context);

    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Colors.purple, Colors.orange])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        // ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  const SoundAnimation(),
                  StationImage(image: stationApiService.currentStation.favicon),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  stationApiService.currentStation.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  stationApiService.currentStation.country,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
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
                    children: const [
                      StationControll(),
                      SizedBox(height: 18),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      topLeft: Radius.circular(40),
                    ),
                    color: Color(0xfffafafa),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
