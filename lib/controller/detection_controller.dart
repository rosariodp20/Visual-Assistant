import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';
import '../models/models.dart';

class DetectionController {
  DetectionController._privateConstructor();

  static final DetectionController instance =
      DetectionController._privateConstructor();

  void loadModel(
      {required String pathToModel, required String pathToLabels}) async {
    await Tflite.loadModel(model: pathToModel, labels: pathToLabels);
  }

  Future<List<dynamic>?> detectFromCamera(CameraImage img) {
    final detections = Tflite.detectObjectOnFrame(
      bytesList: img.planes.map((plane) {
        return plane.bytes;
      }).toList(),
      model: yolo,
      imageHeight: img.height,
      imageWidth: img.width,
      imageMean: 0,
      imageStd: 255.0,
      numResultsPerClass: 1,
      threshold: 0.2,
    );

    return detections;
  }
}
