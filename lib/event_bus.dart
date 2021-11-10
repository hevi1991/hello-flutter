import 'package:flutter/material.dart';
import 'package:hello_flutter/utils.dart';

class EventBusPage extends StatefulWidget {
  const EventBusPage({Key? key}) : super(key: key);

  @override
  State<EventBusPage> createState() => _EventBusPageState();
}

class _EventBusPageState extends State<EventBusPage> {
  int _count = 0;

  @override
  void initState() {
    super.initState();
    eventBus.on('add', _eventHandler);
  }

  /// 事件处理
  void _eventHandler(arg) {
    setState(() {
      _count += arg as int;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('事件总线'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('title $_count'),
            ElevatedButton(
              onPressed: () {
                MyUtils.createRouteAndPush(
                    context: context, widget: const _BusTest());
              },
              child: const Text('push page'),
            ),
            const Divider(),
            const Text('subscribe'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () {
                    eventBus.on('add', _eventHandler);
                  },
                  child: const Text('on'),
                ),
                OutlinedButton(
                  onPressed: () {
                    eventBus.off('add', _eventHandler);
                  },
                  child: const Text('off'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _BusTest extends StatelessWidget {
  const _BusTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: () {
            eventBus.emit('add', 1);
          },
          child: const Icon(Icons.add)),
    );
  }
}
