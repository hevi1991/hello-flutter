import 'package:hello_flutter/animated_list.dart';
import 'package:hello_flutter/assets_manage.dart';
import 'package:hello_flutter/async_builder_future_builder.dart';
import 'package:hello_flutter/async_builder_stream_builder.dart';
import 'package:hello_flutter/box_rander_box_constraints.dart';
import 'package:hello_flutter/clip.dart';
import 'package:hello_flutter/color.dart';
import 'package:hello_flutter/component_basic.dart';
import 'package:hello_flutter/container.dart';
import 'package:hello_flutter/custom_scroll_view.dart';
import 'package:hello_flutter/custom_scroll_view_2.dart';
import 'package:hello_flutter/custom_scroll_view_3.dart';
import 'package:hello_flutter/custom_scroll_view_4.dart';
import 'package:hello_flutter/debug.dart';
import 'package:hello_flutter/decorated_box.dart';
import 'package:hello_flutter/dialog.dart';
import 'package:hello_flutter/exception_catch.dart';
import 'package:hello_flutter/fitted_box.dart';
import 'package:hello_flutter/flex_layout.dart';
import 'package:hello_flutter/flow_layout.dart';
import 'package:hello_flutter/form_basic.dart';
import 'package:hello_flutter/grid_view.dart';
import 'package:hello_flutter/inherited_widget.dart';
import 'package:hello_flutter/linear_layout.dart';
import 'package:hello_flutter/list_view.dart';
import 'package:hello_flutter/nested_scroll_view.dart';
import 'package:hello_flutter/nested_tab_bar_view.dart';
import 'package:hello_flutter/package_manage.dart';
import 'package:hello_flutter/padding.dart';
import 'package:hello_flutter/page_view.dart';
import 'package:hello_flutter/page_view_keep_alive.dart';
import 'package:hello_flutter/progress.dart';
import 'package:hello_flutter/provider.dart';
import 'package:hello_flutter/responsive_layout.dart';
import 'package:hello_flutter/route_manage.dart';
import 'package:hello_flutter/scaffold.dart';
import 'package:hello_flutter/scroll_controller.dart';
import 'package:hello_flutter/scroll_notification_listener.dart';
import 'package:hello_flutter/single_child_scroll_view.dart';
import 'package:hello_flutter/stack_layout.dart';
import 'package:hello_flutter/state_manage.dart';
import 'package:flutter/material.dart';
import 'package:hello_flutter/counter.dart';
import 'package:hello_flutter/echo.dart';
import 'package:hello_flutter/switch_and_checkbox.dart';
import 'package:hello_flutter/tab_bar_view.dart';
import 'package:hello_flutter/text_field.dart';
import 'package:hello_flutter/theme.dart';
import 'package:hello_flutter/transform.dart';
import 'package:hello_flutter/value_listenable_builder.dart';
import 'package:hello_flutter/will_pop_scope.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Route {
  Widget page;
  String name;
  Route(this.page, this.name);
}

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final _routes = <Route>{
    Route(const MyHomePage(title: 'Counter'), '计数器应用 Hello World'),
    Route(const EchoPage(text: 'StatelessWidget'), '无状态组件'),
    Route(const StateManagePage(), '有状态组件'),
    Route(const NewRoute(), '路由管理'),
    Route(const PackageManagePage(), '包管理'),
    Route(const AssetsManagePage(), '资源管理'),
    Route(const DebugPage(), '调试'),
    Route(const ExceptionCatchPage(), '异常捕获'),
    Route(const ComponentBasicPage(), '基础组件 - 基础组件'),
    Route(const SwitchAndCheckboxPage(), '基础组件 - 单选开关和复选框'),
    Route(const TextFieldPage(), '基础组件 - 输入框'),
    Route(const FormBasicPage(), '基础组件 - 表单'),
    Route(const ProgressPage(), '基础组件 - 进度指示器'),
    Route(const BoxConstraintsPage(), '布局 - 盒约束'),
    Route(const LinearLayoutPage(), '布局 - 线性布局'),
    Route(const FlexLayoutPage(), '布局 - 弹性布局'),
    Route(const FlowLayoutPage(), '布局 - 流式布局'),
    Route(const StackLayout(), '布局 - 堆叠布局'),
    Route(const ResponsiveLayoutPage(), '布局 - 响应式布局'),
    Route(const PaddingPage(), '容器 - padding'),
    Route(const DecoratedBoxPage(), '容器 - 装饰容器'),
    Route(const TransformPage(), '容器 - 变换'),
    Route(const ContainerPage(), '容器 - Container类'),
    Route(const ClipPage(), '容器 - 裁剪'),
    Route(const FittedBoxPage(), '容器 - 空间适配'),
    Route(const ScaffoldPage(), '容器 - Scaffold - 页面容器'),
    Route(const SingleChildScrollViewPage(), '可滚动组件 - 单子组件滚动视图'),
    Route(const ListViewPage(), '可滚动组件 - 列表视图'),
    Route(const ScrollControllerPage(), '可滚动组件 - 滚动控制'),
    Route(const ScrollNotificationListenerPage(), '可滚动组件 - 滚动监听'),
    Route(const AnimatedListPage(), '可滚动组件 - 动效列表视图'),
    Route(const GridViewPage(), '可滚动组件 - 网格视图'),
    Route(const PageViewPage(), '可滚动组件 - PageView和页面缓存'),
    Route(const PageViewKeepAlivePage(), '可滚动组件 - 组件子项缓存'),
    Route(const TabBarViewPage(), '可滚动组件 - TabBarView'),
    Route(const CustomScrollViewPage(), '可滚动组件 - 自定义滚动视图 - 基础'),
    Route(const CustomScrollViewPage2(), '可滚动组件 - 自定义滚动视图 - 完整页'),
    Route(
        const CustomScrollViewPage3(), '可滚动组件 - 自定义滚动视图 - SliverToBoxAdapter'),
    Route(const CustomScrollViewPage4(),
        '可滚动组件 - 自定义滚动视图 - SliverPersistentHeader'),
    Route(const NestedScrollViewPage(), '可滚动组件 - 嵌套可滚动组件 - NestedScrollView'),
    Route(const NestedTabBarViewPage(), '可滚动组件 - 嵌套TabBarView'),
    Route(const WillPopScopePage(), '功能组件 - 导航返回拦截'),
    Route(const InheritedWidgetPage(), '功能组件 - 数据共享 - InheritedWidget'),
    Route(const ProviderPage(), '功能组件 - 跨组件数据共享 - Provider'),
    Route(const ValueListenableBuilderPage(),
        '功能组件 - 任意流向数据共享 - ValueListenableBuilder'),
    Route(const ColorPage(), '功能组件 - 颜色'),
    Route(const ThemePage(), '功能组件 - 主题'),
    Route(const FutureBuilderPage(), '功能组件 - 异步UI更新 - FutureBuilder'),
    Route(const StreamBuilderPage(), '功能组件 - 异步UI更新 - StreamBuilder'),
    Route(const DialogPage(), '功能组件 - 对话框'),
  };

  @override
  Widget build(BuildContext context) {
    final tiles = _routes.map((route) {
      return ListTile(
        title: Text(route.name),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Colors.grey[400],
          size: 12,
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return route.page;
          }));
        },
      );
    });
    final divided =
        ListTile.divideTiles(context: context, tiles: tiles).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('目录'),
      ),
      body: ListView(
        children: divided,
      ),
    );
  }
}
