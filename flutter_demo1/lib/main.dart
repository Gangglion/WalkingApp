// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore: import_of_legacy_library_into_null_safe
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //final wordPair = WordPair.random();
    return MaterialApp(
      // title: 'Welcome to Flutter',
      // home: Scaffold(
      //   appBar: AppBar(
      //     title: const Text('Welcome to Flutter'),
      //   ),
      //   body: Center(
      //     // child: Text('Hello World'),
      //     //child: Text(wordPair.asPascalCase),
      //     child: RandomWords(),
      //   ),
      // ),
      title: 'Startup Name Generator',
      home: RandomWords(),
    );
  }
}

//최소한의 상태를 가지는 클래스 - State클래스 사용 <제네릭> -> 앱 로직과 상태 유지
class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 25.0);

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) {
            return Divider();
          }
          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // final wordPair = WordPair.random();
    // return Text(wordPair.asPascalCase);
    // throw UnimplementedError();

    //scaffold는 기본적인 material 디자인 시각 레이아웃 구현
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
      ),
      body: _buildSuggestions(),
    );
  }
  // build() 메서드 추가 필요

}

class RandomWords extends StatefulWidget {
  RandomWordsState createState() => RandomWordsState();
}
