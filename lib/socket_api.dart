import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class SocketAPIPage extends StatelessWidget {
  const SocketAPIPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Socket API 使用'),
      ),
      body: Center(
        child: FutureBuilder(
          future: _request(),
          builder: (context, snapShot) {
            debugPrint(snapShot.connectionState.toString());
            return Text(snapShot.data.toString());
          },
        ),
      ),
    );
  }

  _request() async {
    var socket = await Socket.connect('163.com', 80);
    // http 协议
    socket.writeln('GET / HTTP1.1');
    socket.writeln("Host:163.com");
    socket.writeln("Connection:close");
    socket.writeln(
        "user-agent: Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/10.0 Mobile/14E304 Safari/602.1");
    socket.writeln();
    await socket.flush(); //发送
    //读取返回内容，按照utf8解码为字符串
    String _response = await utf8.decoder.bind(socket).join();
    await socket.close();
    return _response;
  }
}
