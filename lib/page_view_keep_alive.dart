import 'package:flutter/material.dart';
import 'package:hello_flutter/utils.dart';

class PageViewKeepAlivePage extends StatelessWidget {
  const PageViewKeepAlivePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('组件子项缓存'),
      ),
      body: const _PageView(),
    );
  }
}

class _PageView extends StatelessWidget {
  const _PageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[];
    for (var i = 0; i < 5; i++) {
      children.add(_Page(
        child: Text('$i', textScaleFactor: 5),
      ));
    }
    // 使用自制KeepAliveWrapper实现缓存
    children.add(
      ListView.builder(itemBuilder: (_, index) {
        return KeepAliveWrapper(
          // 为 true 后会缓存所有的列表项，列表项将不会销毁。
          // 为 false 时，列表项滑出预加载区域后将会别销毁。
          // 使用时一定要注意是否必要，因为对所有列表项都缓存的会导致更多的内存消耗
          keepAlive: index < 100, // 试验，大于100之后不缓存
          child: ListItem(index: index),
        );
      }),
    );

    return PageView(
      // scrollDirection: Axis.vertical,
      allowImplicitScrolling: true, // 缓存当前页和前后一页数据
      children: children,
    );
  }
}

class _Page extends StatefulWidget {
  const _Page({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<_Page> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context); // 必须调用
    debugPrint('build ${widget.child}');
    return Center(
      child: widget.child,
    );
  }

  @override
  bool get wantKeepAlive => true; // 是否需要缓存
}

class ListItem extends StatefulWidget {
  const ListItem({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text('${widget.index}'));
  }

  @override
  void dispose() {
    debugPrint('dispose ${widget.index}');
    super.dispose();
  }
}
