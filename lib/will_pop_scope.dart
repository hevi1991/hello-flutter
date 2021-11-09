import 'package:flutter/material.dart';

class WillPopScopePage extends StatelessWidget {
  const WillPopScopePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('导航返回拦截'),
      ),
      body: const WillPopScopeTest(),
    );
  }
}

class WillPopScopeTest extends StatefulWidget {
  const WillPopScopeTest({Key? key}) : super(key: key);

  @override
  _WillPopScopeTestState createState() => _WillPopScopeTestState();
}

class _WillPopScopeTestState extends State<WillPopScopeTest> {
  DateTime? _lastPressedAt;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Container(
        alignment: Alignment.center,
        child: const Text('1秒内连续按两次 < 才能返回'),
      ),
      onWillPop: () async {
        if (_lastPressedAt == null ||
            DateTime.now().difference(_lastPressedAt!) >
                const Duration(seconds: 1)) {
          _lastPressedAt = DateTime.now();
          return false;
        }
        return true;
      },
    );
  }
}
