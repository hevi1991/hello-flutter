import 'package:flutter/material.dart';

class PointerEventsPage extends StatelessWidget {
  const PointerEventsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('光标事件'),
      ),
      body: Center(
        child: Column(
          children: const [
            Expanded(
              child: _PointerMoveIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}

class _PointerMoveIndicator extends StatefulWidget {
  const _PointerMoveIndicator({Key? key}) : super(key: key);

  @override
  _PointerMoveIndicatorState createState() => _PointerMoveIndicatorState();
}

class _PointerMoveIndicatorState extends State<_PointerMoveIndicator> {
  PointerEvent? _event;

  @override
  Widget build(BuildContext context) {
    return Listener(
      child: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.blue,
              child: Center(
                child: Text(
                  '${_event?.localPosition ?? 'touch'}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: AbsorbPointer(
                    child: Listener(
                      onPointerDown: (e) {
                        // 不会执行，但最外层的Listener会执行
                        debugPrint('in');
                      },
                      child: Container(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: IgnorePointer(
                    // 禁止了一切光标事件，包括最外层的Listener
                    child: Container(
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      onPointerDown: (event) {
        setState(() {
          _event = event;
        });
      },
      onPointerMove: (event) {
        setState(() {
          _event = event;
        });
      },
      onPointerUp: (event) {
        setState(() {
          _event = event;
        });
      },
    );
  }
}
