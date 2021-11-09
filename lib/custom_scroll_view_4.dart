import 'package:flutter/material.dart';

class CustomScrollViewPage4 extends StatelessWidget {
  const CustomScrollViewPage4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SliverToBoxAdapter'),
      ),
      body: const PersistentHeaderRoute(),
    );
  }
}

typedef _SliverHeaderBuilder = Widget Function(
    BuildContext context, double shrinkOffset, bool overlapsContent);

/// 实现 SliverPersistentHeaderDelegate
class _ListSliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  // 配置构造函数 和 验证有效性
  _ListSliverHeaderDelegate({
    required Widget child,
    required this.maxHeight,
    this.minHeight = 0,
  })  : builder = ((a, b, c) => child),
        assert(minHeight <= maxHeight && minHeight >= 0);

  double maxHeight;
  double minHeight;
  final _SliverHeaderBuilder builder;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var child = builder(context, shrinkOffset, overlapsContent);
    if (child.key != null) {
      debugPrint('${child.key} $shrinkOffset $overlapsContent');
    }
    return SizedBox.expand(
      child: child,
    );
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // 当旧代理配置的最大最小值不同时，重新渲染
    return oldDelegate.maxExtent != maxExtent ||
        oldDelegate.minExtent != minExtent;
  }

  /// 等高头
  _ListSliverHeaderDelegate.fixedHeight(
      {required double height, required Widget child})
      : builder = ((a, b, c) => child),
        maxHeight = height,
        minHeight = height;

  //需要自定义builder时使用
  _ListSliverHeaderDelegate.builder({
    required this.maxHeight,
    this.minHeight = 0,
    required this.builder,
  });
}

class PersistentHeaderRoute extends StatelessWidget {
  const PersistentHeaderRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: _ListSliverHeaderDelegate(
            maxHeight: 60,
            minHeight: 20,
            child: buildHeader(1),
          ),
        ),
        buildSliverList(15),
        SliverPersistentHeader(
          pinned: true,
          delegate: _ListSliverHeaderDelegate.fixedHeight(
            height: 30,
            child: buildHeader(2),
          ),
        ),
        buildSliverList(20),
        SliverPersistentHeader(
          pinned: true,
          delegate: _ListSliverHeaderDelegate.builder(
            maxHeight: 50,
            minHeight: 20,
            builder: (context, shrinkOffset, overlapsContent) => buildHeader(3),
          ),
        ),
        buildSliverList(25),
      ],
    );
  }

  // 构建固定高度的SliverList，count为列表项属相
  Widget buildSliverList([int count = 5]) {
    return SliverFixedExtentList(
      itemExtent: 50,
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return ListTile(title: Text('$index'));
        },
        childCount: count,
      ),
    );
  }

  // 构建 header
  Widget buildHeader(int i) {
    return Container(
      key: ValueKey(i),
      color: Colors.lightBlue[(i % 9) * 100],
      alignment: Alignment.centerLeft,
      child: Text("PersistentHeader $i"),
    );
  }
}
