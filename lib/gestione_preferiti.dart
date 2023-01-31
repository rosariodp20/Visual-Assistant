import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:camera/camera.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:visual_assistant/main.dart';
import 'package:visual_assistant/viaggio.dart';

class GestionePreferiti extends StatefulWidget {
  final List<CameraDescription> cameras;
  const GestionePreferiti(this.cameras,{Key? key}) : super(key: key);

  @override
  State<GestionePreferiti> createState() => _GestionePreferitiState();
}

class _GestionePreferitiState extends State<GestionePreferiti> {
  List<String> percorsiPreferiti = ['vuoto','vuoto','vuoto'];
  int col1=255;
  int col2=255;
  int col3=255;
  int col4=255;
  int col5=255;
  int col6=255;
  int col7=255;
  int col8=255;
  int col9=255;
  bool _percorsoUnoVuoto = false;
  bool _percorsoDueVuoto = false;
  bool _percorsoTreVuoto = false;
  String pref1= 'vuoto';
  String pref2= 'vuoto';
  String pref3= 'vuoto';
  double? latitudineOri, longitudineOri; //coordinate origine
  double? latitudineDest1, longitudineDest1, latitudineDest2, longitudineDest2, latitudineDest3, longitudineDest3;


  void initState() {
    super.initState();
    funzioneAspettaRecupera();
  }

