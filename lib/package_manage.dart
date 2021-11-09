import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class PackageManagePage extends StatelessWidget {
  const PackageManagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Third Package'),
      ),
      body: Center(
        child: _RandomWordsWidget(),
      ),
    );
  }
}

class _RandomWordsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var wordPair = WordPair.random();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(wordPair.toString()),
    );
  }
}
