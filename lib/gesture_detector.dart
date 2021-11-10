import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class GestureDetectorPage extends StatelessWidget {
  const GestureDetectorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 状态变量
    var operation = 'No Gesture detected!';

    var width = 200.0;
    var height = 200.0;

    var top = 0.0;
    var left = 0.0;
    var horizon = true;
    var vertical = true;

    return Scaffold(
      appBar: AppBar(
        title: const Text('手势识别'),
      ),
      body: StatefulBuilder(
        builder: (BuildContext context, setState) {
          return Stack(
            children: [
              Center(
                // GestureDetector 点击、双击、长按、缩放事件演示
                child: GestureDetector(
                  onScaleUpdate: (details) {
                    setState(() {
                      var scaleRatio = details.scale.clamp(0.8, 1.5);
                      operation =
                          'onScaleUpdate: ${scaleRatio.toStringAsFixed(2)}';
                      width = 200.0 * scaleRatio;
                      height = 200.0 * scaleRatio;
                    });
                  },
                  onTap: () => setState(() => operation = 'onTap'),
                  onDoubleTap: () => setState(() => operation = 'onDoubleTap'),
                  onLongPress: () => setState(() => operation = 'onLongPress'),
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.blue,
                    width: width,
                    height: height,
                    child: Text(
                      operation,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              // GestureDetector 拖拽事件演示
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('【pan】滑动控制：'),
                  const Text('垂直滑动'),
                  Checkbox(
                    value: vertical,
                    onChanged: (value) {
                      setState(() {
                        vertical = value!;
                      });
                    },
                  ),
                  const Text('水平滑动'),
                  Checkbox(
                    value: horizon,
                    onChanged: (value) {
                      setState(() {
                        horizon = value!;
                      });
                    },
                  ),
                ],
              ),
              Positioned(
                top: top,
                left: left,
                child: GestureDetector(
                  child: const CircleAvatar(
                    child: Text('Pan'),
                  ),
                  onPanDown: (e) {
                    debugPrint('${e.globalPosition}');
                  },
                  onPanUpdate: (e) {
                    setState(() {
                      left += horizon ? e.delta.dx : 0;
                      top += vertical ? e.delta.dy : 0;
                    });
                  },
                  onPanStart: (e) {
                    debugPrint('onPanStart');
                  },
                  onPanEnd: (e) {
                    // velocity 拖拽速度
                    debugPrint('onPanEnd, velocity: ${e.velocity}');
                  },
                ),
              ),
              const Positioned(
                bottom: 100,
                left: 0,
                right: 0,
                child: _GestureRecognizer(),
              )
            ],
          );
        },
      ),
    );
  }
}

class _GestureRecognizer extends StatefulWidget {
  const _GestureRecognizer({Key? key}) : super(key: key);

  @override
  _GestureRecognizerState createState() => _GestureRecognizerState();
}

class _GestureRecognizerState extends State<_GestureRecognizer> {
  final TapGestureRecognizer _tapGestureRecognizer = TapGestureRecognizer();
  bool _toggle = false; // 变色开关

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text.rich(
        TextSpan(children: [
          const TextSpan(text: '你好世界'),
          TextSpan(
            text: '改变颜色',
            style: TextStyle(
              fontSize: 30.0,
              color: _toggle ? Colors.blue : Colors.red,
            ),
            recognizer: _tapGestureRecognizer
              ..onTap = () {
                setState(() {
                  _toggle = !_toggle;
                });
              },
          ),
          const TextSpan(text: '你好世界'),
        ]),
      ),
    );
  }

  @override
  void dispose() {
    _tapGestureRecognizer.dispose(); // 释放
    super.dispose();
  }
}
