import 'package:flutter/material.dart';

class AnimatedListPage extends StatefulWidget {
  const AnimatedListPage({Key? key}) : super(key: key);

  @override
  State<AnimatedListPage> createState() => _AnimatedListPageState();
}

class _AnimatedListPageState extends State<AnimatedListPage> {
  final _data = <String>[];
  int _counter = 5;

  final globalKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    for (var i = 0; i < _counter; i++) {
      _data.add('${i + 1}');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('动效列表视图'),
      ),
      body: Stack(
        children: [
          AnimatedList(
            key: globalKey,
            initialItemCount: _data.length,
            itemBuilder:
                (BuildContext context, int index, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: _buildItem(context, index),
              );
            },
          ),
          Positioned(
            child: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                _data.add('${++_counter}');
                globalKey.currentState!.insertItem(_data.length - 1);
                debugPrint('添加 $_counter');
              },
            ),
            bottom: 30,
            left: 0,
            right: 0,
          )
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    var char = _data[index];
    return ListTile(
      key: ValueKey(char), // 唯一
      title: Text(char),
      trailing: IconButton(
          onPressed: () {
            _onDelete(context, index);
          },
          icon: const Icon(Icons.delete)),
    );
  }

  _onDelete(BuildContext context, int index) {
    setState(() {
      globalKey.currentState!.removeItem(
        index,
        (context, animation) {
          // 删除过程执行的是反向动画，animation.value 会从1变为0
          var item = _buildItem(context, index);
          debugPrint('删除 ${_data[index]}');
          _data.removeAt(index);
          // 删除动画是一个合成动画：渐隐 + 缩小列表项告诉
          return FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              //让透明度变化的更快一些
              curve: const Interval(0.5, 1.0),
            ),
            // 不断缩小列表项的高度
            child: SizeTransition(
              sizeFactor: animation,
              axisAlignment: 0.0,
              child: item,
            ),
          );
        },
        duration: const Duration(milliseconds: 200), // 动画时间为 200 ms
      );
    });
  }
}
