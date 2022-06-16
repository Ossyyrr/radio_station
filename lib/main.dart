import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_station/pages/home_page.dart';
import 'package:radio_station/pages/station_page.dart';
import 'package:radio_station/services/audioplayer_service.dart';
import 'package:radio_station/services/station_service.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StationService()),
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

 // ! EXAMPLE SCUARE DRAGABLE
// import 'package:flutter/material.dart';

// void main() => runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: Scaffold(
//         body: Padding(
// //       padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
//             padding: const EdgeInsets.all(0),
//             child: Page()))));

// class Page extends StatefulWidget {
//   @override
//   PageState createState() => PageState();
// }

// class PageState extends State<Page> {
//   double left = 0;
//   double top = 0;
//   late double startHori;
//   late double startVert;
//   double containerWidth = 100;
//   double containerHeight = 100;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(children: <Widget>[
//       Positioned(
//           left: left,
//           top: top,
//           child: GestureDetector(
//               onPanStart: (details) {
//                 setState(() {
//                   startHori = details.localPosition.dx;
//                   startVert = details.localPosition.dy;
//                 });
//               },
//               onPanUpdate: (details) {
//                 var screenWidth = MediaQuery.of(context).size.width;
//                 var screenHeight = MediaQuery.of(context).size.height;

//                 var topVal = details.globalPosition.dy - startVert;
//                 var leftVal = details.globalPosition.dx - startHori;

//                 var leftBounds = screenWidth - containerWidth;
//                 var topBounds = screenHeight - containerHeight;

//                 setState(() {
//                   if (leftVal.floor() >= 0 && leftVal <= leftBounds) {
//                     left = leftVal.floorToDouble();
//                   }

//                   if (leftVal < 0) {
//                     left = 0;
//                   }

//                   if (leftVal > leftBounds) {
//                     left = leftBounds.floorToDouble();
//                   }

//                   if (topVal.floor() >= 0 && topVal <= topBounds) {
//                     top = topVal.floorToDouble();
//                   }

//                   if (topVal < 0) {
//                     top = 0;
//                   }

//                   if (topVal > topBounds) {
//                     top = topBounds;
//                   }
//                 });
//               },
//               child: Container(
//                   width: containerWidth,
//                   height: containerHeight,
//                   color: Colors.green,
//                   child: const Text('Click and drag the square around the screen'))))
//     ]);
//   }
// }
