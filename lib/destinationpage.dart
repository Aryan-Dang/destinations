// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'aboutpage.dart';
import 'adddestination.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DestinationPage extends StatefulWidget {
  const DestinationPage({Key? key, required this.title, required this.email}) : super(key: key);
  final String title;
  final String email;

  @override
  _DestinationPageState createState() => _DestinationPageState();
}


//means that this class is a subclass which inherits State and is of type <RandomWords> - instead of Generic type T
class _DestinationPageState extends State<DestinationPage> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  CollectionReference users2 = FirebaseFirestore.instance.collection('users');

  String getMail() => widget.email;

  void _navToAbout() {
    setState(() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
            AboutPage(title: 'About the Destinations App')),
      );
    });
  }

  void _addNewDest() {
    setState(() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
            AddDestPage(title: 'Add New Destination', email: widget.email)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.email).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String,dynamic>;
          print(data);
          var destinationsList = data["Destinations"];
          //return Text("Full Name: ${data['full_name']} ${data['last_name']}");
          return Scaffold(
            appBar: AppBar(
              //wrapped in sub-widget Text
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
            body: () {
              return ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemBuilder: /*1*/ (context, i) {
                    if (i.isOdd) return const Divider();
                    /*2*/

                    final index = i ~/ 2; /*3*/
                    if (index >= destinationsList.length) {
                      return Text('');
                    }
                    return (String pair) {
                      return ListTile(
                        title: Text(
                          pair,
                          style: _biggerFont,
                        ),
                        trailing: Icon(Icons.more_vert
                        ),
                        onTap: () { // NEW lines from here...
                          setState(() {
                            //TODO: navigate to page with stored description
                            //Temporary interactivity: returns to homepage
                            Navigator.pop(context);
                          });
                        },

                      );
                    }(destinationsList[index]);
                  });
            }(),
            floatingActionButton: FloatingActionButton(
              onPressed: _addNewDest,
              tooltip: 'Add New Destination',
              child: Icon(Icons.add),

            ),
          );
        }

        return Text("loading");
      },
    );
  }
}
