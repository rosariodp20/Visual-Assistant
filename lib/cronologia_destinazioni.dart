import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:camera/camera.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:visual_assistant/main.dart';
import 'package:visual_assistant/viaggio.dart';

class CronologiaDestinazioni extends StatefulWidget {
  final List<CameraDescription> cameras;
  const CronologiaDestinazioni(this.cameras,{Key? key}) : super(key: key);

  @override
  State<CronologiaDestinazioni> createState() => _CronologiaDestinazioniState();
}

class _CronologiaDestinazioniState extends State<CronologiaDestinazioni> {
  List<String> cronologiaPercorsi = ['vuoto','vuoto','vuoto'];
  List<String> percorsiPreferiti = [];
  int col1=255;
  int col2=255;
  int col3=255;
  int col4=255;
  int col5=255;
  int col6=255;
  int col7=255;
  int col8=255;
  int col9=255;
  String stella1 = 'Aggiungi ai preferiti';
  String stella2 = 'Aggiungi ai preferiti';
  String stella3 = 'Aggiungi ai preferiti';
  bool _percorsoUnoVuoto = false;
  bool _percorsoDueVuoto = false;
  bool _percorsoTreVuoto = false;
  double? latitudineOri, longitudineOri; //coordinate origine
  double? latitudineDest1, longitudineDest1, latitudineDest2, longitudineDest2, latitudineDest3, longitudineDest3;

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

  void aggiungiPreferiti1(){
    if(col1==255) {
      setState(() {
        col1 = 228;
        col2 = 182;
        col3 = 52;
        stella1 = 'Rimuovi dai preferiti';
        salvaDati('add1');
      });

    }
    else{
      setState(() {
        col1=255;
        col2=255;
        col3=255;
        stella1 = 'Aggiugni ai preferiti';
        salvaDati('remove1');
      });

    }
  }


  void aggiungiPreferiti2(){
    if(col4==255) {
      setState(() {
        col4 = 228;
        col5= 182;
        col6 = 52;
        stella2 = 'Rimuovi dai preferiti';
        salvaDati('add2');
      });

    }
    else{
      setState(() {
        col4=255;
        col5=255;
        col6=255;
        stella2 = 'Aggiungi ai preferiti';
        salvaDati('remove2');
      });

    }
  }

  void aggiungiPreferiti3(){
    if(col7==255) {
      setState(() {
        col7 = 228;
        col8 = 182;
        col9 = 52;
        stella3 = 'Rimuovi dai preferiti';
        salvaDati('add3');
      });

    }
    else{
      setState(() {
        col7=255;
        col8=255;
        col9=255;
        stella3 = 'Aggiungi ai preferiti';
        salvaDati('remove3');
      });

    }
  }


  void initState() {
    super.initState();
    funzioneAspettaRecupera();
  }

  void funzioneAspettaRecupera() async{
    await recuperaDati();
    await recuperaDatiPreferiti();
    await inizializzaPreferiti();
    await getCurrentLocation();
    try{
      await convertiDestinazioneinCoordinate1(cronologiaPercorsi[0]);
    }
    catch(e){
      print('errore');
    }
    try{
      await convertiDestinazioneinCoordinate2(cronologiaPercorsi[1]);
    }
    catch(e){
      print('errore');
    }
    try{
      await convertiDestinazioneinCoordinate3(cronologiaPercorsi[2]);
    }
    catch(e){
      print('errore');
    }
  }

  Future<void> inizializzaPreferiti() async {
    print(percorsiPreferiti);
    print(cronologiaPercorsi);
    if(percorsiPreferiti.contains(cronologiaPercorsi[0])){
      setState(() {
        col1 = 228;
        col2 = 182;
        col3 = 52;
        stella1 = 'Rimuovi dai preferiti';
      });
    }
    if(percorsiPreferiti.contains(cronologiaPercorsi[1])){
      setState(() {
        col4 = 228;
        col5 = 182;
        col6 = 52;
        stella2 = 'Rimuovi dai preferiti';
      });
    }
    if(percorsiPreferiti.contains(cronologiaPercorsi[2])) {
      setState(() {
        col7 = 228;
        col8 = 182;
        col9 = 52;
        stella3 = 'Rimuovi dai preferiti';
      });
    }

    if(cronologiaPercorsi[0]=='vuoto'){
      setState(() {
        _percorsoUnoVuoto = true;
      });
    }
    if(cronologiaPercorsi[1]=='vuoto'){
      setState(() {
        _percorsoDueVuoto = true;
      });
    }
    if(cronologiaPercorsi[2]=='vuoto'){
      setState(() {
        _percorsoTreVuoto = true;
      });
    }

      print('aaaaaaaaa');
  }

