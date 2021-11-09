import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({Key? key}) : super(key: key);

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  double _value = 0;
  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    var linearProgressIndicator = LinearProgressIndicator(
      backgroundColor: Colors.grey[200],
      valueColor: const AlwaysStoppedAnimation(Colors.blue),
      value: _value,
    );

    var circularProgressIndicator = CircularProgressIndicator(
      backgroundColor: Colors.grey[200],
      valueColor: const AlwaysStoppedAnimation(Colors.blue),
      value: _value,
    );

    return Scaffold(
        appBar: AppBar(
          title: const Text('Progress'),
        ),
        body: Column(
          children: [
            const Text('线性进度'),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: linearProgressIndicator,
            ),
            const Text('圆形进度'),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: circularProgressIndicator,
            ),
          ],
        ),
        floatingActionButton: Visibility(
          visible: _value < 1,
          child: FloatingActionButton(
            backgroundColor: _timer == null ? Colors.blue : Colors.red,
            child: _timer == null
                ? const Icon(Icons.play_arrow)
                : const Icon(Icons.pause),
            onPressed: () {
              if (_timer == null) {
                setState(() {
                  _timer = Timer.periodic(const Duration(milliseconds: 200),
                      (timer) {
                    if (_value < 1) {
                      setState(() {
                        _value += Random().nextDouble() / 10;
                      });
                    } else {
                      timer.cancel();
                      setState(() {
                        _timer = null;
                      });
                    }
                  });
                });
              } else {
                _timer!.cancel();
                setState(() {
                  _timer = null;
                });
              }
            },
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }
}
