import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  AboutPage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.





    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Column(
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 38,
            child:Image(
              image: NetworkImage('https://www.maxpixel.net/static/photo/1x/Plane-Soft-Travel-White-Airplane-Flight-Blue-Sky-4125770.jpg')
            )
          ),

          Expanded(
            flex: 61,
            child: Container(
              margin: const EdgeInsets.all(30),
              child: Text(
                          'Love to travel? Destinations is a hub for all your favorite (or prospective favorite) locations and places to go! Just create with an account, log in, and click the plus icon on the Saved Destinations to add a new destination.',
                          style: TextStyle(
                            fontSize: 20.0,
                          )
          ),
            ),
          ),
          Expanded(
              flex: 10,
              child: Text('Vivien Jamba, Aryan Dang             July 2021',
                  style: TextStyle(
                    fontSize: 15.0,
                  )
              ),
            ),
        ],
      ),
     );
  }
}
