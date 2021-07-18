// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'aboutpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DestDetails extends StatefulWidget {

  const DestDetails({Key? key, required this.title, required this.email, required this.name, required this.description}) : super(key: key);
  final String title;
  final String email;
  final String name;
  final String description;

  @override
  _DestDetailsState createState() => _DestDetailsState();
}


//means that this class is a subclass which inherits State and is of type <RandomWords> - instead of Generic type T
class _DestDetailsState extends State<DestDetails> {

  CollectionReference users2 = FirebaseFirestore.instance.collection('users');

  String getMail() => widget.email;


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
      body: Column(
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              flex: 22,
              child:Image(
                  image: NetworkImage('https://p0.pxfuel.com/preview/440/255/773/travel-car-cars-hd-wallpaper.jpg') )
          ),

          Expanded(
            flex: 11,
            child: Container(
              margin: const EdgeInsets.all(30),
              child: Text(
                  widget.name,
                  style: TextStyle(
                    fontSize: 35.0,
                    color: Colors.blue,
                  )
              ),
            ),
          ),
          Expanded(
            flex: 30,
            child: Container(
              margin: const EdgeInsets.all(30),
              child: Text(
                  widget.description,
                  style: TextStyle(
                    fontSize: 20.0,
                  )
              ),
            ),
          ),
        ],
      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
