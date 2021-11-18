import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class FileOperationPage extends StatefulWidget {
  const FileOperationPage({Key? key}) : super(key: key);

  @override
  State<FileOperationPage> createState() => _FileOperationPageState();
}

class _FileOperationPageState extends State<FileOperationPage> {
  int _counter = 0;

  /// 获取App沙盒文件
  Future<File> _getLocalFile() async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    return File('$dir/counter.txt');
  }

  /// 读App > counter.txt 转换为整型
  Future<int> _readCounter() async {
    try {
      File file = await _getLocalFile();
      String contents = await file.readAsString();
      return int.parse(contents);
    } on FileSystemException catch (e) {
      debugPrint(e.message);
      return 0;
    }
  }

  /// 改变状态，写入文件
  _incrementCounter() async {
    setState(() {
      _counter++;
    });

    // 写入文件
    await ((await _getLocalFile()).writeAsString('$_counter'));
  }

  @override
  void initState() {
    super.initState();
    // 初始化并赋值
    _readCounter().then((value) {
      setState(() {
        _counter = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('文件操作'),
      ),
      body: Center(
        child: Text(
          '$_counter',
          textScaleFactor: 5,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.read_more),
      ),
    );
  }
}
