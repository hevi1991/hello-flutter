import 'package:flutter/material.dart';

class EchoPage extends StatelessWidget {
  final Color backgroundColor;
  final String text;

  const EchoPage(
      {Key? key, required this.text, this.backgroundColor = Colors.green})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Echo'),
        ),
        body: Center(
          child: Container(
            color: backgroundColor,
            child: Text(text),
          ),
        ));
  }
}
