import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeechInstance {
  static final TextToSpeechInstance _instance =
      TextToSpeechInstance._privateConstructor();

  factory TextToSpeechInstance() {
    return _instance;
  }

  late FlutterTts flutterTts;

  TextToSpeechInstance._privateConstructor() {
    flutterTts = FlutterTts();
    flutterTts.setLanguage("it-IT");
    flutterTts.setVoice({"name": "it-it-x-itd-local", "locale": "it-IT"});
    flutterTts.setQueueMode(1);
  }
}
