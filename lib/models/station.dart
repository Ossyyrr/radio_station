import 'dart:convert';

Station stationFromJson(String str) => Station.fromJson(json.decode(str));

String stationToJson(Station data) => json.encode(data.toJson());

class Station {
  Station({
    required this.name,
    required this.url,
    required this.favicon,
    required this.country,
    required this.countrycode,
  });

  String name;
  String url;
  String favicon;
  String country;
  String countrycode;

  factory Station.fromJson(Map<String, dynamic> json) => Station(
        name: json["name"],
        url: json["url"],
        favicon: json["favicon"],
        country: json["country"],
        countrycode: json["countrycode"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
        "favicon": favicon,
        "country": country,
        "countrycode": countrycode,
      };
}
