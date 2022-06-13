// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(SampleApp());
// }

// class SampleApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         brightness: Brightness.dark,
//       ),
//       title: 'Random Songs Picker',
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Random Songs Picker'),
//         ),
//         body: Container(
//           alignment: Alignment.bottomCenter,
//           child: TextChanger(),
//         ),
//       ),
//     );
//   }
// }

// class TextChanger extends StatefulWidget {
//   @override
//   MainTextChanger createState() => MainTextChanger();
// }

// class MainTextChanger extends State {
//   final List name1 = [
//     'song1',
//     'https://firebasestorage.googleapis.com/v0/b/sample-app-2a74f.appspot.com/o/Cartoon%20-%20On%20_%20On%20(feat.%20Daniel%20Levi)%20_NCS%20Release_.mp3?alt=media&token=58fb526e-8f10-46f2-9679-7c6da839da4f'
//   ];
//   final List name2 = ['song2', 'song2 link'];
//   final List name3 = ['song3', 'song3 link'];
//   final List name4 = ['song4', 'song4 link'];
//   final List name5 = ['song5', 'song5 link'];
//   var mainList = [
//     ['namef', 'link']
//   ];
//   // bool playingTF = false;
//   // IconData playBtn = Icons.play_arrow;

//   AudioPlayer aplayer = AudioPlayer();
//   // url

//   void playAudio(url) async {
//     await aplayer.play(UrlSource('https://ais-nzme.streamguys1.com/nz_002_aac'));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         const SizedBox(
//           height: 100,
//         ),
//         Container(
//           child: ElevatedButton(
//             onPressed: () {
//               var url = name1[1];
//               playAudio(
//                   'https://firebasestorage.googleapis.com/v0/b/sample-app-2a74f.appspot.com/o/Cartoon%20-%20On%20_%20On%20(feat.%20Daniel%20Levi)%20_NCS%20Release_.mp3?alt=media&token=58fb526e-8f10-46f2-9679-7c6da839da4f');
//             },
//             style: ElevatedButton.styleFrom(
//               primary: Colors.black, // Background color
//               onPrimary: Colors.white, // Foreground color
//               padding: const EdgeInsets.all(15.0), // Box padding
//             ),
//             child: Text(
//               //mainList,
//               mainList[0][0],
//               style: const TextStyle(
//                 fontSize: 22,
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(
//           height: 10,
//         ),
//         Container(
//           child: ElevatedButton(
//             onPressed: () {},
//             style: ElevatedButton.styleFrom(
//               primary: Colors.black, // Background color
//               onPrimary: Colors.white, // Foreground color
//               padding: const EdgeInsets.all(15.0), // Box padding
//             ),
//             child: Text(
//               name2[0],
//               style: const TextStyle(
//                 fontSize: 22,
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(
//           height: 10,
//         ),
//         Container(
//           child: ElevatedButton(
//             onPressed: () {},
//             style: ElevatedButton.styleFrom(
//               primary: Colors.black, // Background color
//               onPrimary: Colors.white, // Foreground color
//               padding: const EdgeInsets.all(15.0), // Box padding
//             ),
//             child: Text(
//               name3[0],
//               style: const TextStyle(
//                 fontSize: 22,
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(
//           height: 10,
//         ),
//         Container(
//           child: ElevatedButton(
//             onPressed: () {},
//             style: ElevatedButton.styleFrom(
//               primary: Colors.black, // Background color
//               onPrimary: Colors.white, // Foreground color
//               padding: const EdgeInsets.all(15.0), // Box padding
//             ),
//             child: Text(
//               name4[0],
//               style: const TextStyle(
//                 fontSize: 22,
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(
//           height: 10,
//         ),
//         Container(
//           child: ElevatedButton(
//             onPressed: () {},
//             style: ElevatedButton.styleFrom(
//               primary: Colors.black, // Background color
//               onPrimary: Colors.white, // Foreground color
//               padding: const EdgeInsets.all(15.0), // Box padding
//             ),
//             child: Text(
//               name5[0],
//               style: const TextStyle(
//                 fontSize: 22,
//               ),
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_station/pages/home_page.dart';
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
          // 'init': (_) => const InitPage(),
          // 'login': (_) => const LoginPage(),
          // 'register': (_) => const RegistrerPage(),
          // 'poll': (_) => const PollPage(),
          // 'create-poll': (_) => const CreatePollPage(),
        },
        home: const HomePage(),
      ),
    );
  }
}
