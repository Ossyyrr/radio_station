import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:radio_station/models/station.dart';

class StationService with ChangeNotifier {
  late Client client;
  final List<Station> _stations = [];
  final _numberOfItems = 10;
  int _currentStationIndex = 0;
  int wheelIndex = 4;

// TODO getters setters  -  separar en un part of
  double _currentAngle = 0;
  double dragStartPosition = 0;
  double dragUpdatePosition = 0;
//

  List<Station> get stations => _stations;

  int get currentStationIndex => _currentStationIndex;
  int get numberOfItems => _numberOfItems;
  set currentStationIndex(int index) {
    _currentStationIndex = index;
    notifyListeners();
  }

  Station get currentStation => _stations[_currentStationIndex];
  Station get nextStation => _stations[_currentStationIndex + 1];
  Station get previousStation => _stations[_currentStationIndex - 1];

  StationService() {
    //initConfig();
  }

  Future<void> initConfig() async {
    client = Client();
    print('Init config StationService');
    await getStations();
    notifyListeners();
  }

  Future<void> getStations() async {
    final url = Uri.parse('http://all.api.radio-browser.info/json/stations?limit=$_numberOfItems');
    final response = await get(url);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      _stations.clear();
      final List data = jsonDecode(response.body);
      for (var station in data) {
        _stations.add(Station.fromJson(station));
      }
    } else {
      throw Exception('FetchWeather error');
    }
  }

  void calculatePositionWheel() {
    double angle = dragUpdatePosition - dragStartPosition;
    _currentAngle = (_currentAngle + angle) % 360;
    print('Angle: $_currentAngle');
    wheelIndex = ((4 + (((_currentAngle + 20) % 360) / (360 / _numberOfItems)).floor()) % 10).floor();
    print('CALCULATE wheel index: $wheelIndex');
    notifyListeners();
  }
}
