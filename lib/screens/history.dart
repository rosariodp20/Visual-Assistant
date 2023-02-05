import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:visual_assistant/controller/favourites_controller.dart';
import 'package:visual_assistant/controller/history_controller.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:visual_assistant/controller/text_to_speech_controller.dart';
import '../widgets/appbar.dart';
import './path.dart';
import '../utils/available_cameras.dart';

class History extends StatefulWidget {
  final List<CameraDescription> cameras;

  const History(this.cameras, {Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final HistoryController _historyController = HistoryController.instance;
  final FavouritesController _favouritesController =
      FavouritesController.instance;
  final TextToSpeechController textToSpeechController =
      TextToSpeechController.instance;

  // State
  List<String> cronologiaPercorsi = ['vuoto', 'vuoto', 'vuoto'];
  List<String> percorsiPreferiti = [];
  int col1 = 255;
  int col2 = 255;
  int col3 = 255;
  int col4 = 255;
  int col5 = 255;
  int col6 = 255;
  int col7 = 255;
  int col8 = 255;
  int col9 = 255;
  String stella1 = 'Aggiungi ai preferiti';
  String stella2 = 'Aggiungi ai preferiti';
  String stella3 = 'Aggiungi ai preferiti';
  bool _percorsoUnoVuoto = false;
  bool _percorsoDueVuoto = false;
  bool _percorsoTreVuoto = false;

  // No state
  double? latitudineOri, longitudineOri; //coordinate origine
  double? latitudineDest1,
      longitudineDest1,
      latitudineDest2,
      longitudineDest2,
      latitudineDest3,
      longitudineDest3;

  Future<void> getCurrentLocation() async {
    var lastPosition = await Geolocator().getLastKnownPosition();
    latitudineOri = lastPosition.latitude;
    longitudineOri = lastPosition.longitude;
  }

  Future<void> convertiDestinazioneinCoordinate1(posizione) async {
    final query = posizione;
    var addresses = await Geocoder.local.findAddressesFromQuery(query);
    var first = addresses.first;
    latitudineDest1 = first.coordinates.latitude;
    longitudineDest1 = first.coordinates.longitude;
  }

  Future<void> convertiDestinazioneinCoordinate2(posizione) async {
    final query = posizione;
    var addresses = await Geocoder.local.findAddressesFromQuery(query);
    var first = addresses.first;
    latitudineDest2 = first.coordinates.latitude;
    longitudineDest2 = first.coordinates.longitude;
  }

  Future<void> convertiDestinazioneinCoordinate3(posizione) async {
    final query = posizione;
    var addresses = await Geocoder.local.findAddressesFromQuery(query);
    var first = addresses.first;
    latitudineDest3 = first.coordinates.latitude;
    longitudineDest3 = first.coordinates.longitude;
  }

  void aggiungiPreferiti1() {
    if (col1 == 255) {
      setState(() {
        col1 = 228;
        col2 = 182;
        col3 = 52;
        stella1 = 'Rimuovi dai preferiti';
        salvaDati('add1');
      });
    } else {
      setState(() {
        col1 = 255;
        col2 = 255;
        col3 = 255;
        stella1 = 'Aggiugni ai preferiti';
        salvaDati('remove1');
      });
    }
  }

  void aggiungiPreferiti2() {
    if (col4 == 255) {
      setState(() {
        col4 = 228;
        col5 = 182;
        col6 = 52;
        stella2 = 'Rimuovi dai preferiti';
        salvaDati('add2');
      });
    } else {
      setState(() {
        col4 = 255;
        col5 = 255;
        col6 = 255;
        stella2 = 'Aggiungi ai preferiti';
        salvaDati('remove2');
      });
    }
  }

  void aggiungiPreferiti3() {
    if (col7 == 255) {
      setState(() {
        col7 = 228;
        col8 = 182;
        col9 = 52;
        stella3 = 'Rimuovi dai preferiti';
        salvaDati('add3');
      });
    } else {
      setState(() {
        col7 = 255;
        col8 = 255;
        col9 = 255;
        stella3 = 'Aggiungi ai preferiti';
        salvaDati('remove3');
      });
    }
  }

  @override
  void initState() {
    super.initState();
    funzioneAspettaRecupera();
  }

  void funzioneAspettaRecupera() async {
    recuperaDati();
    recuperaDatiPreferiti();
    inizializzaPreferiti();

    try {
      await getCurrentLocation();
      await convertiDestinazioneinCoordinate1(cronologiaPercorsi[0]);
      await convertiDestinazioneinCoordinate2(cronologiaPercorsi[1]);
      await convertiDestinazioneinCoordinate3(cronologiaPercorsi[2]);
    } catch (e) {
      print('errore');
    }
  }

  void inizializzaPreferiti() {
    print(percorsiPreferiti);
    print(cronologiaPercorsi);

    if (percorsiPreferiti.contains(cronologiaPercorsi[0])) {
      setState(() {
        col1 = 228;
        col2 = 182;
        col3 = 52;
        stella1 = 'Rimuovi dai preferiti';
      });
    }

    if (percorsiPreferiti.contains(cronologiaPercorsi[1])) {
      setState(() {
        col4 = 228;
        col5 = 182;
        col6 = 52;
        stella2 = 'Rimuovi dai preferiti';
      });
    }

    if (percorsiPreferiti.contains(cronologiaPercorsi[2])) {
      setState(() {
        col7 = 228;
        col8 = 182;
        col9 = 52;
        stella3 = 'Rimuovi dai preferiti';
      });
    }

    if (cronologiaPercorsi[0] == 'vuoto') {
      setState(() {
        _percorsoUnoVuoto = true;
      });
    }
    if (cronologiaPercorsi[1] == 'vuoto') {
      setState(() {
        _percorsoDueVuoto = true;
      });
    }
    if (cronologiaPercorsi[2] == 'vuoto') {
      setState(() {
        _percorsoTreVuoto = true;
      });
    }
  }

  void salvaDati(String value) {
    List<String> history = _historyController.getHistoryList();

    switch (value) {
      case ('add1'):
        _favouritesController.addToFavouritesByAddress(history[0]);
        break;
      case ('add2'):
        _favouritesController.addToFavouritesByAddress(history[1]);
        break;
      case ('add3'):
        _favouritesController.addToFavouritesByAddress(history[2]);
        break;
      case ('remove1'):
        _favouritesController.removeByAddress(history[0]);
        break;
      case ('remove2'):
        _favouritesController.removeByAddress(history[1]);
        break;
      case ('remove3'):
        _favouritesController.removeByAddress(history[2]);
        break;
    }
    print(percorsiPreferiti);
  }

  void recuperaDati() {
    final pathsHistory = _historyController.getHistoryList();

    // We save a rebuild...
    if (pathsHistory.isEmpty) return;

    for (int i = pathsHistory.length; i < 3; i++) {
      pathsHistory.add('vuoto');
    }

    setState(() {
      cronologiaPercorsi = pathsHistory;
    });
  }

  void recuperaDatiPreferiti() {
    setState(() {
      percorsiPreferiti = _favouritesController.getFavouritesList();
    });
  }

  /////////////////////////////////////////////////////////////////////////
  Widget dialogEliminaPreferito(BuildContext context, String butt,
      String favouriteToRemove, String favouriteToAdd) {
    String alert = "Il limite di 3 preferiti è stato raggiunto. "
        "Aggiungendo $favouriteToAdd, verrà rimosso $favouriteToRemove dalla lista dei preferiti."
        " Premere si per confermare, no per tornare indietro?";

    textToSpeechController.speak(alert);
    return AlertDialog(
      title: const Text(''),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[Text(alert)],
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            if (butt == 'but1') {
              aggiungiPreferiti1();
              Navigator.of(context).pop();
            } else if (butt == 'but2') {
              aggiungiPreferiti2();
              Navigator.of(context).pop();
            } else if (butt == 'but3') {
              aggiungiPreferiti3();
              Navigator.of(context).pop();
            }
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

///////////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      backgroundColor: Colors.grey[50],
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 50),
              child: const Text(
                'Cronologia Percorsi',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  margin: const EdgeInsets.symmetric(vertical: 60),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 18),
                        backgroundColor: const Color(0xff0d7a9a),
                        minimumSize: const Size(230, 100),
                      ),
                      onPressed: _percorsoUnoVuoto
                          ? null
                          : () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Path(
                                    cameras,
                                    latitudineOri: latitudineOri,
                                    longitudineOri: longitudineOri,
                                    latitudineDest: latitudineDest1,
                                    longitudineDest: longitudineDest1,
                                  ),
                                ),
                              );
                            },
                      child: AutoSizeText(
                        cronologiaPercorsi[0],
                        maxLines: 1,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      )),
                ),
                Semantics(
                    label: stella1,
                    excludeSemantics: true,
                    child: ElevatedButton.icon(
                      onPressed: _percorsoUnoVuoto
                          ? null
                          : () {
                              if (percorsiPreferiti.length == 3 &&
                                  col1 == 255) {
                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (BuildContext context) =>
                                      dialogEliminaPreferito(
                                          context,
                                          'but1',
                                          percorsiPreferiti[0],
                                          cronologiaPercorsi[0]),
                                );
                              } else {
                                aggiungiPreferiti1();
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(20, 100),
                        backgroundColor: const Color(0xff0d7a9a),
                        padding: const EdgeInsets.only(left: 17, right: 10),
                      ),
                      icon: Icon(
                        Icons.star,
                        color: Color.fromRGBO(col1, col2, col3, 1),
                      ),
                      //Icon(Icons.star),
                      label: const Text(""),
                    ))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        //shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0),),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 18),
                        backgroundColor: const Color(0xff0d7a9a),
                        minimumSize: const Size(230, 100),
                      ),
                      onPressed: _percorsoDueVuoto
                          ? null
                          : () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Path(
                                    cameras,
                                    latitudineOri: latitudineOri,
                                    longitudineOri: longitudineOri,
                                    latitudineDest: latitudineDest2,
                                    longitudineDest: longitudineDest2,
                                  ),
                                ),
                              );
                            },
                      child: AutoSizeText(
                        cronologiaPercorsi[1],
                        maxLines: 1,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      )),
                ),
                Semantics(
                    label: stella2,
                    excludeSemantics: true,
                    child: ElevatedButton.icon(
                      onPressed: _percorsoDueVuoto
                          ? null
                          : () {
                              if (percorsiPreferiti.length == 3 &&
                                  col4 == 255) {
                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (BuildContext context) =>
                                      dialogEliminaPreferito(
                                          context,
                                          'but2',
                                          percorsiPreferiti[0],
                                          cronologiaPercorsi[1]),
                                );
                              } else {
                                aggiungiPreferiti2();
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(20, 100),
                        backgroundColor: const Color(0xff0d7a9a),
                        padding: const EdgeInsets.only(left: 17, right: 10),
                      ),
                      icon: Icon(
                        Icons.star,
                        color: Color.fromRGBO(col4, col5, col6, 1),
                      ),
                      //Icon(Icons.star),
                      label: const Text(""),
                    ))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  margin: const EdgeInsets.symmetric(vertical: 60),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        //shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0),),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 18),
                        backgroundColor: const Color(0xff0d7a9a),
                        minimumSize: const Size(230, 100),
                      ),
                      onPressed: _percorsoTreVuoto
                          ? null
                          : () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Path(
                                    cameras,
                                    latitudineOri: latitudineOri,
                                    longitudineOri: longitudineOri,
                                    latitudineDest: latitudineDest3,
                                    longitudineDest: longitudineDest3,
                                  ),
                                ),
                              );
                            },
                      child: AutoSizeText(
                        cronologiaPercorsi[2],
                        maxLines: 1,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      )),
                ),
                Semantics(
                    label: stella3,
                    excludeSemantics: true,
                    child: ElevatedButton.icon(
                      onPressed: _percorsoTreVuoto
                          ? null
                          : () {
                              if (percorsiPreferiti.length == 3 &&
                                  col7 == 255) {
                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (BuildContext context) =>
                                      dialogEliminaPreferito(
                                          context,
                                          'but3',
                                          percorsiPreferiti[0],
                                          cronologiaPercorsi[2]),
                                );
                              } else {
                                aggiungiPreferiti3();
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(20, 100),
                        backgroundColor: const Color(0xff0d7a9a),
                        padding: const EdgeInsets.only(left: 17, right: 10),
                      ),
                      icon: Icon(
                        Icons.star,
                        color: Color.fromRGBO(col7, col8, col9, 1),
                      ),
                      //Icon(Icons.star),
                      label: const Text(""),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
