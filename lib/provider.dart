import 'dart:collection';

import 'package:flutter/material.dart';

class ProviderPage extends StatelessWidget {
  const ProviderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('跨组件共享状态 Provider'),
      ),
      body: const ProviderRoute(),
    );
  }
}

/// Model的内容
class Item {
  Item({required this.price, required this.count});

  double price;
  int count;
}

/// 购物车跨组更新用的Model
class CartModel extends ChangeNotifier {
  // 购物车内容
  final List<Item> _items = [];

  /// 禁止改变购物车内的商品信息
  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  /// 总价
  double get totalPrice => _items.fold(
      0,
      (previousValue, element) =>
          previousValue + element.price * element.count);

  void add(Item item) {
    _items.add(item);
    // 通知订阅者更新
    notifyListeners();
  }
}

class ProviderRoute extends StatefulWidget {
  const ProviderRoute({Key? key}) : super(key: key);

  @override
  _ProviderRouteState createState() => _ProviderRouteState();
}

class _ProviderRouteState extends State<ProviderRoute> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      data: CartModel(),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<CartModel>(
              builder: (BuildContext context, cart) {
                return Text('总价：${cart!.totalPrice}');
              },
            ),
            Builder(
              builder: (BuildContext context) {
                debugPrint('Button build');
                return ElevatedButton(
                  onPressed: () {
                    ChangeNotifierProvider.of<CartModel>(context, listen: false)
                        .add(
                      Item(price: 20.0, count: 1),
                    );
                  },
                  child: const Text('添加商品'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

/****    自定义Provider，用于理解    *****/

/// 通用的InheritedWidget，报错需要跨组件共享的状态
class InheritedProvider<T> extends InheritedWidget {
  const InheritedProvider({
    Key? key,
    required Widget child,
    required this.data,
  }) : super(key: key, child: child);

  final T data;

  static InheritedProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedProvider>();
  }

  @override
  bool updateShouldNotify(InheritedProvider oldWidget) {
    return true; // 每次更新都会调用依赖更新 `didChangeDependencies`
  }
}

/// 封装事件总线
class ChangeNotifierProvider<T extends ChangeNotifier> extends StatefulWidget {
  const ChangeNotifierProvider({
    Key? key,
    required this.child,
    required this.data,
  }) : super(key: key);

  final Widget child;
  final T data;

  /// 快速取得总线的data
  /// listen 是否重新触发依赖渲染
  static T of<T>(BuildContext context, {bool listen = true}) {
    // 优化性能
    final provider = listen
        ? context.dependOnInheritedWidgetOfExactType<InheritedProvider<T>>()
        : context
            .getElementForInheritedWidgetOfExactType<InheritedProvider<T>>()
            ?.widget as InheritedProvider<T>;
    return provider!.data;
  }

  @override
  _ChangeNotifierProviderState createState() =>
      _ChangeNotifierProviderState<T>();
}

class _ChangeNotifierProviderState<T extends ChangeNotifier>
    extends State<ChangeNotifierProvider<T>> {
  void update() {
    setState(() {
      // 数据发生变化，重新构建InheritedProvider，从而触发子孙组件的`didChangeDependencies`重新构建
    });
  }

  @override
  void initState() {
    widget.data.addListener(update);
    super.initState();
  }

  @override
  void dispose() {
    widget.data.removeListener(update);
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ChangeNotifierProvider<T> oldWidget) {
    if (widget.data != oldWidget.data) {
      // 数据发生改变时，重新更新监听者
      oldWidget.data.removeListener(update);
      widget.data.addListener(update);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return InheritedProvider<T>(child: widget.child, data: widget.data);
  }
}

/// 语义化订阅消息的消费者
class Consumer<T> extends StatelessWidget {
  const Consumer({
    Key? key,
    required this.builder,
  }) : super(key: key);

  final Widget Function(BuildContext context, T? value) builder;

  @override
  Widget build(BuildContext context) {
    return builder(
      context,
      ChangeNotifierProvider.of<T>(context),
    );
  }
}
