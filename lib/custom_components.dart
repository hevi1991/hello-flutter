import 'package:flutter/material.dart';
import 'package:hello_flutter/utils.dart';

class CustomComponentsPage extends StatelessWidget {
  const CustomComponentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('自定义组合组件'),
      ),
      body: ListView(
        children: ListTile.divideTiles(context: context, tiles: [
          // context 必须加
          ListTile(
            title: const Text('GradientButton'),
            onTap: () {
              MyUtils.createRouteAndPush(
                  context: context,
                  widget: const _GradientButtonRoute(),
                  title: 'GradientButton');
            },
          ),
          ListTile(
            title: const Text('TurnBox'),
            onTap: () {
              MyUtils.createRouteAndPush(
                  context: context,
                  widget: const _TurnBoxRoute(),
                  title: 'TurnBox');
            },
          ),
        ]).toList(),
      ),
    );
  }
}

/// 渐变按钮测试路由
class _GradientButtonRoute extends StatelessWidget {
  const _GradientButtonRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GridView.count(
        padding: const EdgeInsets.all(16.0),
        crossAxisCount: 1,
        childAspectRatio: 4,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        children: [
          GradientButton(
            child: const Text('Submit'),
            onPressed: () {
              debugPrint('statement');
            },
          ),
          GradientButton(
            colors: [Colors.orange, Colors.orange[900]!],
            child: const Text('Submit'),
            onPressed: () {
              debugPrint('statement');
            },
          ),
          GradientButton(
            colors: [Colors.lightBlue[300]!, Colors.blueAccent],
            child: const Text('Submit'),
            onPressed: () {
              debugPrint('statement');
            },
          ),
          GradientButton(
            colors: [Colors.lightGreen, Colors.green[800]!],
            child: const Text('Submit'),
            onPressed: () {
              debugPrint('statement');
            },
          ),
          GradientButton(
            colors: [Colors.lightGreen, Colors.green[800]!],
            disabled: true,
            child: const Text('禁用'),
            onPressed: () {
              debugPrint('statement');
            },
          ),
          GradientButton(
            colors: [Colors.blue[50]!, Colors.blue, Colors.deepPurple],
            child: const Text('三色'),
            onPressed: () {
              debugPrint('statement');
            },
          ),
        ],
      ),
    );
  }
}

/// 渐变按钮
class GradientButton extends StatelessWidget {
  const GradientButton({
    Key? key,
    this.colors,
    this.width,
    this.height,
    this.disabled = false,
    required this.child,
    this.borderRadius,
    this.onPressed,
  })  : assert(colors == null || colors.length >= 2,
            "parameter colors only be null or length over or equal 2"),
        super(key: key);

  // 注意Dart可空的写法

  // 渐变色数组
  final List<Color>? colors;

  // 宽度和高度
  final double? width;
  final double? height;

  // 可用
  final bool disabled;

  final Widget child;
  final BorderRadius? borderRadius;

  final GestureTapCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    // 如果colors为空
    List<Color> _colors = disabled
        ? [Colors.grey, Colors.grey]
        : colors ?? [themeData.primaryColor, themeData.primaryColorDark];

    return DecoratedBox(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: _colors),
          borderRadius: borderRadius),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          splashColor: _colors.last,
          highlightColor: Colors.transparent,
          borderRadius: borderRadius,
          onTap: disabled ? null : onPressed,
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(height: height, width: width),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DefaultTextStyle(
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// 旋转盒测试路由
class _TurnBoxRoute extends StatefulWidget {
  const _TurnBoxRoute({Key? key}) : super(key: key);

  @override
  State<_TurnBoxRoute> createState() => _TurnBoxRouteState();
}

class _TurnBoxRouteState extends State<_TurnBoxRoute> {
  double _turns = .0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TurnBox(
            turns: _turns,
            speed: 500,
            child: const Icon(
              Icons.arrow_upward,
              size: 50,
            ),
          ),
          TurnBox(
            turns: _turns,
            speed: 1000,
            child: const Icon(
              Icons.arrow_upward,
              size: 150,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _turns += .2;
              });
            },
            child: const Text('顺时针转72°'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _turns -= .2;
              });
            },
            child: const Text('逆时针转72°'),
          )
        ],
      ),
    );
  }
}

/// 旋转盒
class TurnBox extends StatefulWidget {
  const TurnBox({
    Key? key,
    this.turns = .0,
    this.speed = 200,
    this.child,
  }) : super(key: key);

  /// 旋转圈数 0.25 即 90°
  final double turns;
  final int speed;
  final Widget? child;

  @override
  _TurnBoxState createState() => _TurnBoxState();
}

class _TurnBoxState extends State<TurnBox> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      lowerBound: -double.infinity,
      upperBound: double.infinity,
    );
    _controller.value = widget.turns;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: widget.child,
    );
  }

  @override
  void didUpdateWidget(covariant TurnBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.turns != widget.turns) {
      _controller.animateTo(
        widget.turns,
        duration: Duration(milliseconds: widget.speed),
        curve: Curves.easeInOut,
      );
    }
  }
}
