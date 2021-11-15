import 'package:flutter/material.dart';

class ClipPage extends StatelessWidget {
  const ClipPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 头像
    Widget avatar = Image.asset("assets/images/avatar.jpg", width: 60.0);

    return Scaffold(
      appBar: AppBar(
        title: const Text('裁剪'),
      ),
      body: Container(
        color: Colors.black,
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          children: <Widget>[
            avatar, //不剪裁
            ClipOval(child: avatar), //剪裁为圆形
            ClipRRect(
              //剪裁为圆角矩形
              borderRadius: BorderRadius.circular(5.0),
              child: avatar,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  widthFactor: .5, //宽度设为原来宽度一半，另一半会溢出
                  child: avatar,
                ),
                const Text(
                  "你好世界",
                  style: TextStyle(color: Colors.green),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ClipRect(
                  //将溢出部分剪裁
                  child: Align(
                    alignment: Alignment.topLeft,
                    widthFactor: .5, //宽度设为原来宽度一半
                    child: avatar,
                  ),
                ),
                const Text(
                  "你好世界",
                  style: TextStyle(color: Colors.green),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
