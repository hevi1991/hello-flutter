import 'package:flutter/material.dart';

class ScrollControllerPage extends StatelessWidget {
  const ScrollControllerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ScrollToTopTest();
  }
}

class ScrollToTopTest extends StatefulWidget {
  const ScrollToTopTest({Key? key}) : super(key: key);

  @override
  _ScrollToTopTestState createState() => _ScrollToTopTestState();
}

class _ScrollToTopTestState extends State<ScrollToTopTest> {
  final _controller = ScrollController();
  bool showToTopBtn = false;

  @override
  void initState() {
    super.initState();
    // 添加监听事件
    _controller.addListener(() {
      debugPrint('${_controller.offset}');
      if (_controller.offset < 1000 && showToTopBtn) {
        setState(() {
          showToTopBtn = false;
        });
      } else if (_controller.offset >= 1000 && showToTopBtn == false) {
        setState(() {
          showToTopBtn = true;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('滚动控制'),
      ),
      body: ListView.builder(
        itemCount: 100,
        itemExtent: 50,
        controller: _controller,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text('$index'),
          );
        },
      ),
      floatingActionButton: !showToTopBtn
          ? null
          : FloatingActionButton(
              onPressed: () {
                _controller.animateTo(.0,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.ease);
              },
              child: const Icon(Icons.arrow_upward),
            ),
    );
  }
}
