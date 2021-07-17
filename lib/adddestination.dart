import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddDestPage extends StatefulWidget {
  AddDestPage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _AddDestPageState createState() => _AddDestPageState();
}

class _AddDestPageState extends State<AddDestPage> {
  var destTitleController = TextEditingController();
  var destDetailsController = TextEditingController();
  void _submitInfo() {
    setState(() {
      //TODO: store info from controllers

      //Return to previous destination list page
      Navigator.pop(context);
    });
  }

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
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Container(
              margin: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Column(
                children: [
                  Text(
                    'Enter your new destination info below:',
                      style: TextStyle(
                        fontSize: 20.0,
                      )
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 20.0, bottom: 5),
                    child: TextField(
                      controller: destTitleController,
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Title',
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5, bottom: 20.0),
                    child: TextField(
                      controller: destDetailsController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Details',
                      ),
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _submitInfo,
        tooltip: 'Done',
        child: Icon(Icons.check),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
