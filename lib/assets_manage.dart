import 'package:flutter/material.dart';

class AssetsManagePage extends StatelessWidget {
  const AssetsManagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assets Manage'),
      ),
      body: Center(
        child: Column(
          children: [
            DecoratedBox(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/banner001.jpg')),
                ),
                child: Container(
                  height: 300.0,
                )),
            Image.asset('assets/images/banner002.jpg'),
          ],
        ),
      ),
    );
  }
}
