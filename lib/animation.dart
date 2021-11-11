import 'package:flutter/material.dart';

class AnimationPage extends StatelessWidget {
  const AnimationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('动画 - 基本'),
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
        // child: const ScaleAnimationTest1(),
        // child: const ScaleAnimationTest2(),
        child: const ScaleAnimationTest3(),
      ),
    );
  }
}
/* 
/// 基础写法一
class ScaleAnimationTest1 extends StatefulWidget {
  const ScaleAnimationTest1({Key? key}) : super(key: key);

  @override
  _ScaleAnimationTest1State createState() => _ScaleAnimationTest1State();
}

class _ScaleAnimationTest1State extends State<ScaleAnimationTest1>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    // 2秒
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    // 可选择添加动画曲线
    animation =
        CurvedAnimation(parent: controller, curve: Curves.bounceIn);
    // 图片宽高从0到300
    animation = Tween(begin: 0.0, end: 300.0).animate(animation)
      ..addListener(() {
        // 起一个标记需要更新状态的作用
        setState(() {});
      });

    // 启动动画
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose(); // from SingleTickerProviderStateMixin
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Image.asset(
            'assets/images/cart.png',
            width: animation.value,
            height: animation.value,
          ),
        ),
        Positioned(
          right: 15,
          top: 10,
          child: ElevatedButton(
            onPressed: () {
              controller.reset();
              controller.forward();
            },
            child: const Text('replay'),
          ),
        )
      ],
    );
  }
}
// 写法一 end
 */
/* 
/// 写法二，使用AnimatedWidget，可替代animation..addListener那段触发setState
class AnimatedImage extends AnimatedWidget {
  const AnimatedImage({
    Key? key,
    required Animation<double> animation,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Image.asset(
      'assets/images/cart.png',
      width: animation.value,
      height: animation.value,
    );
  }
}

class ScaleAnimationTest2 extends StatefulWidget {
  const ScaleAnimationTest2({Key? key}) : super(key: key);

  @override
  _ScaleAnimationTest2State createState() => _ScaleAnimationTest2State();
}

class _ScaleAnimationTest2State extends State<ScaleAnimationTest2>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    animation = CurvedAnimation(parent: controller, curve: Curves.bounceIn);
    animation = Tween(
      begin: 0.0,
      end: 300.0,
    ).animate(controller);

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedImage(animation: animation),
    );
  }
}
// 写法二 end
 */

/// 写法三，使用AnimationBuilder，性能较好，可以将child暴露出去，封装成通用动画组件，类似Flutter官方Transition
class ScaleAnimationTest3 extends StatefulWidget {
  const ScaleAnimationTest3({Key? key}) : super(key: key);

  @override
  _ScaleAnimationTest3State createState() => _ScaleAnimationTest3State();
}

class _ScaleAnimationTest3State extends State<ScaleAnimationTest3>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    animation = CurvedAnimation(parent: controller, curve: Curves.bounceIn);
    animation = Tween(
      begin: 0.0,
      end: 300.0,
    ).animate(controller)
      ..addStatusListener((status) {
        switch (status) {
          case AnimationStatus.completed:
            controller.reverse();
            break;
          case AnimationStatus.dismissed:
            controller.forward();
            break;
          default:
        }
      });

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      child: Image.asset('assets/images/cart.png'),
      builder: (BuildContext context, Widget? child) {
        return Center(
          child: SizedBox(
            width: animation.value,
            height: animation.value,
            child: child,
          ),
        );
      },
    );
  }
}
