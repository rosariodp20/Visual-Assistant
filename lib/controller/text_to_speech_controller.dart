import 'package:flutter_tts/flutter_tts.dart';
import 'package:visual_assistant/utils/text_to_speech_instance.dart';

class TextToSpeechController {
  TextToSpeechController._privateConstructor();

  static final TextToSpeechController instance =
      TextToSpeechController._privateConstructor();

  final FlutterTts _textToSpeech = TextToSpeechInstance().flutterTts;

  void speak(String text) {
    _textToSpeech.speak(text);
  }
}
