import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class DioMultiBlockDownloadPage extends StatelessWidget {
  const DioMultiBlockDownloadPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dio - 分块下载'),
      ),
      body: const Center(
        child: MultiBlockDownloadRoute(),
      ),
    );
  }
}

class MultiBlockDownloadRoute extends StatefulWidget {
  const MultiBlockDownloadRoute({Key? key}) : super(key: key);

  @override
  _MultiBlockDownloadRouteState createState() =>
      _MultiBlockDownloadRouteState();
}

class _MultiBlockDownloadRouteState extends State<MultiBlockDownloadRoute> {
  double _progress = 0.0;
  bool _loading = false;
  bool _finish = false;

  Dio _dio = Dio();

  @override
  void dispose() {
    _dio.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LinearProgressIndicator(
          value: _progress,
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: _loading || _finish
                ? MaterialStateProperty.all(Colors.grey[300])
                : MaterialStateProperty.all(Colors.blue),
          ),
          onPressed: () {
            if (_loading || _finish) {
              return;
            }
            setState(() {
              _loading = true;
            });

            getApplicationDocumentsDirectory().then((dir) {
              var url =
                  "http://download.dcloud.net.cn/HBuilder.9.0.2.macosx_64.dmg";
              var documentPath = dir.path;
              var savePath =
                  "$documentPath/example/HBuilder.9.0.2.macosx_64.dmg";
              _request(url, savePath, onReceiveProgress: (current, total) {
                setState(() {
                  _progress = current / total;
                });
              });
            });
          },
          child: _loading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(color: Colors.white),
                )
              : _finish
                  ? const Text('finish')
                  : const Text('download'),
        )
      ],
    );
  }

  Future _request(String url, String savePath,
      {ProgressCallback? onReceiveProgress}) async {
    int firstChunkSize = 124;
    const maxChunk = 3;

    int total = 0; // 总长度
    var progress = <int>[];

    /// 回调不为空，则触发回调
    createCallback(part) {
      return (int received, _) {
        progress[part] = received;
        if (onReceiveProgress != null && total != 0) {
          onReceiveProgress(progress.reduce((a, b) => a + b), total);
        }
      };
    }

    /// 下载chunk
    /// url 地址
    /// start chunk开始位置
    /// end chunk 结束位置
    Future<Response> downloadChunk(
        String url, int start, int end, int part) async {
      progress.add(end - start); // 记录每块已接收长度
      end--;
      debugPrint(progress
          .reduce((value, element) => value + element)
          .toString()); // 最后超过总大小没关系?
      return _dio.download(
        url,
        savePath + '.temp$part',
        onReceiveProgress: createCallback(part),
        options: Options(
          headers: {'range': 'bytes=$start-$end'},
        ),
      );
    }

    /// 合并所有chunk
    Future mergeTempFiles(chunk) async {
      File f = File(savePath + '.temp0'); // 第一个开始
      IOSink ioSink = f.openWrite(mode: FileMode.writeOnlyAppend); // 文件打开写入通道
      for (var i = 1; i < chunk; i++) {
        File _f = File(savePath + '.temp$i');
        await ioSink.addStream(_f.openRead());
        await _f.delete(); //
      }
      await ioSink.close();
      await f.rename(savePath);
    }

    Response response = await downloadChunk(url, 0, firstChunkSize, 0);
    if (response.statusCode == 206) {
      // 解析文件总长度
      total = int.parse(response.headers
          .value(HttpHeaders.contentRangeHeader)!
          .split('/')
          .last);
      // 剩余长度
      int reserved = total -
          int.parse(response.headers.value(HttpHeaders.contentLengthHeader)!);
      //文件的总块数(包括第一块)
      int chunk = (reserved / firstChunkSize).ceil() + 1;
      if (chunk > 1) {
        int chunkSize = firstChunkSize;
        if (chunk > maxChunk + 1) {
          chunk = maxChunk + 1; // 算上0号chunk，最多分4个
          chunkSize = (reserved / maxChunk).ceil(); // 向上取整
        }
        var futures = <Future>[];
        for (int i = 0; i < maxChunk; ++i) {
          int start = firstChunkSize + i * chunkSize;
          //分块下载剩余文件
          futures.add(downloadChunk(url, start, start + chunkSize, i + 1));
        }
        //等待所有分块全部下载完成
        await Future.wait(futures);
      }

      // 合并，重命名
      await mergeTempFiles(chunk);
      setState(() {
        _finish = true;
        _loading = false;
      });
    }
  }
}
