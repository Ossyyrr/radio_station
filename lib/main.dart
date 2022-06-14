import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_station/pages/home_page.dart';
import 'package:radio_station/pages/station_page.dart';
import 'package:radio_station/services/audioplayer_service.dart';
import 'package:radio_station/services/station_api_service.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StationApiService()),
        ChangeNotifierProvider(create: (_) => AudioPlayerService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: 'home',
        routes: {
          'home': (_) => const HomePage(),
          'station': (_) => const StationPage(),
        },
        home: const HomePage(),
      ),
    );
  }
}
