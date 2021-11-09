import 'package:flutter/material.dart';
import 'package:hello_flutter/utils.dart';

class NestedScrollViewPage extends StatelessWidget {
  const NestedScrollViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _NestedScrollViewTest();
  }
}

class _NestedScrollViewTest extends StatelessWidget {
  const _NestedScrollViewTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: NestedScrollView(
        headerSliverBuilder: headerSliverBuilder,
        body: ListView.builder(
          // 注意这里用的是RenderObject而不是Sliver
          itemCount: 30,
          itemBuilder: itemBuilder,
          padding: const EdgeInsets.all(8),
          physics: const ClampingScrollPhysics(), // 关闭默认到顶表现
        ),
      ),
    );
  }

  List<Widget> headerSliverBuilder(
      BuildContext context, bool innerBoxIsScrolled) {
    return [
      SliverAppBar(
        title: const Text('嵌套ListView'),
        pinned: true,
        forceElevated: innerBoxIsScrolled,
      ),
      buildSliverList(5),
    ];
  }

  Widget itemBuilder(BuildContext context, int index) {
    return SizedBox(
      height: 50,
      child: Center(
        child: Text('Item $index'),
      ),
    );
  }
}
