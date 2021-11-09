import 'package:flutter/material.dart';

class ThemePage extends StatelessWidget {
  const ThemePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _themeColor = Colors.teal;
    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
        ThemeData themeData = Theme.of(context);
        return Theme(
          data: ThemeData(
            primarySwatch: _themeColor,
            iconTheme: IconThemeData(color: _themeColor),
          ),
          child: Scaffold(
            appBar: AppBar(
              title: const Text('主题'),
            ),
            body: Container(
              constraints: const BoxConstraints.expand(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //第一行Icon使用主题中的iconTheme
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Icon(Icons.favorite),
                        Icon(Icons.airport_shuttle),
                        Text("  颜色跟随主题"),
                      ]),
                  //为第二行Icon自定义颜色（固定为黑色)
                  Theme(
                    data: themeData.copyWith(
                      iconTheme:
                          themeData.iconTheme.copyWith(color: Colors.black),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          Icon(Icons.favorite),
                          Icon(Icons.airport_shuttle),
                          Text("  颜色固定黑色"),
                        ]),
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                setState(() {
                  _themeColor =
                      _themeColor == Colors.teal ? Colors.blue : Colors.teal;
                });
              },
              child: const Icon(Icons.palette),
            ),
          ),
        );
      },
    );
  }
}
