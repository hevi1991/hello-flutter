import 'package:flutter/material.dart';

class ValueListenableBuilderPage extends StatelessWidget {
  const ValueListenableBuilderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ValueNotifier<int> _counter = ValueNotifier<int>(0);
    double textScaleFactor = 1.5;
    return StatefulBuilder(
      builder: (BuildContext context, setState) {
        debugPrint('build');
        return Scaffold(
          appBar: AppBar(
            title: const Text('任意流向的数据共享'),
          ),
          body: Center(
            child: ValueListenableBuilder<int>(
              valueListenable: _counter, // 监听_counter变化，一变化就会重新执行builder
              child: Text(
                //如果指定了child，则builder中的child就是这个
                '点击了 ',
                textScaleFactor: textScaleFactor,
              ),
              builder: (BuildContext context, int value, Widget? child) {
                debugPrint('build with builder');
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    child!,
                    Text(
                      '$value 次',
                      textScaleFactor: textScaleFactor,
                    )
                  ],
                );
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _counter.value++;
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
