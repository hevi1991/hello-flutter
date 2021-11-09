import 'package:flutter/material.dart';

class CustomScrollViewPage extends StatefulWidget {
  const CustomScrollViewPage({Key? key}) : super(key: key);

  @override
  State<CustomScrollViewPage> createState() => _CustomScrollViewPageState();
}

class _CustomScrollViewPageState extends State<CustomScrollViewPage> {
  bool isOld = true;

  @override
  Widget build(BuildContext context) {
    var oldView = buildTwoListViewOld();
    var customScrollView = buildTwoListView();
    return Scaffold(
      appBar: AppBar(
        title: const Text('自定义滚动视图 - 基础'),
      ),
      body: isOld ? oldView : customScrollView,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isOld = !isOld;
          });
        },
        child: const Icon(Icons.switch_account_outlined),
      ),
    );
  }
}

Widget buildTwoListViewOld() {
  var listView = ListView.builder(
    itemCount: 20,
    itemBuilder: (BuildContext context, int index) {
      return ListTile(
        title: Text('$index'),
      );
    },
  );

  return Column(
    children: [
      Expanded(child: listView),
      const Divider(),
      Expanded(child: listView),
    ],
  );
}

Widget buildTwoListView() {
  var listView = SliverFixedExtentList(
    delegate: SliverChildBuilderDelegate((_, index) {
      return ListTile(title: Text('$index'));
    }, childCount: 10),
    itemExtent: 56, // 固定高度
  );

  return CustomScrollView(
    slivers: [
      listView,
      listView,
    ],
  );
}
