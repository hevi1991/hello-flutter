import 'package:flutter/material.dart';

class ScrollNotificationListenerPage extends StatelessWidget {
  const ScrollNotificationListenerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('滚动监听'),
      ),
      body: const _ScrollNotificationTest(),
    );
  }
}

class _ScrollNotificationTest extends StatefulWidget {
  const _ScrollNotificationTest({Key? key}) : super(key: key);
  @override
  _ScrollNotificationTestState createState() => _ScrollNotificationTestState();
}

class _ScrollNotificationTestState extends State<_ScrollNotificationTest> {
  String _progress = '0%';

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: NotificationListener(
        onNotification: (ScrollNotification notification) {
          double progress = notification.metrics.pixels /
              notification.metrics.maxScrollExtent;
          setState(() {
            _progress = '${(progress * 100).toInt()}%';
          });
          return false;
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            ListView.builder(
              itemCount: 100,
              itemExtent: 50,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text('$index'),
                );
              },
            ),
            CircleAvatar(
              radius: 30,
              child: Text(_progress),
              backgroundColor: Colors.black54,
            )
          ],
        ),
      ),
    );
  }
}
