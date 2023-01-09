import 'package:flutter/material.dart';

class gestionePreferiti extends StatefulWidget {
  const gestionePreferiti({Key? key}) : super(key: key);

  @override
  State<gestionePreferiti> createState() => _gestionePreferitiState();
}

class _gestionePreferitiState extends State<gestionePreferiti> {
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
                  Text("PERCORSI PREFERITI", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                ]
            )
          )
        )
    );
  }
}

