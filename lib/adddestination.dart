import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'aboutpage.dart';
import 'destinationpage.dart';

class AddDestPage extends StatefulWidget {
  AddDestPage({Key? key, required this.title, required this.email}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final String email;

  @override
  _AddDestPageState createState() => _AddDestPageState();
}

class _AddDestPageState extends State<AddDestPage> {

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> updateUser(String newDestination, String newDesc) {
    return users
        .doc(widget.email)
        .update({'Destinations': FieldValue.arrayUnion([{'name': newDestination, 'description': newDesc}])})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  var destTitleController = TextEditingController();
  var destDetailsController = TextEditingController();
  void _submitInfo() {
    setState(() {
      //TODO: decide if need details from user
      updateUser(destTitleController.text, destDetailsController.text);

      //Return to previous destination list page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
            DestinationPage(title: 'Saved Destinations', email: widget.email)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    void _navToAbout() {
      setState(() {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AboutPage(title: 'About the Destinations App')),
        );
      });
    }
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.info,
                color: Colors.white,
              ),
              onPressed: _navToAbout,
            )
          ]
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
                      obscureText: false,
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
