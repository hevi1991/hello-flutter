import 'package:flutter/material.dart';

/*
在实际布局中，我们通常需要往 CustomScrollView 中添加一些自定义的组件，而这些组件并非都有 Sliver 版本，
为此 Flutter 提供了一个 SliverToBoxAdapter 组件，
它是一个适配器：可以将 RenderBox 适配为 Sliver。
*/

class CustomScrollViewPage3 extends StatelessWidget {
  const CustomScrollViewPage3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SliverToBoxAdapter'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            // SliverToBoxAdapter 将SizedBox转化成Sliver模型
            child: SizedBox(
              height: 300,
              child: PageView(
                children: const [
                  Text(
                    "1",
                    textScaleFactor: 5,
                  ),
                  Text(
                    "2",
                    textScaleFactor: 5,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
