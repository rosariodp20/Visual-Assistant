import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:visual_assistant/cronologia_destinazioni.dart';
import 'package:visual_assistant/gestione_preferiti.dart';
import 'package:visual_assistant/ricerca_percorso.dart';
import 'package:camera/camera.dart';
import 'detection.dart';

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
        theme: ThemeData(primarySwatch: Colors.teal),
        home: MyHomePage());
  }
}

class MyHomePage extends StatelessWidget {
  final appBar = AppBar(title: const Text('Visual Assistant'));

  MyHomePage({Key? key}) : super(key: key);

  Border _createBorder(double top, double bottom, double left, double right) {
    return Border(
        top: BorderSide(color: Colors.teal, width: top),
        bottom: BorderSide(color: Colors.teal, width: bottom),
        left: BorderSide(color: Colors.teal, width: left),
        right: BorderSide(color: Colors.teal, width: right));
  }

  @override
  Widget build(BuildContext context) {
    final _buttonHeight = (MediaQuery.of(context).size.height -
            appBar.preferredSize.height -
            MediaQuery.of(context).padding.top) *
        0.5;

    final _buttonWidth = MediaQuery.of(context).size.width * 0.5;

    const _textStyle = TextStyle(
        fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white);

    return Scaffold(
      appBar: appBar,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey, border: _createBorder(5, 2.5, 5, 2.5)),
                height: _buttonHeight,
                width: _buttonWidth,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const GestionePreferiti()));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Icon(Icons.star, color: Colors.white, size: 130),
                      Text(
                        'Destinazioni preferite',
                        style: _textStyle,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey, border: _createBorder(5, 2.5, 2.5, 5)),
                height: _buttonHeight,
                width: _buttonWidth,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Detection(cameras)));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Icon(Icons.camera_alt, color: Colors.white, size: 130),
                      Text(
                        'Riconoscimento',
                        style: _textStyle,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey, border: _createBorder(2.5, 5, 5, 2.5)),
                height: _buttonHeight,
                width: _buttonWidth,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const CronologiaDestinazioni()));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Icon(Icons.history, color: Colors.white, size: 130),
                      Text(
                        'Cronologia destinazioni',
                        style: _textStyle,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey, border: _createBorder(2.5, 5, 2.5, 5)),
                height: _buttonHeight,
                width: _buttonWidth,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => RicercaPercorso(cameras)));
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Icon(Icons.search, color: Colors.white, size: 130),
                      Text(
                        'Ricerca percorso',
                        style: _textStyle,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