  void funzioneAspettaRecupera() async{
    await recuperaDati();
    await getCurrentLocation();
    try{
      await convertiDestinazioneinCoordinate1(pref1);
    }
    catch(e){
      print('errore');
    }
    try{
      await convertiDestinazioneinCoordinate2(pref2);
    }
    catch(e){
      print('errore');
    }
    try{
      await convertiDestinazioneinCoordinate3(pref3);
    }
    catch(e){
      print('errore');
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

  Future<void> recuperaDati() async{
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList('listaPercorsiPreferiti') != null){
      percorsiPreferiti = prefs.getStringList('listaPercorsiPreferiti')!;
      setState(() {
        if (percorsiPreferiti.length==1){
          setState(() {
            pref1 = percorsiPreferiti[0];
            col1 = 228;
            col2 = 182;
            col3 = 52;
            _percorsoDueVuoto = true;
            _percorsoTreVuoto = true;
          });
        } else if (percorsiPreferiti.length==2){
          setState(() {
            pref1 = percorsiPreferiti[0];
            pref2 = percorsiPreferiti[1];
            col1 = 228;
            col2 = 182;
            col3 = 52;
            col4 = 228;
            col5 = 182;
            col6 = 52;
            _percorsoTreVuoto = true;
          });
        }
        else if (percorsiPreferiti.length==3){
          setState(() {
            pref1 = percorsiPreferiti[0];
            pref2 = percorsiPreferiti[1];
            pref3 = percorsiPreferiti[2];
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
        }
        else if (percorsiPreferiti.length==0){
          setState(() {
            _percorsoUnoVuoto = true;
            _percorsoDueVuoto = true;
            _percorsoTreVuoto = true;
          });
        }
      });
    }
    else{
      setState(() {
        _percorsoUnoVuoto = true;
        _percorsoDueVuoto = true;
        _percorsoTreVuoto = true;
      });
    }
  }

  Future<void> aggiornaDati() async{
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList('listaPercorsiPreferiti') != null){
      percorsiPreferiti = prefs.getStringList('listaPercorsiPreferiti')!;
      setState(() {
        if (percorsiPreferiti.length==1){
          setState(() {
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
          });
        } else if (percorsiPreferiti.length==2){
          setState(() {
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
          });
        }
        else if (percorsiPreferiti.length==0){
          setState(() {
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
          });
        }
      });
    }
    else{
      setState(() {
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
      });
    }
  }

  Future<void> rimuoviPreferiti(bottone) async {
    if(bottone == 'but1'){
      percorsiPreferiti.removeAt(0);
      final prefs = await SharedPreferences.getInstance();
      prefs.setStringList("listaPercorsiPreferiti", percorsiPreferiti);
      setState(() {
        aggiornaDati();
      });
    }
    if(bottone == 'but2'){
      percorsiPreferiti.removeAt(1);
      final prefs = await SharedPreferences.getInstance();
      prefs.setStringList("listaPercorsiPreferiti", percorsiPreferiti);
      setState(() {
        aggiornaDati();
      });
    }
    if(bottone == 'but3'){
      percorsiPreferiti.removeAt(2);
      final prefs = await SharedPreferences.getInstance();
      prefs.setStringList("listaPercorsiPreferiti", percorsiPreferiti);
      setState(() {
        aggiornaDati();
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text("Visual Assistant"),
        ),
        backgroundColor: Colors.grey[50],
        body:SingleChildScrollView(
            child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(30),
                child: Column (
                    children: [
                      SizedBox(height: 30,),
                      Row(
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                //shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0),),
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                                minimumSize: Size(230, 100),
                                //side: BorderSide(width: 4.0, color: Color(0xff68240b)),
                                primary: Color.fromRGBO(176, 224, 230, 1),
                              ),
                              onPressed: _percorsoUnoVuoto? null : () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => viaggio(
                                      cameras,
                                      latitudineOri: latitudineOri,
                                      longitudineOri: longitudineOri,
                                      latitudineDest: latitudineDest1,
                                      longitudineDest: longitudineDest1,
                                    ),
                                  ),
                                );
                              },
                              child: Text('$pref1',style: TextStyle(color: Colors.black,fontSize: 10,),)
                          ),
                          Semantics(
                            label: "Rimuovi dai preferiti",
                            excludeSemantics: true,
                            child:
                              ElevatedButton.icon(
                                onPressed: _percorsoUnoVuoto? null : () { rimuoviPreferiti('but1'); },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(20, 100),
                                  primary: Color.fromRGBO(176, 224, 230, 1),
                                  padding:EdgeInsets.only(left: 17,right: 10),
                                ),
                                icon: Icon(Icons.star, color: Color.fromRGBO(col1, col2, col3, 1),),                             //Icon(Icons.star),
                                label: Text(""),
                              )
                          )
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(height:30)
                          ],
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                //shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0),),
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                                minimumSize: Size(230, 100),
                                //side: BorderSide(width: 4.0, color: Color(0xff68240b)),
                                primary: Color.fromRGBO(176, 224, 230, 1),
                              ),
                              onPressed: _percorsoDueVuoto? null :() {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => viaggio(
                                      cameras,
                                      latitudineOri: latitudineOri,
                                      longitudineOri: longitudineOri,
                                      latitudineDest: latitudineDest2,
                                      longitudineDest: longitudineDest2,
                                    ),
                                  ),
                                );
                              },
                              child: Text('$pref2',style: TextStyle(color: Colors.black,fontSize: 10,),)
                          ),
                          Semantics(
                            label: "Rimuovi dai preferiti",
                            excludeSemantics: true,
                            child:
                              ElevatedButton.icon(
                                onPressed: _percorsoDueVuoto? null : () { rimuoviPreferiti('but2'); },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(20, 100),
                                  primary: Color.fromRGBO(176, 224, 230, 1),
                                  padding:EdgeInsets.only(left: 17,right: 10),
                                ),
                                icon: Icon(Icons.star, color: Color.fromRGBO(col4, col5, col6, 1),),                             //Icon(Icons.star),
                                label: Text(""),
                              )
                          )
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(height:30)
                        ],
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                //shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0),),
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                                minimumSize: Size(230, 100),
                                //side: BorderSide(width: 4.0, color: Color(0xff68240b)),
                                primary: Color.fromRGBO(176, 224, 230, 1),
                              ),
                              onPressed: _percorsoTreVuoto? null : () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => viaggio(
                                      cameras,
                                      latitudineOri: latitudineOri,
                                      longitudineOri: longitudineOri,
                                      latitudineDest: latitudineDest3,
                                      longitudineDest: longitudineDest3,
                                    ),
                                  ),
                                );
                              },
                              child: Text('$pref3',style: TextStyle(color: Colors.black,fontSize: 10,),)
                          ),
                          Semantics(
                            label: "Rimuovi dai preferiti",
                            excludeSemantics: true,
                            child:
                              ElevatedButton.icon(
                                onPressed: _percorsoTreVuoto? null : () { rimuoviPreferiti('but3'); },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(20, 100),
                                  primary: Color.fromRGBO(176, 224, 230, 1),
                                  padding:EdgeInsets.only(left: 17,right: 10),
                                ),
                                icon: Icon(Icons.star, color: Color.fromRGBO(col7, col8, col9, 1),),                             //Icon(Icons.star),
                                label: Text(""),
                              )
                          )
                        ],

                      )
                    ]
                )
            )
        )
    );
  }
}

