import 'package:flutter/material.dart';

class ColorPage extends StatelessWidget {
  const ColorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('颜色'),
      ),
      body: GridView(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, mainAxisSpacing: 8, crossAxisSpacing: 8),
        children: [
          const AutoTitleColorBox(
            color: Color(0xff123456),
          ),
          const AutoTitleColorBox(
            color: Colors.blue,
            title: 'Demo1',
          ),
          const AutoTitleColorBox(
            color: Colors.white,
            title: 'Demo2',
          ),
          const AutoTitleColorBox(color: Colors.blue),
          AutoTitleColorBox(color: Colors.blue.shade100),
        ],
      ),
    );
  }
}

class AutoTitleColorBox extends StatelessWidget {
  const AutoTitleColorBox({Key? key, required this.color, this.title = ''})
      : super(key: key);

  final Color color;
  final String title;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: color),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: color.computeLuminance() < 0.5 ? Colors.white : Colors.black,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
