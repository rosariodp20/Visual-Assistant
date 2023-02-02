import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:geolocator/geolocator.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:geocoder/geocoder.dart';
import 'package:visual_assistant/main.dart';
import '../widgets/appbar.dart';
import './path.dart';
import 'package:camera/camera.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PathSearch extends StatefulWidget {
  final List<CameraDescription> cameras;
  final FlutterTts flutterTts;

  const PathSearch(this.cameras, this.flutterTts, {Key? key}) : super(key: key);

  @override
  State<PathSearch> createState() => _PathSearchState();
}

class _PathSearchState extends State<PathSearch> {
  List<String> cronologiaPercorsi = [];
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _textSpeech = "In attesa dell'indirizzo.";
  var locationMessage = "";
  double? latitudineOri, longitudineOri; //coordinate origine
  double? latitudineDest, longitudineDest; //coordinate destinazione

  void getCurrentLocation() async {
    var lastPosition = await Geolocator().getLastKnownPosition();
    latitudineOri = lastPosition.latitude;
    longitudineOri = lastPosition.longitude;
  }

  void convertiDestinazioneinCoordinate() async {
    final query = _textSpeech;
    var addresses = await Geocoder.local.findAddressesFromQuery(query);
    var first = addresses.first;
    latitudineDest = first.coordinates.latitude;
    longitudineDest = first.coordinates.longitude;
  }

  void onListen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() {
          _isListening = true;
        });
        _speech.listen(
            onResult: (val) => setState(() {
                  _textSpeech = val.recognizedWords;
                }));
      }
    } else {
      setState(() {
        _isListening = false;
        _speech.stop();
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) => _buildPopupDialog(context),
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    recuperaDati();
  }

  void recuperaDati() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList('listaCronologiaPercorsi') != null) {
      cronologiaPercorsi = prefs.getStringList('listaCronologiaPercorsi')!;
    }
  }

  void salvaDati() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList("listaCronologiaPercorsi", cronologiaPercorsi);
  }

  Widget _buildPopupDialog(BuildContext context) {
    /*FlutterTts flutterTts = FlutterTts();
    flutterTts.setLanguage("it-IT");
    flutterTts.setVoice({"name": "it-it-x-itd-local", "locale": "it-IT"});*/
    flutterTts.speak("Indica se l'indirizzo " + _textSpeech + " è corretto?");

    getCurrentLocation(); //trova la posizione dell'utente
    convertiDestinazioneinCoordinate(); //converte la posizione (Stringa) in coordinate geografiche

    return AlertDialog(
      title: const Text(''),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Indica se l'indirizzo " + _textSpeech + " è corretto"),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            print("Latitudine origine: $latitudineOri" +
                " | Longitudine origine: $longitudineOri");
            print("Latitudine destinazione: $latitudineDest" +
                " | Longitudine destinazione: $longitudineDest");

            //print("aspe' destinazione");

            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => Path(
                  cameras,
                  flutterTts,
                  latitudineOri: latitudineOri,
                  longitudineOri: longitudineOri,
                  latitudineDest: latitudineDest,
                  longitudineDest: longitudineDest,
                ),
              ),
            );
            if (cronologiaPercorsi.length == 3) {
              cronologiaPercorsi.removeAt(0);
              cronologiaPercorsi.add(_textSpeech);
            } else {
              cronologiaPercorsi.add(_textSpeech);
            }
            salvaDati();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff0d7a9a),
            minimumSize: const Size(100, 100),
          ),
          child: const Text('Si'),
        ),
        const SizedBox(
          width: 40,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff0d7a9a),
            minimumSize: const Size(100, 100),
          ),
          child: const Text('No'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(30),
          child: Column(children: [
            const Text(
              "RICERCA PERCORSO",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 60),
            Text(
              _textSpeech,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0),
                ),
                backgroundColor: Theme.of(context).primaryColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                minimumSize: const Size(300, 400),
              ),
              onPressed: () => onListen(),
              child: const Text(
                'IMPOSTA DESTINAZIONE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
