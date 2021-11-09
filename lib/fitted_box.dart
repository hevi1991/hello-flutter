import 'package:flutter/material.dart';

class FittedBoxPage extends StatelessWidget {
  const FittedBoxPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('空间适配'),
      ),
      body: SizedBox.expand(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const _FittedBox(),
          const Divider(),
          Column(
            children: [
              _row(' 90000000000000000 '),
              FittedBox(child: _row(' 90000000000000000 ')),
              _row(' 800 '),
              FittedBox(child: _row(' 800 ')),
            ]
                .map((e) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: e,
                    ))
                .toList(),
          ),
          SingleLineFittedBox(
            child: _row('90000000000000000 '),
          ),
          SingleLineFittedBox(
            child: _row('888'),
          ),
        ],
      )),
    );
  }
}

class _FittedBox extends StatelessWidget {
  const _FittedBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _container(BoxFit.none),
        const Text('data'),
        _container(BoxFit.contain),
        const Text('data2'),
      ],
    );
  }
}

Widget _container(BoxFit boxFit) {
  return Container(
    width: 50,
    height: 50,
    color: Colors.red,
    child: FittedBox(
      fit: boxFit,
      // 子容器超过父容器大小
      child: Container(width: 60, height: 70, color: Colors.blue),
    ),
  );
}

// 直接使用Row
Widget _row(String text) {
  Widget child = Text(text);
  child = Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [child, child, child],
  );
  return child;
}

/// 适配屏幕，单行展示
class SingleLineFittedBox extends StatelessWidget {
  const SingleLineFittedBox({Key? key, this.child}) : super(key: key);
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        // builder会去取父节点的约束
        return FittedBox(
          child: ConstrainedBox(
            constraints: constraints.copyWith(
              minWidth: constraints.maxWidth,
              maxWidth: double.infinity,
              //maxWidth: constraints.maxWidth
            ),
            child: child,
          ),
        );
      },
    );
  }
}
