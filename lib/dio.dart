import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class DioPage extends StatelessWidget {
  DioPage({Key? key}) : super(key: key);

  final Dio _dio = Dio();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('网络请求 - Dio'),
      ),
      body: Center(
        child: FutureBuilder(
          future: _dio.get('https://api.github.com/orgs/flutterchina/repos'),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              Response response = snapshot.data;
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              List<Widget> data = (response.data as List)
                  .map<Widget>(
                    (e) => ListTile(
                      title: Text(e['full_name']),
                    ),
                  )
                  .toList();
              return ListView.separated(
                itemBuilder: (c, i) {
                  return data[i];
                },
                separatorBuilder: (c, i) {
                  return const Divider();
                },
                itemCount: data.length,
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
