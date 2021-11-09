import 'package:flutter/material.dart';

class ContainerPage extends StatelessWidget {
  const ContainerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Container'),
      ),
      body: Column(
        children: const [
          _Container(),
        ],
      ),
    );
  }
}

class _Container extends StatelessWidget {
  const _Container({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50, left: 120),
      constraints: const BoxConstraints.tightFor(width: 200, height: 150),
      decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [Colors.orangeAccent, Colors.redAccent],
            center: Alignment.topRight,
            radius: .98,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              offset: Offset(2.0, 2.0),
              blurRadius: 4.0,
            )
          ]),
      transform: Matrix4.rotationZ(.2),
      alignment: Alignment.center,
      child: const Text(
        '9527',
        style: TextStyle(color: Colors.white, fontSize: 40.0),
      ),
    );
  }
}
