import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'dart:math' as math;
import 'main.dart';
import 'models.dart';

String prevNotified = "";
List<String> dangElements = [
  'bicycle',
  'car',
  'motorbike',
  'bus',
  'train',
  'truck',
  'traffic light',
  'stop sign',
  'laptop'
];

class BndBox extends StatelessWidget {
  final List<dynamic> results;
  final int previewH;
  final int previewW;
  final double screenH;
  final double screenW;
  final String model;

  const BndBox(this.results, this.previewH, this.previewW, this.screenH,
      this.screenW, this.model,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> _renderBoxes() {
      return results.map((re) {
        var _x = re["rect"]["x"];
        var _w = re["rect"]["w"];
        var _y = re["rect"]["y"];
        var _h = re["rect"]["h"];
        var scaleW, scaleH, x, y, w, h;

        if (screenH / screenW > previewH / previewW) {
          scaleW = screenH / previewH * previewW;
          scaleH = screenH;
          var difW = (scaleW - screenW) / scaleW;
          x = (_x - difW / 2) * scaleW;
          w = _w * scaleW;
          if (_x < difW / 2) w -= (difW / 2 - _x) * scaleW;
          y = _y * scaleH;
          h = _h * scaleH;
        } else {
          scaleH = screenW / previewW * previewH;
          scaleW = screenW;
          var difH = (scaleH - screenH) / scaleH;
          x = _x * scaleW;
          w = _w * scaleW;
          y = (_y - difH / 2) * scaleH;
          h = _h * scaleH;
          if (_y < difH / 2) h -= (difH / 2 - _y) * scaleH;
        }

        notifyElement(re["detectedClass"], (re["confidenceInClass"] * 100));

        return Positioned(
          left: math.max(0, x),
          top: math.max(0, y),
          width: w,
          height: h,
          child: Container(
            padding: const EdgeInsets.only(top: 5.0, left: 5.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.red,
                width: 3.0,
              ),
            ),
            child: Text(
              "${re["detectedClass"]} ${(re["confidenceInClass"] * 100).toStringAsFixed(0)}%",
              style: const TextStyle(
                color: Colors.red,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }).toList();
    }

    List<Widget> _renderStrings() {
      double offset = -10;
      return results.map((re) {
        offset = offset + 14;
        return Positioned(
          left: 10,
          top: offset,
          width: screenW,
          height: screenH,
          child: Text(
            "${re["label"]} ${(re["confidence"] * 100).toStringAsFixed(0)}%",
            style: const TextStyle(
              color: Colors.red,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }).toList();
    }

    List<Widget> _renderKeypoints() {
      var lists = <Widget>[];
      results.forEach((re) {
        var list = re["keypoints"].values.map<Widget>((k) {
          var _x = k["x"];
          var _y = k["y"];
          var scaleW, scaleH, x, y;

          if (screenH / screenW > previewH / previewW) {
            scaleW = screenH / previewH * previewW;
            scaleH = screenH;
            var difW = (scaleW - screenW) / scaleW;
            x = (_x - difW / 2) * scaleW;
            y = _y * scaleH;
          } else {
            scaleH = screenW / previewW * previewH;
            scaleW = screenW;
            var difH = (scaleH - screenH) / scaleH;
            x = _x * scaleW;
            y = (_y - difH / 2) * scaleH;
          }
          return Positioned(
            left: x - 6,
            top: y - 6,
            width: 100,
            height: 12,
            child: Container(
              child: Text(
                "● ${k["part"]}",
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 12.0,
                ),
              ),
            ),
          );
        }).toList();

        lists.addAll(list);
      });

      return lists;
    }

    return Stack(
      children: model == mobilenet
          ? _renderStrings()
          : model == posenet
              ? _renderKeypoints()
              : _renderBoxes(),
    );
  }
}

void traduciInItaliano(String element) {
  switch (element) {
    case "person":
      flutterTts.speak("persona");
      break;

    case "bicycle":
      flutterTts.speak("bicicletta");
      break;

    case "car":
      flutterTts.speak("automobile");
      break;

    case "motorbike":
      flutterTts.speak("motocicletta");
      break;

    case "aeroplane":
      flutterTts.speak("aereoplano");
      break;

    case "bus":
      flutterTts.speak("autobus");
      break;

    case "train":
      flutterTts.speak("treno");
      break;

    case "truck":
      flutterTts.speak("camion");
      break;

    case "boat":
      flutterTts.speak("barca");
      break;

    case "traffic light":
      flutterTts.speak("semaforo");
      break;

    case "fire hydrant":
      flutterTts.speak("estintore");
      break;

    case "stop sign":
      flutterTts.speak("segnale di stop");
      break;

    case "parking meter":
      flutterTts.speak("parchimetro");
      break;

    case "bench":
      flutterTts.speak("panchina");
      break;

    case "bird":
      flutterTts.speak("uccello");
      break;

    case "cat":
      flutterTts.speak("gatto");
      break;

    case "dog":
      flutterTts.speak("cane");
      break;

    case "horse":
      flutterTts.speak("cavallo");
      break;

    case "sheep":
      flutterTts.speak("pecora");
      break;

    case "cow":
      flutterTts.speak("mucca");
      break;

    case "elephant":
      flutterTts.speak("elefante");
      break;

    case "bear":
      flutterTts.speak("orso");
      break;

    case "giraffe":
      flutterTts.speak("giraffa");
      break;

    case "backpack":
      flutterTts.speak("zaino");
      break;

    case "umbrella":
      flutterTts.speak("ombrello");
      break;

    case "handbag":
      flutterTts.speak("borsetta");
      break;

    case "tie":
      flutterTts.speak("cravatta");
      break;

    case "suitcase":
      flutterTts.speak("valigia");
      break;

    case "skis":
      flutterTts.speak("sci");
      break;

    case "snowboard":
      flutterTts.speak("snowboard");
      break;

    case "sports ball":
      flutterTts.speak("palla");
      break;

    case "kite":
      flutterTts.speak("aquilone");
      break;

    case "baseball bat":
      flutterTts.speak("mazza da baseball");
      break;

    case "baseball glove":
      flutterTts.speak("guantone da baseball");
      break;

    case "skateboard":
      flutterTts.speak("skateboard");
      break;

    case "surfboard":
      flutterTts.speak("tavola da surf");
      break;

    case "tennis racket":
      flutterTts.speak("racchetta da tennis");
      break;

    case "bottle":
      flutterTts.speak("bottiglia");
      break;

    case "wine glass":
      flutterTts.speak("bicchiere di vino");
      break;

    case "cup":
      flutterTts.speak("tazza");
      break;

    case "fork":
      flutterTts.speak("forchetta");
      break;

    case "knife":
      flutterTts.speak("coltello");
      break;

    case "spoon":
      flutterTts.speak("cucchiaio");
      break;

    case "bowl":
      flutterTts.speak("ciotola");
      break;

    case "banana":
      flutterTts.speak("banana");
      break;

    case "apple":
      flutterTts.speak("mela");
      break;

    case "sandwich":
      flutterTts.speak("sandwich");
      break;

    case "orange":
      flutterTts.speak("arancia");
      break;

    case "broccoli":
      flutterTts.speak("broccoli");
      break;

    case "carrot":
      flutterTts.speak("carota");
      break;

    case "hot dog":
      flutterTts.speak("hot dog");
      break;

    case "pizza":
      flutterTts.speak("pizza");
      break;

    case "donut":
      flutterTts.speak("ciambella");
      break;

    case "cake":
      flutterTts.speak("torta");
      break;

    case "chair":
      flutterTts.speak("sedia");
      break;

    case "sofa":
      flutterTts.speak("divano");
      break;

    case "pottedplant":
      flutterTts.speak("piantina");
      break;

    case "bed":
      flutterTts.speak("letto");
      break;

    case "diningtable":
      flutterTts.speak("tavolo");
      break;

    case "toilet":
      flutterTts.speak("bagno");
      break;

    case "tvmonitor":
      flutterTts.speak("tvmonitor");
      break;

    case "laptop":
      flutterTts.speak("laptop");
      break;

    case "remote":
      flutterTts.speak("telecomando");
      break;

    case "keyboard":
      flutterTts.speak("tastiera");
      break;

    case "cell phone":
      flutterTts.speak("cellulare");
      break;

    case "microwave":
      flutterTts.speak("microonde");
      break;

    case "oven":
      flutterTts.speak("forno");
      break;

    case "toaster":
      flutterTts.speak("tostapane");
      break;

    case "sink":
      flutterTts.speak("lavandino");
      break;

    case "refrigerator":
      flutterTts.speak("frigorifero");
      break;

    case "book":
      flutterTts.speak("libro");
      break;

    case "clock":
      flutterTts.speak("orologio");
      break;

    case "vase":
      flutterTts.speak("vaso");
      break;

    case "scissors":
      flutterTts.speak("forbici");
      break;

    case "teddy bear":
      flutterTts.speak("orsacchiotto di peluche");
      break;

    case "hair drier":
      flutterTts.speak("asciugacapelli");
      break;

    case "toothbrush":
      flutterTts.speak("spazzolino");
      break;
  }
}

notifyElement(String element, double confidence) async {
  if (confidence >= 75) {
    //forse è meglio abbassarlo a 50%
    if (dangElements.contains(element)) {
      Vibrate.vibrate();
    }

    if (element != prevNotified) {
      //await flutterTts.awaitSpeakCompletion(true);
      traduciInItaliano(element);
      //flutterTts.speak(element);
      prevNotified = element;
    }
  }
}
