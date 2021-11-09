import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/utils.dart';

class ListViewPage extends StatelessWidget {
  const ListViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('列表视图'),
      ),
      body: ListView(
        children: ListTile.divideTiles(context: context, tiles: [
          ListTile(
            title: const Text('默认'),
            onTap: () {
              MyUtils.createRouteAndPush(
                  context: context,
                  widget: ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(20.0),
                    children: const <Widget>[
                      Text('I\'m dedicating every day to you'),
                      Text('Domestic life was never quite my style'),
                      Text('When you smile, you knock me out, I fall apart'),
                      Text('And I thought I was so smart'),
                    ],
                  ),
                  title: '默认');
            },
          ),
          ListTile(
            title: const Text('builder - itemBuilder'),
            onTap: () {
              MyUtils.createRouteAndPush(
                  context: context,
                  widget: ListView.builder(
                    itemExtent: 50,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(index.toString()),
                      );
                    },
                  ),
                  title: 'builder - itemBuilder');
            },
          ),
          ListTile(
            title: const Text('separted - separtorBuilder'),
            onTap: () {
              var divider1 = const Divider(color: Colors.blue, thickness: 3);
              var divider2 = const Divider(color: Colors.green, thickness: 3);
              MyUtils.createRouteAndPush(
                context: context,
                widget: ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(index.toString()),
                    );
                  },
                  itemCount: 100,
                  separatorBuilder: (BuildContext context, int index) {
                    return index % 2 == 0 ? divider1 : divider2;
                  },
                ),
                title: 'separted - separtorBuilder',
              );
            },
          ),
          ListTile(
            title: const Text('prototypeItem - 固定高度原型item 优化性能'),
            onTap: () {
              MyUtils.createRouteAndPush(
                  context: context,
                  widget: ListView.builder(
                    prototypeItem: const ListTile(
                      title: Text('1'),
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text('$index'),
                      );
                    },
                  ),
                  title: 'prototypeItem - 固定高度原型item 优化性能');
            },
          ),
          ListTile(
            title: const Text('无限加载列表'),
            onTap: () {
              MyUtils.createRouteAndPush(
                  context: context,
                  widget: const InfiniteListView(),
                  title: '无限加载列表');
            },
          ),
          ListTile(
            title: const Text('固定列表头'),
            onTap: () {
              MyUtils.createRouteAndPush(
                  context: context,
                  widget: Column(
                    children: [
                      const ListTile(
                        title: Text('商品列表'),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Text('$index'),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  title: '固定列表头');
            },
          )
        ]).toList(),
      ),
    );
  }
}

class InfiniteListView extends StatefulWidget {
  const InfiniteListView({Key? key}) : super(key: key);

  @override
  _InfiniteListViewState createState() => _InfiniteListViewState();
}

class _InfiniteListViewState extends State<InfiniteListView> {
  static const _loadingTag = '##loading##';
  final _words = <String>[_loadingTag];

  @override
  void initState() {
    super.initState();
    _retrieveData();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: _words.length,
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(thickness: 1);
      },
      itemBuilder: (BuildContext context, int index) {
        if (_words[index] == _loadingTag) {
          if (_words.length - 1 < 100) {
            _retrieveData();
            return Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16),
              child: const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            );
          } else {
            return Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16),
              child: const Text(
                'No more',
                style: TextStyle(color: Colors.grey),
              ),
            );
          }
        } else {
          return ListTile(
            title: Text(_words[index]),
          );
        }
      },
    );
  }

  void _retrieveData() {
    Future.delayed(const Duration(seconds: 2)).then((value) {
      setState(() {
        // 往倒数第二位置后，塞20条数据
        _words.insertAll(_words.length - 1,
            generateWordPairs().take(20).map((e) => e.asPascalCase).toList());
      });
    });
  }
}
