import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import './screens/history.dart';
import './screens/favourites.dart';
import './screens/path_search.dart';
import 'package:camera/camera.dart';
import 'screens/detection.dart';
import 'widgets/homepage_button.dart';
import './widgets/appbar.dart';

late List<CameraDescription> cameras;
FlutterTts flutterTts = FlutterTts();

//Bisogna runnare con: flutter run --no-sound-null-safety
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error: $e.code\nError Message: $e.message');
  }

  flutterTts.setLanguage("it-IT");
  flutterTts.setVoice({"name": "it-it-x-itd-local", "locale": "it-IT"});
  flutterTts.setQueueMode(1);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Visual Assistant',
        theme: ThemeData(primaryColor: const Color(0xff0d7a9a)),
        home: const MyHomePage());
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  Border _createBorder(
      Color color, double top, double bottom, double left, double right) {
    return Border(
        top: BorderSide(color: color, width: top),
        bottom: BorderSide(color: color, width: bottom),
        left: BorderSide(color: color, width: left),
        right: BorderSide(color: color, width: right));
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;

    final _buttonHeight = (MediaQuery.of(context).size.height -
            homeAppBar.preferredSize.height -
            MediaQuery.of(context).padding.top) *
        0.5;

    final _buttonWidth = MediaQuery.of(context).size.width * 0.5;

    return Scaffold(
      appBar: homeAppBar,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HomePageButton(
                  _createBorder(primaryColor, 5, 2, 5, 2.5),
                  _buttonHeight,
                  _buttonWidth,
                  'Gestione preferiti',
                  Icons.star,
                  Favourites(cameras)),
              HomePageButton(
                  _createBorder(primaryColor, 5, 2.5, 2.5, 5),
                  _buttonHeight,
                  _buttonWidth,
                  'Riconoscimento',
                  Icons.camera_alt,
                  Detection(cameras)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HomePageButton(
                  _createBorder(primaryColor, 2.5, 5, 5, 2.5),
                  _buttonHeight,
                  _buttonWidth,
                  'Cronologia destinazioni',
                  Icons.history,
                  History(cameras)),
              HomePageButton(
                  _createBorder(primaryColor, 2.5, 5, 2.5, 5),
                  _buttonHeight,
                  _buttonWidth,
                  'Ricerca percorso',
                  Icons.search,
                  PathSearch(cameras, flutterTts))
            ],
          ),
        ],
      ),
    );
  }
}
