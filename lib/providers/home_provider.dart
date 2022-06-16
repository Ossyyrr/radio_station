import 'package:flutter/material.dart';
import 'package:radio_station/services/station_api_service.dart';

class HomeProvider with ChangeNotifier {
  // angles for the wheel
  double _currentAngle = 0;
  double dragStartPosition = 0;
  double dragUpdatePosition = 0;
//

  int wheelIndex = 4;

  void calculatePositionWheel() {
    double angle = dragUpdatePosition - dragStartPosition;
    _currentAngle = (_currentAngle + angle) % 360;
    //print('Angle: $_currentAngle');
    wheelIndex =
        ((4 + (((-_currentAngle + 20) % 360) / (360 / StationApiService().numberOfItems)).floor()) % 10).floor();
    debugPrint('CALCULATE wheel index: $wheelIndex - ${StationApiService().stations[wheelIndex].name}');
    notifyListeners();
  }
}
