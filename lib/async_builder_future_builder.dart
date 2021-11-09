import 'package:flutter/material.dart';

class FutureBuilderPage extends StatelessWidget {
  const FutureBuilderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('异步UI更新 - FutureBuilder'),
      ),
      body: Center(
        child: FutureBuilder(
          future: mockNetworkData(),
          initialData: 'loading...',
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Text('Contents: ${snapshot.data}');
              }
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                Text('${snapshot.data}'),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// 模拟网络获取数据
Future<String> mockNetworkData() {
  return Future.delayed(const Duration(seconds: 2), () => 'Data from network.');
}
