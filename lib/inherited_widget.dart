import 'package:flutter/material.dart';

class InheritedWidgetPage extends StatelessWidget {
  const InheritedWidgetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('数据共享 InheritedWidget'),
      ),
      body: const _CounterWidget(),
    );
  }
}

/// 共享状态组件
class ShareDataWidget extends InheritedWidget {
  const ShareDataWidget({Key? key, required Widget child, required this.data})
      : super(key: key, child: child);

  final int data;

  static ShareDataWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ShareDataWidget>();
  }

  @override
  bool updateShouldNotify(ShareDataWidget oldWidget) {
    // 通知需要更新
    return oldWidget.data != data;
  }
}

class _CounterWidget extends StatefulWidget {
  const _CounterWidget({Key? key}) : super(key: key);

  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<_CounterWidget> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return ShareDataWidget(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const _CounterShowWidget(),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  count++;
                });
              },
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
      data: count,
    );
  }
}

class _CounterShowWidget extends StatefulWidget {
  const _CounterShowWidget({Key? key}) : super(key: key);

  @override
  State<_CounterShowWidget> createState() => _CounterShowWidgetState();
}

class _CounterShowWidgetState extends State<_CounterShowWidget> {
  @override
  Widget build(BuildContext context) {
    var data = ShareDataWidget.of(context)!.data.toString();
    return Text(
      data,
      textScaleFactor: 5,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint('didChangeDependencies execute');
  }
}