  void salvaDati(value) async{
    final prefs = await SharedPreferences.getInstance();
    if (value=='add1') {
      if (percorsiPreferiti.length < 3) {
        percorsiPreferiti.add(cronologiaPercorsi[0]);
      }
      else {
        percorsiPreferiti.removeAt(0);
        percorsiPreferiti.add(cronologiaPercorsi[0]);
      }
    }
    if (value=='add2') {
      if (percorsiPreferiti.length < 3) {
        percorsiPreferiti.add(cronologiaPercorsi[1]);
      }
      else {
        percorsiPreferiti.removeAt(0);
        percorsiPreferiti.add(cronologiaPercorsi[1]);
      }
    }
    if (value=='add3') {
      if (percorsiPreferiti.length < 3) {
        percorsiPreferiti.add(cronologiaPercorsi[2]);
      }
      else {
        percorsiPreferiti.removeAt(0);
        percorsiPreferiti.add(cronologiaPercorsi[2]);
      }
    }
    if (value=='remove1') {
      if(percorsiPreferiti.contains(cronologiaPercorsi[0])){
        percorsiPreferiti.remove(cronologiaPercorsi[0]);
      }
    }
    if (value=='remove2') {
      if(percorsiPreferiti.contains(cronologiaPercorsi[1])){
        percorsiPreferiti.remove(cronologiaPercorsi[1]);
      }
    }
    if (value=='remove3') {
      if(percorsiPreferiti.contains(cronologiaPercorsi[2])){
        percorsiPreferiti.remove(cronologiaPercorsi[2]);
      }
    }

    prefs.setStringList("listaPercorsiPreferiti", percorsiPreferiti);
    print(percorsiPreferiti);
  }

  Future<void> recuperaDati() async{
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList('listaCronologiaPercorsi') != null){
      cronologiaPercorsi = prefs.getStringList('listaCronologiaPercorsi')!;
      setState(() {
        if (cronologiaPercorsi.length==1){
          cronologiaPercorsi.add('vuoto');
          cronologiaPercorsi.add('vuoto');
        } else if (cronologiaPercorsi.length==2){
          cronologiaPercorsi.add('vuoto');
        }

      });
    }
  }

  Future<void> recuperaDatiPreferiti() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList('listaPercorsiPreferiti') != null) {
      percorsiPreferiti = prefs.getStringList('listaPercorsiPreferiti')!;
    }
  }


 /////////////////////////////////////////////////////////////////////////
  Widget dialogEliminaPreferito(BuildContext context, String butt) {

    //flutterTts.speak("Il limite di 3 preferiti è stato raggiunto. Aggiungendo il seguente indirizzo verrà rimosso il primo dalla lista dei preferiti. Continuare?");
    return AlertDialog(
      title: const Text(''),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Il limite di 3 preferiti è stato raggiunto. Aggiungendo il seguente indirizzo verrà rimosso il primo dalla lista dei preferiti. Continuare?"),
        ],
      ),
      actions: <Widget>[
        new ElevatedButton(
          onPressed: () {
            if (butt=='but1'){
              aggiungiPreferiti1();
              Navigator.of(context).pop();
            }
            else if (butt=='but2'){
              aggiungiPreferiti2();
              Navigator.of(context).pop();
            }
            else if (butt=='but3'){
              aggiungiPreferiti3();
              Navigator.of(context).pop();
            }
          },
          style: ElevatedButton.styleFrom(
            minimumSize: Size(100, 100),
          ),
          child: const Text('Si'),
        ),
        SizedBox(
          width: 40,
        ),
        new ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            minimumSize: Size(100, 100),
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
                              child: Text('${cronologiaPercorsi[0]}',style: TextStyle(color: Colors.black,fontSize: 10,),)
                          ),
                          Semantics(
                            label: "$stella1",
                            excludeSemantics: true,
                            child:
                                    ElevatedButton.icon(
                                        onPressed: _percorsoUnoVuoto? null : () {
                                            if(percorsiPreferiti.length == 3 && col1==255){
                                              showDialog(
                                                barrierDismissible: false,
                                                context: context,
                                                builder: (BuildContext context) => dialogEliminaPreferito(context, 'but1'),
                                              );
                                            }
                                            else{
                                              aggiungiPreferiti1();
                                            }
                                          },
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
                              child: Text('${cronologiaPercorsi[1]}',style: TextStyle(color: Colors.black,fontSize: 10,),)
                          ),
                          Semantics(
                            label: "$stella2",
                            excludeSemantics: true,
                            child:
                              ElevatedButton.icon(
                                onPressed: _percorsoDueVuoto? null : () {
                                  if(percorsiPreferiti.length == 3 && col4==255){
                                    showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) => dialogEliminaPreferito(context, 'but2'),
                                    );
                                  }
                                  else{
                                    aggiungiPreferiti2();
                                  }
                                },
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
                              child: Text('${cronologiaPercorsi[2]}',style: TextStyle(color: Colors.black,fontSize: 10,),)
                          ),
                          Semantics(
                            label: "$stella3",
                            excludeSemantics: true,
                            child:
                              ElevatedButton.icon(
                                onPressed: _percorsoTreVuoto? null : () {
                                  if(percorsiPreferiti.length == 3 && col7==255){
                                    showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) => dialogEliminaPreferito(context, 'but3'),
                                    );
                                  }
                                  else{
                                    aggiungiPreferiti3();
                                  }
                                },
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

