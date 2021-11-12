import 'package:flutter/material.dart';

class InterwineAnimationPage extends StatelessWidget {
  const InterwineAnimationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('交织动画'),
      ),
      body: const StaggerRoute(),
    );
  }
}

/// 封装交织动画
class StaggerAnimation extends StatelessWidget {
  StaggerAnimation({
    Key? key,
    required this.controller,
  }) : super(key: key) {
    // 高度动画
    height = Tween<double>(
      begin: 0.0,
      end: 300.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.0,
          0.6,
          curve: Curves.ease,
        ),
      ),
    );

    // 颜色动画
    color = ColorTween(
      begin: Colors.green,
      end: Colors.red,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(
          0.0,
          0.6,
          curve: Curves.ease,
        ),
      ),
    );

    // 偏移动画
    padding = Tween<EdgeInsets>(
      begin: const EdgeInsets.only(left: .0),
      end: const EdgeInsets.only(left: 100.0),
    ).animate(CurvedAnimation(
      parent: controller,
      curve: const Interval(
        0.6,
        1.0,
        curve: Curves.ease,
      ),
    ));
  }

  final Animation<double> controller;
  late final Animation<double> height;
  late final Animation<EdgeInsets> padding;
  late final Animation<Color?> color;

  /// 构建配置好动画的组件
  Widget _buildAnimation(BuildContext context, Widget? child) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: padding.value,
      child: Container(
        color: color.value,
        width: 50.0,
        height: height.value,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller, // 仅用controller控制动画
      builder: _buildAnimation,
    );
  }
}

/// 使用封装
class StaggerRoute extends StatefulWidget {
  const StaggerRoute({Key? key}) : super(key: key);

  @override
  _StaggerRouteState createState() => _StaggerRouteState();
}

class _StaggerRouteState extends State<StaggerRoute>
    with TickerProviderStateMixin {
  // 动画控制器
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
  }

  /// 动画播放逻辑
  _playAnimation() async {
    try {
      // 先向前执行
      await _controller.forward().orCancel;
      // 完了后，往回执行
      await _controller.reverse().orCancel;
    } on TickerCanceled {
      // 动画被取消
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              _playAnimation();
            },
            child: const Text('start animation'),
          ),
          Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              border: Border.all(color: Colors.blue.withOpacity(0.5)),
            ),
            child: StaggerAnimation(controller: _controller),
          )
        ],
      ),
    );
  }
}
