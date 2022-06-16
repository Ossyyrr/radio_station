import 'package:flutter/material.dart';
import 'package:radio_station/models/station.dart';
import 'package:radio_station/services/station_api_service.dart';

class StationProvider with ChangeNotifier {
  int _currentStationIndex = 0;
  int get currentStationIndex => _currentStationIndex;
  set currentStationIndex(int index) {
    _currentStationIndex = index;
    notifyListeners();
  }

  Station get currentStation => StationApiService().stations[_currentStationIndex];

  Station get nextStation =>
      StationApiService().stations[(_currentStationIndex + 1) % StationApiService().stations.length];
  Station get previousStation =>
      StationApiService().stations[(_currentStationIndex - 1) % StationApiService().stations.length];
}
