import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:radio_station/models/station.dart';

class StationApiService with ChangeNotifier {
  late Client client;
  final List<Station> _stations = [];
  int _currentStationIndex = 0;

  List<Station> get stations => _stations;

  int get currentStationIndex => _currentStationIndex;
  set currentStationIndex(int index) {
    _currentStationIndex = index;
    notifyListeners();
  }

  Station get currentStation => _stations[_currentStationIndex];
  Station get nextStation => _stations[_currentStationIndex + 1];
  Station get previousStation => _stations[_currentStationIndex - 1];

  StationApiService() {
    //initConfig();
  }

  Future<void> initConfig() async {
    client = Client();
    print('Init config StationApiService');
    await getStations();
  }

  Future<void> getStations() async {
    final url = Uri.parse('http://all.api.radio-browser.info/json/stations?limit=10');
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
}
