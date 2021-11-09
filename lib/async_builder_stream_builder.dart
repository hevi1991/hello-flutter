import 'package:flutter/material.dart';

class StreamBuilderPage extends StatelessWidget {
  const StreamBuilderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('异步UI更新 - StreamBuilder'),
      ),
      body: Center(
        child: StreamBuilder(
          stream: counting(),
          initialData: 0,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Text('None stream');
              case ConnectionState.waiting:
                return const Text('Waiting stream');
              case ConnectionState.active:
                return Text('${snapshot.data}');
              case ConnectionState.done:
                return const Text('Stream closed');
            }
          },
        ),
      ),
    );
  }
}

/// 每秒计数
Stream<int> counting() {
  return Stream.periodic(const Duration(seconds: 2), (i) => i);
}
