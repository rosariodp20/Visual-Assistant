import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../controller/favourites_controller.dart';
import '../widgets/appbar.dart';
import '../main.dart';
import './path.dart';

class Favourites extends StatefulWidget {
  final List<CameraDescription> cameras;

  const Favourites(this.cameras, {Key? key}) : super(key: key);

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  FavouritesController favouritesController = FavouritesController.instance;

  List<String> percorsiPreferiti = ['vuoto', 'vuoto', 'vuoto'];
  int col1 = 255;
  int col2 = 255;
  int col3 = 255;
  int col4 = 255;
  int col5 = 255;
  int col6 = 255;
  int col7 = 255;
  int col8 = 255;
  int col9 = 255;
  bool _percorsoUnoVuoto = false;
  bool _percorsoDueVuoto = false;
  bool _percorsoTreVuoto = false;
  String pref1 = 'vuoto';
  String pref2 = 'vuoto';
  String pref3 = 'vuoto';
  double? latitudineOri, longitudineOri; //coordinate origine
  double? latitudineDest1,
      longitudineDest1,
      latitudineDest2,
      longitudineDest2,
      latitudineDest3,
      longitudineDest3;

  @override
  void initState() {
    super.initState();
    funzioneAspettaRecupera();
  }

  void funzioneAspettaRecupera() async {
    await recuperaDati();
    await getCurrentLocation();

    try {
      await convertiDestinazioneinCoordinate1(pref1);
      await convertiDestinazioneinCoordinate2(pref2);
      await convertiDestinazioneinCoordinate3(pref3);
    } catch (e) {
      print('errore -> ${e}');
    }
  }

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

  Future<void> recuperaDati() async {
    List<String> favouritesList = favouritesController.getFavouritesList();

    if (favouritesList.length == 1) {
      setState(() {
        pref1 = favouritesList[0];
        col1 = 228;
        col2 = 182;
        col3 = 52;
        _percorsoDueVuoto = true;
        _percorsoTreVuoto = true;
      });
    } else if (favouritesList.length == 2) {
      setState(() {
        pref1 = favouritesList[0];
        pref2 = favouritesList[1];
        col1 = 228;
        col2 = 182;
        col3 = 52;
        col4 = 228;
        col5 = 182;
        col6 = 52;
        _percorsoTreVuoto = true;
      });
    } else if (favouritesList.length == 3) {
      setState(() {
        pref1 = favouritesList[0];
        pref2 = favouritesList[1];
        pref3 = favouritesList[2];
        col1 = 228;
        col2 = 182;
        col3 = 52;
        col4 = 228;
        col5 = 182;
        col6 = 52;
        col7 = 228;
        col8 = 182;
        col9 = 52;
      });
    } else if (favouritesList.isEmpty) {
      setState(() {
        _percorsoUnoVuoto = true;
        _percorsoDueVuoto = true;
        _percorsoTreVuoto = true;
      });
    }
  }

  void aggiornaDati() {
    setState(() {
      percorsiPreferiti = favouritesController.getFavouritesList();
      if (percorsiPreferiti.length == 1) {
        pref1 = percorsiPreferiti[0];
        pref2 = 'vuoto';
        pref3 = 'vuoto';
        col1 = 228;
        col2 = 182;
        col3 = 52;
        col4 = 255;
        col5 = 255;
        col6 = 255;
        col7 = 255;
        col8 = 255;
        col9 = 255;
        _percorsoUnoVuoto = false;
        _percorsoDueVuoto = true;
        _percorsoTreVuoto = true;
      } else if (percorsiPreferiti.length == 2) {
        pref1 = percorsiPreferiti[0];
        pref2 = percorsiPreferiti[1];
        pref3 = 'vuoto';
        col1 = 228;
        col2 = 182;
        col3 = 52;
        col4 = 228;
        col5 = 182;
        col6 = 52;
        col7 = 255;
        col8 = 255;
        col9 = 255;
        _percorsoUnoVuoto = false;
        _percorsoDueVuoto = false;
        _percorsoTreVuoto = true;
      } else if (percorsiPreferiti.isEmpty) {
        _percorsoUnoVuoto = true;
        _percorsoDueVuoto = true;
        _percorsoTreVuoto = true;
        col1 = 255;
        col2 = 255;
        col3 = 255;
        col4 = 255;
        col5 = 255;
        col6 = 255;
        col7 = 255;
        col8 = 255;
        col9 = 255;
        pref1 = 'vuoto';
        pref2 = 'vuoto';
        pref3 = 'vuoto';
      }
    });
  }

  void rimuoviPreferiti(bottone) {
    switch (bottone) {
      case 'but1':
        favouritesController.removeFromFavouritesByPosition(0);
        break;
      case 'but2':
        favouritesController.removeFromFavouritesByPosition(1);
        break;
      case 'but3':
        favouritesController.removeFromFavouritesByPosition(2);
        break;
    }

    aggiornaDati();
  }

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
                'Destinazioni Preferite',
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
                        //shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0),),
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
                                    flutterTts,
                                    latitudineOri: latitudineOri,
                                    longitudineOri: longitudineOri,
                                    latitudineDest: latitudineDest1,
                                    longitudineDest: longitudineDest1,
                                  ),
                                ),
                              );
                            },
                      child: AutoSizeText(
                        pref1,
                        maxLines: 1,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      )),
                ),
                Semantics(
                    label: 'Rimuovi dai preferiti',
                    excludeSemantics: true,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        if (_percorsoUnoVuoto) return;
                        rimuoviPreferiti('but1');
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
                Container(
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
                                    flutterTts,
                                    latitudineOri: latitudineOri,
                                    longitudineOri: longitudineOri,
                                    latitudineDest: latitudineDest2,
                                    longitudineDest: longitudineDest2,
                                  ),
                                ),
                              );
                            },
                      child: AutoSizeText(
                        pref2,
                        maxLines: 1,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      )),
                ),
                Semantics(
                    label: 'Rimuovi dai preferiti',
                    excludeSemantics: true,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        if (_percorsoDueVuoto) return;
                        rimuoviPreferiti('but2');
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(20, 100),
                        backgroundColor: const Color(0xff0d7a9a),
                        foregroundColor: Colors.white,
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
                  margin: EdgeInsets.symmetric(vertical: 60),
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
                                    flutterTts,
                                    latitudineOri: latitudineOri,
                                    longitudineOri: longitudineOri,
                                    latitudineDest: latitudineDest3,
                                    longitudineDest: longitudineDest3,
                                  ),
                                ),
                              );
                            },
                      child: AutoSizeText(
                        pref3,
                        maxLines: 1,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      )),
                ),
                Semantics(
                    label: 'Rimuovi dai preferiti',
                    excludeSemantics: true,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        if (_percorsoTreVuoto) return;
                        rimuoviPreferiti('but3');
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
