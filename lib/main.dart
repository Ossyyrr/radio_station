import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_station/pages/home_page.dart';
import 'package:radio_station/pages/station_page.dart';
import 'package:radio_station/providers/audioplayer_provider.dart';
import 'package:radio_station/providers/home_provider.dart';
import 'package:radio_station/providers/station_provider.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AudioPlayerProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => StationProvider()),
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
