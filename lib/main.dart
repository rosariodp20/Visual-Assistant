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
  runApp(MyApp());
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: Colors.grey,
                    border: Border(
                        top: BorderSide(color: Colors.teal, width: 5),
                        bottom: BorderSide(color: Colors.teal, width: 2.5),
                        left: BorderSide(color: Colors.teal, width: 5),
                        right: BorderSide(color: Colors.teal, width: 2.5))),
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.5,
                width: MediaQuery.of(context).size.width * 0.5,
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
                        style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                    color: Colors.grey,
                    border: Border(
                        top: BorderSide(color: Colors.teal, width: 5),
                        bottom: BorderSide(color: Colors.teal, width: 2.5),
                        left: BorderSide(color: Colors.teal, width: 2.5),
                        right: BorderSide(color: Colors.teal, width: 5))),
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.5,
                width: MediaQuery.of(context).size.width * 0.5,
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
                        style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
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
                decoration: const BoxDecoration(
                    color: Colors.grey,
                    border: Border(
                        top: BorderSide(color: Colors.teal, width: 2.5),
                        bottom: BorderSide(color: Colors.teal, width: 5),
                        left: BorderSide(color: Colors.teal, width: 5),
                        right: BorderSide(color: Colors.teal, width: 2.5))),
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.5,
                width: MediaQuery.of(context).size.width * 0.5,
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
                        style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                    color: Colors.grey,
                    border: Border(
                        top: BorderSide(color: Colors.teal, width: 2.5),
                        bottom: BorderSide(color: Colors.teal, width: 5),
                        left: BorderSide(color: Colors.teal, width: 2.5),
                        right: BorderSide(color: Colors.teal, width: 5))),
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.5,
                width: MediaQuery.of(context).size.width * 0.5,
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
                        style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
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
