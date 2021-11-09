import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';

class DebugPage extends StatefulWidget {
  const DebugPage({Key? key}) : super(key: key);

  @override
  State<DebugPage> createState() => _DebugPageState();
}

class _DebugPageState extends State<DebugPage> {
  int number = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Debug'),
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(0, 100, 0, 0),
        alignment: Alignment.center,
        child: Column(
          children: [
            Text(number.toString(),
                style: Theme.of(context).textTheme.headline1),
            const Text('当随机数大于5的时候，触发断点调试；大于8的时候断言'),
            ElevatedButton(
                onPressed: () {
                  var nextInt = Random().nextInt(10);
                  debugPrint(nextInt.toString());
                  debugger(
                      when: nextInt < 3, message: '$nextInt is less than 3');
                  assert(nextInt <= 8, '$nextInt is over 8!');
                  setState(() {
                    number = nextInt;
                  });
                },
                child: const Text('Get random number')),
            const Divider(),
            ElevatedButton(
                onPressed: () {
                  debugDumpApp();
                },
                child: const Text('设备信息 debugDumpApp')),
            ElevatedButton(
                onPressed: () {
                  debugDumpRenderTree();
                },
                child: const Text('渲染树 debugDumpRenderTree')),
            ElevatedButton(
                onPressed: () {
                  debugDumpLayerTree();
                },
                child: const Text('层级树 debugDumpLayerTree')),
          ],
        ),
      ),
    );
  }
}
