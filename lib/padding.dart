import 'package:flutter/material.dart';

class PaddingPage extends StatelessWidget {
  const PaddingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PaddingPage'),
      ),
      body: _PaddingBox(),
    );
  }
}

class _PaddingBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // 指定左对齐，排除演示对齐干扰
        children: const [
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text('Hello world'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text('Hello world'),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Text('Hello world'),
          )
        ],
      ),
    );
  }
}
