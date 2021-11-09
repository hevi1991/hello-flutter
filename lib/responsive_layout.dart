import 'package:flutter/material.dart';

class ResponsiveLayoutPage extends StatelessWidget {
  const ResponsiveLayoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _children = List.filled(6, const Text("A"));

    return Scaffold(
      appBar: AppBar(
        title: const Text('响应式布局实现'),
      ),
      body: Column(
        children: [
          // 限制宽度为190，小于 200
          SizedBox(width: 190, child: _ResponsiveColumn(children: _children)),
          _ResponsiveColumn(children: _children),
          const LayoutLogPrint(child: Text("xx")), // 为了验证父节点约束信息
        ],
      ),
    );
  }
}

class _ResponsiveColumn extends StatelessWidget {
  const _ResponsiveColumn({Key? key, required this.children}) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < 200) {
          // 如果父节点最大宽度小于200，则显示一列
          return Column(
            children: children,
            mainAxisSize: MainAxisSize.min,
          );
        } else {
          // 大于200显示双列
          var _children = <Widget>[];
          for (var i = 0; i < children.length; i += 2) {
            if (i + 1 < children.length) {
              _children.add(
                Row(
                  children: [children[i], children[i + 1]],
                  mainAxisSize: MainAxisSize.min,
                ),
              );
            } else {
              _children.add(children[i]);
            }
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: _children,
          );
        }
      },
    );
  }
}

class LayoutLogPrint<T> extends StatelessWidget {
  const LayoutLogPrint({
    Key? key,
    this.tag,
    required this.child,
  }) : super(key: key);

  final Widget child;
  final T? tag; //指定日志tag

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      // assert在编译release版本时会被去除
      assert(() {
        debugPrint('${tag ?? key ?? child}: $constraints');
        return true;
      }());
      return child;
    });
  }
}
