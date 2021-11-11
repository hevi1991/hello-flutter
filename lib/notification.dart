import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  var items = <String>[];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 100; i++) {
      items.add(i.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('通知'),
      ),
      body: NotificationListener(
        onNotification: (notification) {
          // 外层NotificationListener验证是否内层通知被阻止
          if (notification is MyNotification) {
            debugPrint('Outside: ${notification.msg} ${notification.index}');
          }
          return false; // 不阻止它的上层通知冒泡
        },
        child: NotificationListener(
          onNotification: (notification) {
            switch (notification.runtimeType) {
              case ScrollStartNotification:
                debugPrint("开始滚动");
                break;
              case ScrollUpdateNotification:
                debugPrint("正在滚动");
                break;
              case ScrollEndNotification:
                debugPrint("滚动停止");
                break;
              case OverscrollNotification:
                debugPrint("滚动到边界");
                break;
              case MyNotification:
                notification as MyNotification;
                var msg = notification.msg;
                var index = notification.index;
                debugPrint('Inside: $msg $index');
                setState(() {
                  items[index] += ' $msg';
                });
                break;
            }
            return true; // true 阻止向上冒泡
          },
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(items[index]),
                trailing: const Icon(Icons.add_outlined),
                onTap: () {
                  MyNotification('msg', index).dispatch(context);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

/// 自定义通知
class MyNotification extends Notification {
  MyNotification(this.msg, this.index);
  final String msg;
  final int index;
}
