import 'package:flutter/material.dart';
import 'package:hello_flutter/utils.dart';
/* 
如果使用TabController
- 必须在组件销毁时，TabController也执行dispose，所以需要混入SingleTickerProviderStateMixin

class TabBarViewPage extends StatefulWidget {
  const TabBarViewPage({Key? key}) : super(key: key);

  @override
  State<TabBarViewPage> createState() => _TabBarViewPageState();
}

class _TabBarViewPageState extends State<TabBarViewPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List tabs = ['新闻', '历史', '图片'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TabBarView'),
        bottom: TabBar(
          tabs: tabs.map((e) => Tab(text: e)).toList(),
          controller: _tabController,
        ),
      ),
      body: TabBarView(
          controller: _tabController,
          children: tabs
              .map((e) => KeepAliveWrapper(
                    keepAlive: true,
                    child: Center(
                      child: Text(e, textScaleFactor: 5),
                    ),
                  ))
              .toList()),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
 */

/// 方法二，通过DefaultTabController作为父容器来代替控制销毁。甚至可以直接用StatelessWidget无状态组件。
class TabBarViewPage extends StatelessWidget {
  const TabBarViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List tabs = ['新闻', '历史', '图片'];
    return DefaultTabController(
      initialIndex: 1,
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('TabBarView'),
          bottom: TabBar(
            tabs: tabs.map((e) => Tab(text: e)).toList(),
          ),
        ),
        body: TabBarView(
            children: tabs
                .map((e) => KeepAliveWrapper(
                      keepAlive: true,
                      child: Center(
                        child: Text(e, textScaleFactor: 5),
                      ),
                    ))
                .toList()),
      ),
    );
  }
}
