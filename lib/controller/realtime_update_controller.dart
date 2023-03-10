import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:visual_assistant/controller/text_to_speech_controller.dart';

class PathController {
  PathController._privateConstructor();

  static final PathController instance = PathController._privateConstructor();

  bool flag = true, flag2 = true, flag3 = true;
  double? latOrigine;
  double? longOrigine;
  double? latDestinazione;
  double? longDestinazione;

  final TextToSpeechController _textToSpeechController =
      TextToSpeechController.instance;

  //indicazioni viaggio
  Future<void> getDirections(
      double? l1, double? l2, double? l3, double? l4) async {
    String key =
        'AIzaSyC6L4qS7naD72WZV8llfBAEcAvQyU-PdLE'; //chiave per l'API di Google Maps
    if (flag) {
      //avvia la ricerca del percorso solo se il flag è true, perchè se clicchiamo indietro non dobbiamo ricevere più indicazioni su quel percorso (ce ne siamo accorti da terminale)
      //questo url avvia la ricerca del percorso grazie all' API 'Directions'
      final String url =
          'https://maps.googleapis.com/maps/api/directions/json?origin=$l1%2C$l2&destination=$l3%2C$l4&mode=walking&language=it&key=$key';

      var response = await http.get(Uri.parse(url));
      var json = convert.jsonDecode(response.body);

      String svolta = "";

      if (flag2) {
        svolta = "fra " +
            json['routes'][0]['legs'][0]['steps'][0]['distance']['text'] +
            " " +
            json['routes'][0]['legs'][0]['steps'][1]['html_instructions'];
        svolta = controllaContenutoIndicazioni(svolta);
      }

      String indication = json['routes'][0]['legs'][0]['steps'][0]
              ['html_instructions'] +
          ";\n" +
          "distanza:" +
          json['routes'][0]['legs'][0]['distance']['text'] +
          "\n" +
          "tempo previsto:" +
          json['routes'][0]['legs'][0]['duration']['text'];
      indication = controllaContenutoIndicazioni(indication);
      if (flag3 && flag2) {
        //await flutterTts.awaitSpeakCompletion(true);
        _textToSpeechController.speak(indication);
      } else {
        if (flag2) {
          //se le indicazioni sono uguali a quelle della posizione utente allora il percorso non è ancora aggiornato in quanto ad esempio l'utente si trova ancora su quella via
          print("indicazioni:" + svolta);
          _textToSpeechController.speak(svolta);
        } else {
          //altrimenti le indicazioni sono nuove perchè l'utente ha cambiato via e assegnamo a containerIndicazioni le nuove indicazioni generate dall'api
          print("Result=$indication");
          //await flutterTts.awaitSpeakCompletion(true);
          _textToSpeechController
              .speak(indication + ", stai arrivando a destinazione");
        }
      }
      flag3 = false;
      reload();
    }
  }

  void reload() {
    //metodo che chiamiamo per aggiornare ogni 10 secondi il percorso (perchè l'utente si sposta)
    Future.delayed(const Duration(seconds: 13), () {
      getCurrentLocation();
    });
  }

  String controllaContenutoIndicazioni(String indication) {
    //metodo che toglie i tag html dalle indicazioni
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    indication = indication.replaceAll(exp, ' ');
    return indication;
  }

  void getCurrentLocation() async {
    /* var position = await Geolocator()
                .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);*/
    var lastPosition = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    latOrigine = lastPosition.latitude;
    longOrigine = lastPosition.longitude;
    if (latOrigine?.truncate() == latDestinazione?.truncate()) {
      /*
        Non c'è un modo preciso per ottenere la fine perchè le coordinate sono double ed è difficile arrivare al punto 'x.xxxxx' preciso preciso,
        così nei primi due if controlliamo se la parte intera della latitudine e longitudine utente sono uguali (allora sei quasi arrivato),
        poi con il terzi if sottraiamo i valori assoluti della latitudine e longitudine utente con quelli della destinazione e,
        se la differenza è minore di 0.0003 allora possiamo stimare con buona precisione che l'utente è arrivato a destinazione.
      */
      if (longOrigine?.truncate() == longDestinazione?.truncate()) {
        if (((((latOrigine!.abs() + longOrigine!.abs()) -
                    (latDestinazione!.abs() + longDestinazione!.abs()))
                .abs()) <=
            0.0003)) {
          flag2 = false;
          print("La prossima tappa è la destinazione");
        }
      }
    }

    if (flag == true) {
      getDirections(latOrigine, longOrigine, latDestinazione, longDestinazione);
    }
  }

  void getCondizioniMeteo() async {
    String chiave = '7617f59fee974355a15174726232001'; //chiave per l'API meteo
    var url = Uri.parse(
        'http://api.weatherapi.com/v1/current.json?key=$chiave&q=$latOrigine, $longOrigine&aqi=no&lang=it');
    var response = await http.get(url);
    var body = jsonDecode(response.body);

    String condizioniMeteo = 'Condizioni meteo: ' +
        body['current']['temp_c'].toString() +
        " gradi " +
        ' ' +
        body['current']['condition']['text'];

    print(condizioniMeteo);
    /*await flutterTts
        .awaitSpeakCompletion(true);*/ //aspetta il completamento della frase
    _textToSpeechController.speak(condizioniMeteo);

    Future.delayed(const Duration(minutes: 5), () {
      if (flag == true) {
        getCondizioniMeteo();
      }
    });
  }
//fine indicazioni viaggio
}
