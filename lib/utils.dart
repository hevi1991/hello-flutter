import 'package:flutter/material.dart';

class MyUtils {
  /// 快速生成Route并跳转
  static createRouteAndPush({
    required BuildContext context,
    required Widget widget,
    String title = '',
  }) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: Column(children: [
            Expanded(
              child: widget,
            ),
          ]),
        );
      }),
    );
  }
}

/// 封装外部用缓存组件，为了让组件不需要自己实现AutomaticKeepAliveClientMixin混入
class KeepAliveWrapper extends StatefulWidget {
  const KeepAliveWrapper({
    Key? key,
    this.keepAlive = true,
    required this.child,
  }) : super(key: key);
  final bool keepAlive;
  final Widget child;

  @override
  _KeepAliveWrapperState createState() => _KeepAliveWrapperState();
}

class _KeepAliveWrapperState extends State<KeepAliveWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  void didUpdateWidget(covariant KeepAliveWrapper oldWidget) {
    if (oldWidget.keepAlive != widget.keepAlive) {
      // keepAlive 状态需要更新，实现在 AutomaticKeepAliveClientMixin 中
      updateKeepAlive();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  bool get wantKeepAlive => widget.keepAlive;
}

/// 快速创建一个Sliver列表
Widget buildSliverList([int length = 10]) {
  return SliverFixedExtentList(
    itemExtent: 50,
    delegate: SliverChildBuilderDelegate(
      (BuildContext context, int index) {
        return ListTile(title: Text('$index'));
      },
      childCount: length,
    ),
  );
}

/// 事件总线回调
// ignore: prefer_generic_function_type_aliases
typedef void EventCallback(arg);

/// 事件总线（1，2，3是dart单例写法）
class EventBus {
  /// 私有化构造函数 1
  EventBus._internal();

  /// 保存单例 2
  static final EventBus _singleton = EventBus._internal();

  /// 工厂构造函数 3
  factory EventBus() => _singleton;

  /// 保存事件订阅者队列。
  /// key事件名，value对应事件订阅者回调队列
  final _emap = <Object, List<EventCallback>?>{};

  /// 添加订阅者
  void on(eventName, EventCallback f) {
    _emap[eventName] ??= []; // 语法糖，如果不存在就赋值
    _emap[eventName]!.add(f); // 语法糖，空值检查，如果为空报错
  }

  /// 移出订阅者
  /// f 可选参数
  void off(eventName, [EventCallback? f]) {
    var list = _emap[eventName];
    if (eventName == null || list == null) {
      return;
    }

    if (f == null) {
      _emap[eventName] = null;
    } else {
      list.remove(f);
    }
  }

  /// 触发事件
  void emit(eventName, [arg]) {
    var list = _emap[eventName];
    if (list == null) {
      return;
    }
    // 反向遍历，防止订阅者在回调中移出自身导致下标越界
    int len = list.length - 1;
    for (var i = len; i > -1; i--) {
      list[i](arg);
    }
  }
}

/// 全局变量，事件总线
var eventBus = EventBus();
