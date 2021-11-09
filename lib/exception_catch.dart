import 'dart:async';

import 'package:flutter/material.dart';

class ExceptionCatchPage extends StatelessWidget {
  const ExceptionCatchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // this page error catch
    FlutterError.onError = (details) {
      debugPrint(details.exception.toString());
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('ExceptionCatch'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return Scaffold(
                      appBar: AppBar(title: const Text('Make A Error')),
                      body: ErrorWidget.builder(const FlutterErrorDetails(
                          exception: 'Custom exception')),
                    );
                  }));
                },
                child: const Text("Make A Error Page")),
            ElevatedButton(
                onPressed: () {
                  // check FlutterError.onError
                  FlutterError.reportError(FlutterErrorDetails(
                      exception: "Make A Error test catch. " +
                          DateTime.now().toString()));
                },
                child: const Text('Make A Error')),
            ElevatedButton(
                onPressed: () async {
                  try {
                    await Future.delayed(const Duration(seconds: 1))
                        .then((value) => Future.error("A Delayed Error"));
                  } catch (e) {
                    debugPrint(e.toString());
                  }
                },
                child: const Text('Make A Async Error')),
          ],
        ),
      ),
    );
  }
}
