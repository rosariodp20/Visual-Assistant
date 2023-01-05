import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Visaul Assistant',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        //shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0),),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                        minimumSize: Size(178, 320),
                        side: BorderSide(width: 4.0, color: Color.fromRGBO(0, 0, 0, 1)),
                        primary: Color(0xffca432d),
                      ),
                      onPressed: () { },
                      child: Text('      PARTECIPA     \nAD UNA PARTITA',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'FredokaOne',
                            fontSize: 5,
                            letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.normal,
                            height: 1
                        ),
                      )
                  ),
                  //SizedBox(width: 3),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        //shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0),),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                        minimumSize: Size(178, 320),
                        side: BorderSide(width: 4.0, color: Color.fromRGBO(0, 0, 0, 1)),
                        primary: Color(0xffca432d),
                      ),
                      onPressed: () { },
                      child: Text('      PARTECIPA     \nAD UNA PARTITA',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'FredokaOne',
                            fontSize: 5,
                            letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.normal,
                            height: 1
                        ),
                      )
                  ),

                ],
              ),
              //SizedBox(height: 20),
              Row(
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        //shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0),),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                        minimumSize: Size(178, 320),
                        side: BorderSide(width: 4.0, color: Color.fromRGBO(0, 0, 0, 1)),
                        primary: Color(0xffca432d),
                      ),
                      onPressed: () { },
                      child: Text('      PARTECIPA     \nAD UNA PARTITA',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'FredokaOne',
                            fontSize: 5,
                            letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.normal,
                            height: 1
                        ),
                      )
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        //shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0),),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                        minimumSize: Size(178, 320),
                        side: BorderSide(width: 4.0, color: Color.fromRGBO(0, 0, 0, 1)),
                        primary: Color(0xffca432d),
                      ),
                      onPressed: () { },
                      child: Text('      PARTECIPA     \nAD UNA PARTITA',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'FredokaOne',
                            fontSize: 5,
                            letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
                            fontWeight: FontWeight.normal,
                            height: 1
                        ),
                      )
                  ),

                ],
              ),
            ])
        ),
      );

  }
}
