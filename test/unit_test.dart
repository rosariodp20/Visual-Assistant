import 'package:flutter_test/flutter_test.dart';
import 'package:visual_assistant/controller/path_controller.dart';

void main() {
  test("Testing della ricerca del percorso", () {
    PathController pathController = PathController.instance;

    Future<void>? future;
    future = pathController.getDirections(41.333333, 14.333333, null, null);

    expect(future.runtimeType, Future<void>);
  });
}
