import 'package:flutter/material.dart';

class FormBasicPage extends StatelessWidget {
  const FormBasicPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _Form(),
          ],
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  _Form({Key? key}) : super(key: key);

  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<_Form> {
  final _unameController = TextEditingController();
  final _pwdController = TextEditingController();
  final GlobalKey _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey, // 可以通过key，在作用于中取得
      autovalidateMode: AutovalidateMode.onUserInteraction, // 当用户交互后自动验证
      child: Column(
        children: [
          TextFormField(
            autofocus: true,
            controller: _unameController,
            decoration: const InputDecoration(
              labelText: '用户名',
              hintText: '用户名或邮箱',
              icon: Icon(Icons.person),
            ),
            validator: (v) {
              return v!.trim().isNotEmpty ? null : '用户名不能为空';
            },
          ),
          TextFormField(
            controller: _pwdController,
            decoration: const InputDecoration(
              labelText: '密码',
              hintText: '您的登录密码',
              icon: Icon(Icons.lock),
            ),
            obscureText: true,
            validator: (v) {
              return v!.length > 5 ? null : '密码不能小于6位';
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Builder(
              builder: (BuildContext context) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Form.of(context)!.validate(); // 如果要使用Form.of(context)就必须使用Builder创建组件
                        if ((_formKey.currentState as FormState).validate()) {
                          // 通过验证
                          debugPrint('It\'s Vaild');
                        } else {
                          debugPrint('Invaild');
                        }
                      },
                      child: const Text('验证'),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Colors.grey[600],
                        ),
                        onPressed: () {
                          Form.of(context)!.reset();
                        },
                        child: const Text('Reset'))
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
