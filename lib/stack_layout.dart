import 'package:flutter/material.dart';

class StackLayout extends StatelessWidget {
  const StackLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('堆叠布局'),
      ),
      body: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: Stack(
          alignment: Alignment.center, //指定未定位或部分定位widget的对齐方式
          fit: StackFit.expand, //未定位widget占满Stack整个空间
          children: [
            const Positioned(
              child: Text('I am Jack'),
              left: 18.0,
            ),
            Container(
              // 注意顺序和Stack父节点的fit属性
              child: const Text(
                'Hello world',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.red,
            ),
            const Positioned(
              child: Text('Your friend'),
              top: 18.0,
            ),
          ],
        ),
      ),
    );
  }
}
