import 'package:flutter/material.dart';

class GestionePreferiti extends StatefulWidget {
  const GestionePreferiti({Key? key}) : super(key: key);

  @override
  State<GestionePreferiti> createState() => _GestionePreferitiState();
}

class _GestionePreferitiState extends State<GestionePreferiti> {
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

