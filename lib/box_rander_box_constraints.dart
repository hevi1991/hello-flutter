import 'package:flutter/material.dart';

class BoxConstraintsPage extends StatelessWidget {
  const BoxConstraintsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Box Constraints'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: const <Widget>[
            Text('子约束盒'),
            _Box1(),
            Divider(),
            Text('SizedBox'),
            _Box2(),
            Divider(),
            Text('多重约束'),
            _Box3(),
            Divider(),
            Text('不约束盒'),
            _Box4()
          ],
        ),
      ),
    );
  }
}

const Widget redBox =
    DecoratedBox(decoration: BoxDecoration(color: Colors.red));

class _Box1 extends StatelessWidget {
  const _Box1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints:
          const BoxConstraints(minWidth: double.infinity, minHeight: 50),
      // ignore: sized_box_for_whitespace
      child: Container(
        height: 5.0,
        child: redBox,
      ),
    );
  }
}

class _Box2 extends StatelessWidget {
  const _Box2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 50,
      height: 50,
      child: redBox,
    );
  }
}

class _Box3 extends StatelessWidget {
  const _Box3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 90.0, minHeight: 20.0),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 60.0, minHeight: 60.0),
          child: redBox,
        ));
  }
}

class _Box4 extends StatelessWidget {
  const _Box4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 60.0, minHeight: 100.0), //父
        child: UnconstrainedBox(
          //“去除”父级限制，实际表现，父节点 minHeight 约束依然存在
          child: ConstrainedBox(
            constraints:
                const BoxConstraints(minWidth: 90.0, minHeight: 20.0), //子
            child: redBox,
          ),
        ));
  }
}
