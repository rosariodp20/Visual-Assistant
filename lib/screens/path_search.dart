import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:visual_assistant/controller/path_search_controller.dart';
import 'package:visual_assistant/controller/text_to_speech_controller.dart';
import 'package:camera/camera.dart';
import '../controller/history_controller.dart';
import './realtime_update.dart';
import '../widgets/appbar.dart';
import '../utils/available_cameras.dart';

class PathSearch extends StatefulWidget {
  final List<CameraDescription> cameras;
  final TextToSpeechController textToSpeechController =
      TextToSpeechController.instance;
  final HistoryController historyController = HistoryController.instance;

  PathSearch(this.cameras, {Key? key}) : super(key: key);

  @override
  State<PathSearch> createState() => _PathSearchState();
}

class _PathSearchState extends State<PathSearch> {
  final PathSearchController pathSearchController =
      PathSearchController.instance;
  List<String> cronologiaPercorsi = [];
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _textSpeech = "";
  var locationMessage = "";
  double? latitudineOri, longitudineOri; //coordinate origine
  double? latitudineDest, longitudineDest; //coordinate destinazione

  void getCurrentLocation() async {
    final currentLocation = pathSearchController.getCurrentLocation();
    latitudineOri =
        currentLocation.then((value) => value['latitude']) as double?;
    longitudineOri =
        currentLocation.then((value) => value['longitude']) as double?;
  }

  void convertiDestinazioneInCoordinate() async {
    final addresses = pathSearchController.getDestinationCoordinates(_textSpeech);

    addresses.then((value){
      value.first;
      latitudineDest = value.first.coordinates.latitude;
      longitudineDest = value.first.coordinates.longitude;
    });
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
  }

  Widget _buildPopupDialog(BuildContext context) {
    if (_textSpeech != "") {
      widget.textToSpeechController.speak(
          'Indica se l\'indirizzo $_textSpeech è corretto (Si a sinistra,No a destra).');
    } else {
      widget.textToSpeechController
          .speak('Non è stato inserito nessun indirizzo');
    }
    getCurrentLocation(); //trova la posizione dell'utente
    convertiDestinazioneInCoordinate(); //converte la posizione (Stringa) in coordinate geografiche

    return AlertDialog(
      title: const Text(''),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _textSpeech == ''
              ? const Text('Non è stato inserito nessun indirizzo')
              : Text("Indica se l'indirizzo " +
                  _textSpeech +
                  " è corretto (Sì a sinistra, No a destra)."),
        ],
      ),
      actions: _textSpeech != ''
          ? <Widget>[
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
                        latitudineOri: latitudineOri,
                        longitudineOri: longitudineOri,
                        latitudineDest: latitudineDest,
                        longitudineDest: longitudineDest,
                      ),
                    ),
                  );
                  widget.historyController.addToHistory(address: _textSpeech);
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
                  _textSpeech = '';
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  minimumSize: const Size(100, 100),
                ),
                child: const Text('No'),
              ),
            ]
          : <Widget>[
              SizedBox(
                width: 100,
                height: 100,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).primaryColor)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Torna indietro',
                      style: TextStyle(fontSize: 18),
                    )),
              )
            ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
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
            _textSpeech == ""
                ? const Text(
                    'In attesa di un indirizzo...',
                    style: TextStyle(fontSize: 24),
                  )
                : Text(
                    _textSpeech,
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
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
