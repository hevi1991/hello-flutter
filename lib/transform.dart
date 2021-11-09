import 'dart:math';
import 'package:flutter/material.dart';

class TransformPage extends StatelessWidget {
  const TransformPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('变换'),
      ),
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            _Skew(),
            _Translate(),
            _Rotate(),
            _Scale(),
            _RotatedBox(),
          ],
        ),
      ),
    );
  }
}

class _Skew extends StatelessWidget {
  const _Skew({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 30.0),
      color: Colors.black,
      child: Transform(
        alignment: Alignment.topRight,
        transform: Matrix4.skewY(0.3),
        child: Container(
          padding: const EdgeInsets.all(10),
          color: Colors.deepOrange,
          child: const Text('Apartment for rent'),
        ),
      ),
    );
  }
}

class _Translate extends StatelessWidget {
  const _Translate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 30.0),
      color: Colors.black,
      child: Transform.translate(
        offset: const Offset(-10.0, -10.0),
        child: Container(
          padding: const EdgeInsets.all(10),
          color: Colors.deepOrange,
          child: const Text('Apartment for rent'),
        ),
      ),
    );
  }
}

class _Rotate extends StatelessWidget {
  const _Rotate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 30.0),
      color: Colors.black,
      child: Transform.rotate(
        angle: pi / 2,
        child: Container(
          padding: const EdgeInsets.all(10),
          color: Colors.deepOrange,
          child: const Text('Apartment for rent'),
        ),
      ),
    );
  }
}

class _Scale extends StatelessWidget {
  const _Scale({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 30.0),
      color: Colors.blue[50],
      child: Transform.scale(
        scale: 2,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: const Text('Apartment for rent'),
        ),
      ),
    );
  }
}

class _RotatedBox extends StatelessWidget {
  const _RotatedBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 30.0),
      color: Colors.black,
      child: RotatedBox(
        quarterTurns: 1,
        child: Container(
          padding: const EdgeInsets.all(10),
          color: Colors.deepOrange,
          child: const Text('Apartment for rent'),
        ),
      ),
    );
  }
}
