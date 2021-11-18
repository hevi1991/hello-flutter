import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class HttpClientPage extends StatefulWidget {
  const HttpClientPage({Key? key}) : super(key: key);

  @override
  State<HttpClientPage> createState() => _HttpClientPageState();
}

class _HttpClientPageState extends State<HttpClientPage> {
  bool _loading = false;
  String _text = 'Click floating button at right bottom ↘';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HttpClient发请求'),
      ),
      body: Center(
        child: Scrollbar(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Text(_text),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _loading ? null : _request,
        child: const Icon(Icons.download),
      ),
    );
  }

  _request() async {
    setState(() {
      _loading = true;
      _text = 'Loading...';
    });

    try {
      HttpClient httpClient = HttpClient();
      HttpClientRequest request =
          await httpClient.getUrl(Uri.parse('https://www.baidu.com/'));
      request.headers.add('user-agent',
          'Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/10.0 Mobile/14E304 Safari/602.1');
      // 发起请求
      HttpClientResponse response = await request.close();
      // 读取响应内容
      _text = await response.transform(utf8.decoder).join();

      debugPrint(response.headers.toString());
      // 关闭client
      httpClient.close();
    } catch (e) {
      _text = '请求失败：$e';
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }
}
