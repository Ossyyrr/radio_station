import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:radio_station/models/station.dart';

class StationApiService {
  late final Client client = Client();
  final List<Station> _stations = [];
  final _numberOfItems = 10;

  int get numberOfItems => _numberOfItems;
  List<Station> get stations => _stations;

  // Create singletone
  static final StationApiService _StationApiService = StationApiService._internal();
  factory StationApiService() {
    return _StationApiService;
  }
  //

  StationApiService._internal();

  Future<List<Station>> getStations({String name = ''}) async {
    final url = Uri.parse('http://all.api.radio-browser.info/json/stations/search?name=$name&limit=$_numberOfItems');
    final response = await get(url);

    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');

    if (response.statusCode == 200) {
      _stations.clear();
      final List data = jsonDecode(response.body);
      for (var station in data) {
        _stations.add(Station.fromJson(station));
      }
      return _stations;
    } else {
      throw Exception('FetchWeather error');
    }
  }
}
