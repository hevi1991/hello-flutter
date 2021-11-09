import 'package:flutter/material.dart';
import 'package:hello_flutter/utils.dart';

class GridViewPage extends StatelessWidget {
  const GridViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('网格视图'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('GridView.count'),
            trailing: const Icon(Icons.arrow_right_outlined),
            onTap: () {
              MyUtils.createRouteAndPush(
                title: 'GridView.count',
                context: context,
                widget: GridView.count(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  children: const <Widget>[
                    Icon(Icons.ac_unit),
                    Icon(Icons.airport_shuttle),
                    Icon(Icons.all_inclusive),
                    Icon(Icons.beach_access),
                    Icon(Icons.cake),
                    Icon(Icons.free_breakfast),
                  ],
                ),
              );
            },
          ),
          ListTile(
            title: const Text('gridDelegate实现count效果'),
            subtitle: const Text('SliverGridDelegateWithFixedCrossAxisCount'),
            trailing: const Icon(Icons.arrow_right_outlined),
            onTap: () {
              MyUtils.createRouteAndPush(
                title: 'gridDelegate实现count效果',
                context: context,
                widget: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1.0, crossAxisCount: 3, // 子项宽高比
                  ),
                  children: const <Widget>[
                    Icon(Icons.ac_unit),
                    Icon(Icons.airport_shuttle),
                    Icon(Icons.all_inclusive),
                    Icon(Icons.beach_access),
                    Icon(Icons.cake),
                    Icon(Icons.free_breakfast),
                  ],
                ),
              );
            },
          ),
          ListTile(
            title: const Text('GridView.extent'),
            trailing: const Icon(Icons.arrow_right_outlined),
            onTap: () {
              MyUtils.createRouteAndPush(
                  context: context,
                  widget: GridView.extent(
                    maxCrossAxisExtent: 120,
                    childAspectRatio: 2.0,
                    children: const <Widget>[
                      Icon(Icons.ac_unit),
                      Icon(Icons.airport_shuttle),
                      Icon(Icons.all_inclusive),
                      Icon(Icons.beach_access),
                      Icon(Icons.cake),
                      Icon(Icons.free_breakfast),
                    ],
                  ),
                  title: 'GridView.extent');
            },
          ),
          ListTile(
            title: const Text('gridDelegate实现extent效果'),
            subtitle: const Text('SliverGridDelegateWithMaxCrossAxisExtent'),
            trailing: const Icon(Icons.arrow_right_outlined),
            onTap: () {
              MyUtils.createRouteAndPush(
                title: 'gridDelegate',
                context: context,
                widget: GridView(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 120, // 最大横轴宽度
                    childAspectRatio: 2.0, // 子项宽高比
                  ),
                  children: const <Widget>[
                    Icon(Icons.ac_unit),
                    Icon(Icons.airport_shuttle),
                    Icon(Icons.all_inclusive),
                    Icon(Icons.beach_access),
                    Icon(Icons.cake),
                    Icon(Icons.free_breakfast),
                  ],
                ),
              );
            },
          ),
          ListTile(
            title: const Text('GridView.builder'),
            trailing: const Icon(Icons.arrow_right_outlined),
            onTap: () {
              MyUtils.createRouteAndPush(
                  context: context,
                  widget: const InfiniteGridView(),
                  title: 'GridView.builder');
            },
          ),
        ],
      ),
    );
  }
}

class InfiniteGridView extends StatefulWidget {
  const InfiniteGridView({Key? key}) : super(key: key);

  @override
  _InfiniteGridViewState createState() => _InfiniteGridViewState();
}

class _InfiniteGridViewState extends State<InfiniteGridView> {
  final List<IconData> _icons = []; //保存Icon数据

  @override
  void initState() {
    super.initState();
    // 初始化数据
    _retrieveIcons();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, //每行三列
        childAspectRatio: 1.0, //显示区域宽高相等
      ),
      itemCount: _icons.length,
      itemBuilder: (context, index) {
        //如果显示到最后一个并且Icon总数小于200时继续获取数据
        if (index == _icons.length - 1 && _icons.length < 200) {
          _retrieveIcons();
        }
        return Icon(_icons[index]);
      },
    );
  }

  //模拟异步获取数据
  void _retrieveIcons() {
    Future.delayed(const Duration(milliseconds: 200)).then((e) {
      setState(() {
        _icons.addAll([
          Icons.ac_unit,
          Icons.airport_shuttle,
          Icons.all_inclusive,
          Icons.beach_access,
          Icons.cake,
          Icons.free_breakfast,
        ]);
      });
    });
  }
}
