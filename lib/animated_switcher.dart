import 'package:flutter/material.dart';

class AnimatedSwitcherPage extends StatelessWidget {
  const AnimatedSwitcherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('动画切换'),
      ),
      body: const Center(
        child: AnimatedSwitcherCounterRoute(),
      ),
    );
  }
}

class AnimatedSwitcherCounterRoute extends StatefulWidget {
  const AnimatedSwitcherCounterRoute({Key? key}) : super(key: key);

  @override
  _AnimatedSwitcherCounterRouteState createState() =>
      _AnimatedSwitcherCounterRouteState();
}

class _AnimatedSwitcherCounterRouteState
    extends State<AnimatedSwitcherCounterRoute> {
  int _count = 0;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (child, animation) {
              return ScaleTransition(child: child, scale: animation);
            },
            child: Text(
              '$_count',
              key: ValueKey(_count), // 【配置key，不复用】只有不同组件，才能触发动画
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _count++;
              });
            },
            child: const Text('child'),
          )
        ],
      ),
    );
  }
}
