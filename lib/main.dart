import 'package:flutter/material.dart';
import 'package:visual_assistant/cronologiaPercorsi.dart';
import 'package:visual_assistant/gestionePreferiti.dart';
import 'package:visual_assistant/ricercaDestinazione.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Visual Assistant',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFF0d7c97)
      ),
      home: const MyHomePage(title: 'Visual Assistant'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(2),
        child:
          Column (
            children: [
              Row(
                children: [
                  SizedBox(width: 3),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>gestionePreferiti()));
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Ink.image(
                          image: AssetImage('assets/stella.png'),
                          height: 320,
                          width: 170,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8),
                  InkWell(
                    onTap: () {},
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Ink.image(
                          image: AssetImage('assets/fotocamera.png'),
                          height: 320,
                          width: 170,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),

                ],
              ),
              Row(
                  children: [
                    SizedBox(height: 10),
                  ],
              ),
              //SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(width: 3),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>cronologiaPercorsi()));
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Ink.image(
                          image: AssetImage('assets/cronologia.png'),
                          height: 320,
                          width: 170,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ricercaDestinazione()));
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Ink.image(
                          image: AssetImage('assets/lenteDiIngrandimento.png'),
                          height: 320,
                          width: 170,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ])
        ),
      );

  }
}
