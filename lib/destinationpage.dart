// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class DestinationPage extends StatefulWidget {
  const DestinationPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _DestinationPageState createState() => _DestinationPageState();
}


//means that this class is a subclass which inherits State and is of type <RandomWords> - instead of Generic type T
class _DestinationPageState extends State<DestinationPage> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //wrapped in sub-widget Text
        title: Text(widget.title),
      ),
      body: _buildSuggestions(),
    );
  }

  //builds ListView widget
  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return const Divider(); /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return _buildRow(_suggestions[index]);
        });
  }

  //used to build each row (list tile)
  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),

    );
  }
}

