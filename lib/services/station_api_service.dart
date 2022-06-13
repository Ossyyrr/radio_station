import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:radio_station/models/station.dart';

class StationApiService with ChangeNotifier {
  late Client client;
  final List<Station> _stations = [];

  List<Station> get stations => _stations;
  //set stations(String ...) => _stations(...);

  StationApiService() {
    initConfig();
  }

  void initConfig() async {
    client = Client();
    print('Init config');
    getStations();

    //notifyListeners();
  }

  void getStations() async {
    final url = Uri.parse('http://all.api.radio-browser.info/json/stations?limit=10');
    final response = await get(url);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      for (var station in data) {
        _stations.add(Station.fromJson(station));
      }
    } else {
      throw Exception('FetchWeather error');
    }
  }
}
