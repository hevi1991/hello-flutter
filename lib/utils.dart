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
