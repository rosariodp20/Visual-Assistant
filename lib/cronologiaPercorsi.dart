import 'package:flutter/material.dart';

class cronologiaPercorsi extends StatefulWidget {
  const cronologiaPercorsi({Key? key}) : super(key: key);

  @override
  State<cronologiaPercorsi> createState() => _cronologiaPercorsiState();
}

class _cronologiaPercorsiState extends State<cronologiaPercorsi> {
  int col1=255;
  int col2=255;
  int col3=255;

  void aggiungiPreferiti(){
    if(col1==255) {
      setState(() {
        col1 = 228;
        col2 = 182;
        col3 = 52;
      });

    }
    else{
      setState(() {
        col1=255;
        col2=255;
        col3=255;
      });

    }
    print('a');
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
                      Text("CRONOLOGIA PERCORSI", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                      SizedBox(height: 30,),
                      Row(
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                //shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(40.0),),
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                                minimumSize: Size(230, 50),
                                //side: BorderSide(width: 4.0, color: Color(0xff68240b)),
                                primary: Color.fromRGBO(176, 224, 230, 1),
                              ),
                              onPressed: () {},
                              child: Text('IMPOSTA DESTINAZIONE',style: TextStyle(color: Colors.black,fontSize: 10,),)
                          ),
                          ElevatedButton.icon(
                              onPressed: () {aggiungiPreferiti();},
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(20, 50),
                                primary: Color.fromRGBO(176, 224, 230, 1),
                                padding:EdgeInsets.only(left: 17,right: 10),
                              ),
                              icon: Icon(Icons.star, color: Color.fromRGBO(col1, col2, col3, 1),),                             //Icon(Icons.star),
                              label: Text(""),
                          )
                        ],
                      )
                    ]
                )
            )
        )
    );
  }
}

