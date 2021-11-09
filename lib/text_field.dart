import 'package:flutter/material.dart';

class TextFieldPage extends StatelessWidget {
  const TextFieldPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text Field'),
      ),
      body: const Center(
        child: _Login(),
      ),
    );
  }
}

class _Login extends StatefulWidget {
  const _Login({Key? key}) : super(key: key);

  @override
  State<_Login> createState() => _LoginState();
}

class _LoginState extends State<_Login> {
  final TextEditingController _unameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _unameController.text = 'hello@email.example';
    _unameController.addListener(() {
      debugPrint('print from controller: ${_unameController.text}');
    });
    _unameController.selection = TextSelection(
        baseOffset: 2, extentOffset: _unameController.text.length);
  }

  final FocusNode node1 = FocusNode();
  final FocusNode node2 = FocusNode();
  late FocusScopeNode focusScopeNode;

  @override
  Widget build(BuildContext context) {
    const divider = Divider(
      height: 30,
      thickness: 10,
    );
    return Column(
      children: [
        TextField(
          autofocus: true,
          decoration: const InputDecoration(
              labelText: '用户名',
              hintText: '用户名或邮箱',
              prefixIcon: Icon(Icons.person)),
          controller: _unameController,
        ),
        TextField(
          decoration: const InputDecoration(
              labelText: '密码',
              hintText: '您的登录密码',
              prefixIcon: Icon(Icons.lock)),
          obscureText: true,
          onChanged: (v) {
            debugPrint('print from onChange: $v');
          },
        ),
        divider,
        TextField(
          focusNode: node1,
          decoration: const InputDecoration(labelText: 'input1'),
        ),
        TextField(
          focusNode: node2,
          decoration: const InputDecoration(labelText: 'input2'),
        ),
        Builder(
          builder: (BuildContext context) {
            return Column(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    focusScopeNode = FocusScope.of(context);
                    if (node1.hasFocus) {
                      focusScopeNode.requestFocus(node2);
                    } else {
                      focusScopeNode.requestFocus(node1);
                    }
                  },
                  icon: const Icon(Icons.compare_arrows),
                  label: const Text('控制焦点移动'),
                ),
                ElevatedButton(
                    onPressed: () {
                      // node1.unfocus();
                      // node2.unfocus();
                      // 关闭焦点
                      FocusScope.of(context).unfocus();
                    },
                    child: const Text('关闭聚焦，隐藏键盘'))
              ],
            );
          },
        ),
        divider,
        const TextField(
          decoration: InputDecoration(
            labelText: '请输入用户名',
            prefixIcon: Icon(Icons.person),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
          ),
        ),
        Theme(
            data: Theme.of(context).copyWith(
                hintColor: Colors.grey[200], //定义下划线颜色
                inputDecorationTheme: const InputDecorationTheme(
                    labelStyle: TextStyle(color: Colors.grey), //定义label字体样式
                    hintStyle:
                        TextStyle(color: Colors.grey, fontSize: 14.0) //定义提示文本样式
                    )),
            child: Column(
              children: const <Widget>[
                TextField(
                  decoration: InputDecoration(
                      labelText: "用户名",
                      hintText: "用户名或邮箱",
                      prefixIcon: Icon(Icons.person)),
                ),
                TextField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      labelText: "密码",
                      hintText: "您的登录密码",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 13.0)),
                  obscureText: true,
                )
              ],
            ))
      ],
    );
  }
}
