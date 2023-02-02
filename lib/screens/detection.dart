import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';
import 'dart:math' as math;
import './camera.dart';
import '../widgets/detection_area.dart';
import '../models/models.dart';

class Detection extends StatefulWidget {
  final List<CameraDescription> cameras;

  const Detection(this.cameras, {Key? key}) : super(key: key);

  @override
  _DetectionState createState() => _DetectionState();
}

class _DetectionState extends State<Detection> {
  List<dynamic> _recognitions = <dynamic>[];
  int _imageHeight = 0;
  int _imageWidth = 0;
  final String _model = yolo;

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/yolov2_tiny.tflite",
      labels: "assets/yolov2_tiny.txt",
    );
  }

  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Camera(
            widget.cameras,
            _model,
            setRecognitions,
          ),
          DetectionArea(
              _recognitions,
              math.max(_imageHeight, _imageWidth),
              math.min(_imageHeight, _imageWidth),
              screen.height,
              screen.width,
              _model),
        ],
      ),
    );
  }
}
