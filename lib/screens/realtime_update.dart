import 'package:flutter/material.dart';
import 'dart:async';
import 'package:camera/camera.dart';
import 'package:visual_assistant/controller/realtime_update_controller.dart';
import '../screens/detection.dart';
import '../widgets/appbar.dart';
import '../utils/available_cameras.dart';

class Path extends StatefulWidget {
  final double? latitudineOri, longitudineOri; //coordinate origine
  final double? latitudineDest, longitudineDest; //coordinate destinazione
  final List<CameraDescription> cameras;

  const Path(this.cameras,
      {Key? key,
      required this.latitudineOri,
      required this.longitudineOri,
      required this.latitudineDest,
      required this.longitudineDest})
      : super(key: key);

  @override
  State<Path> createState() => PathState();
}

@visibleForTesting
class PathState extends State<Path> {
  PathController pathController = PathController.instance;

  @override
  void initState() {
    super.initState();

    pathController.latOrigine = widget.latitudineOri;
    pathController.longOrigine = widget.longitudineOri;
    pathController.latDestinazione = widget.latitudineDest;
    pathController.longDestinazione = widget.longitudineDest;

    print(
        "Passata latitudine Origine PRIME MOMENT $pathController.latOrigine ");
    print(
        "Passata longitudine Origine PRIME MOMENT $pathController.longOrigine");
    print(
        "Passata latitudine Destinazione PRIME MOMENT $pathController.latDestinazione");
    print(
        "Passata longitudine Destinazione PRIME MOMENT $pathController.longDestinazione");

    //bisogna settare i flag a true per aggiornare tutte le indicazioni del percorso
    pathController.flag = true;
    pathController.flag2 = true;
    pathController.flag3 = true;

    //abbiamo messo questi metodi in initState() perchè se messi nel build si ripeteva all'infinito
    pathController.getCurrentLocation();
    Future.delayed(const Duration(seconds: 40), () {
      if (pathController.flag == true) {
        pathController.getCondizioniMeteo();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: CustomAppBar(onBackPressed: () {
          //settando il flag a false il sistema non fornirà più indicazioni quando si esce dalla pagina
          pathController.flag = false;
          Navigator.of(context)
              .pop(); //si torna nella pagina di prima -> ricercaDestinazione
        }),
        body: Detection(cameras),
      ),
    );
  }
}
