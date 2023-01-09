import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';

class ricercaDestinazione extends StatefulWidget {
  const ricercaDestinazione({Key? key}) : super(key: key);

  @override
  State<ricercaDestinazione> createState() => _ricercaDestinazioneState();
}

class _ricercaDestinazioneState extends State<ricercaDestinazione> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _textSpeech = "in attesa dell'indirizzo";

  void onListen() async{
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available){
        setState(() {
          _isListening = true;
        });
        _speech.listen(
          onResult: (val) => setState((){
            _textSpeech = val.recognizedWords;
        })
        );
      }
    }
    else{
      setState(() {
        _isListening = false;
        _speech.stop();
        showDialog(barrierDismissible: false, context: context, builder: (BuildContext context) => _buildPopupDialog(context),);
      });
    }
  }

  void initState(){
    super.initState();
    _speech = stt.SpeechToText();
  }

  Widget _buildPopupDialog(BuildContext context)  {
    FlutterTts flutterTts = FlutterTts();
    flutterTts.setLanguage("it-IT");
    var a = flutterTts.getVoices;
    flutterTts.setVoice({"name":"it-it-x-itd-local","locale":"it-IT"});
    flutterTts.speak("Indica se l'indirizzo " + _textSpeech + " è corretto?");

    return AlertDialog(
      title: const Text(''),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Indica se l'indirizzo " + _textSpeech + " è corretto"),
        ],
      ),
      actions: <Widget>[
        new ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(minimumSize: Size(100, 100),),
          child: const Text('Si'),
        ),
        SizedBox(width: 40,),
        new ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(minimumSize: Size(100, 100),),
          child: const Text('No'),
        ),
      ],
    );
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
                      Text("RICERCA PERCORSO", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                      SizedBox(height: 60),
                      Text(_textSpeech, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                      SizedBox(height: 20),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0),),
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                            minimumSize: Size(300, 400),
                            //side: BorderSide(width: 4.0, color: Color(0xff68240b)),
                            primary: Color.fromRGBO(176, 224, 230, 1),
                          ),
                          onPressed: () => onListen(),
                          child: Text('IMPOSTA DESTINAZIONE',style: TextStyle(color: Colors.black,fontSize: 20,),)
                      ),
                    ]
                )
            )
        )
    );
  }
}
