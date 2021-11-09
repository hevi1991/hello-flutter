import 'dart:math';

import 'package:flutter/material.dart';

class NewRoute extends StatelessWidget {
  const NewRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New route"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                var route = MaterialPageRoute(
                    builder: (context) => const NewRoute(),
                    fullscreenDialog: Random().nextInt(10) % 2 == 0);
                Navigator.push(context, route);
              },
              child: const Text('Open new route'),
            ),
            ElevatedButton(
              onPressed: () {
                var route = MaterialPageRoute(
                    builder: (context) => const NewRoute(),
                    fullscreenDialog: Random().nextInt(10) % 2 == 0);
                Navigator.pushReplacement(context, route);
              },
              child: const Text('Replace with new route'),
            ),
            ElevatedButton(
              onPressed: () async {
                var route = MaterialPageRoute(
                  builder: (context) => const TipRoute(
                    text: '我是提示',
                  ),
                );
                var result = await Navigator.push(context, route);
                debugPrint(result);
              },
              child: const Text('Get value from next route'),
            ),
            ElevatedButton(
              onPressed: () {
                var route = MaterialPageRoute(
                    builder: (context) => RoutesApp(), fullscreenDialog: true);
                Navigator.push(context, route);
              },
              child: const Text('Named dialog，过去就回不来了'),
            ),
          ],
        ),
      ),
    );
  }
}

class TipRoute extends StatelessWidget {
  const TipRoute({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('提示'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('如果不带值返回，点↖的返回按钮'),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, "Return Value aka RV!"),
                child: Text("$text，带值返回"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

typedef RouteCallback = Widget Function(
    BuildContext context, RouteSettings settings);

class RoutesApp extends StatelessWidget {
  RoutesApp({Key? key, t}) : super(key: key);

  final _routes = <String, RouteCallback>{
    "/": (context, settings) => Scaffold(
          appBar: AppBar(
            title: const Text("命名路由"),
          ),
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "testRoute",
                        arguments: <String, String>{
                          "father": "give child"
                        }); // 路由传参
                  },
                  child: const Text('Goto `testRoute` and pass arguments')),
            ],
          )),
        ),
    "testRoute": (context, settings) {
      Map arguments = settings.arguments as Map<String, String>; // 路由接参，强转
      String argument = arguments['father'];
      return Scaffold(
        appBar: AppBar(
          title: const Text('Testing'),
        ),
        body: Center(
          child: Text('测试命名路由 ' + argument),
        ),
      );
    }
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '命名路由',
      onGenerateRoute: (settings) {
        if (settings.name == 'testRoute') {
          var boom = Random().nextInt(10);
          if (boom % 2 == 0) {
            return MaterialPageRoute(builder: (context) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Mock Login'),
                ),
                body: const Center(
                  child: Text('Login please.'),
                ),
              );
            });
          }
        }
        return MaterialPageRoute(builder: (context) {
          return _routes[settings.name]!(context, settings);
        });
      },
      // routes: _routes, // 如果要使用onGenerateRoute钩子，则不能使用routes
      initialRoute: "/",
    );
  }
}
