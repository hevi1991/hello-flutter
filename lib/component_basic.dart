import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';

class ComponentBasicPage extends StatelessWidget {
  const ComponentBasicPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ListTile> tiles = [
      ListTile(
        title: const Text('Text'),
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => _TextAndStyle()));
        },
      ),
      ListTile(
        title: const Text('Button'),
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => _Buttons()));
        },
      ),
      ListTile(
        title: const Text('Image'),
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const _Image()));
        },
      ),
      ListTile(
        title: const Text('Icon'),
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const _Icon()));
        },
      )
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Component'),
      ),
      body: ListView(
        children: ListTile.divideTiles(context: context, tiles: tiles).toList(),
      ),
    );
  }
}

// Text and Style
class _TextAndStyle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text and Style'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          const Text(
            'Hello world',
            textAlign: TextAlign.left,
          ),
          Text(
            'hello world ' * 6,
            maxLines: 1,
          ),
          Text(
            "Hello world! I'm Jack. " * 4,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const Text(
            'Hello world',
            textScaleFactor: 1.5,
          ),
          Text(
            'Hello world',
            style: TextStyle(
                color: Colors.blue,
                fontSize: 18,
                height: 1.2,
                fontFamily: 'Courier',
                background: Paint()..color = Colors.yellow, // 级联调用，赋值完，返回实例本身
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.dashed),
          ),
          const Divider(),
          const Text.rich(TextSpan(children: [
            TextSpan(text: 'Home: '),
            TextSpan(
              text: "https://flutterchina.club",
              style: TextStyle(color: Colors.blue),
            )
          ])),
          const Divider(),
          DefaultTextStyle(
              style:
                  const TextStyle(color: Colors.red, fontSize: 20), // 1. 设置默认样式
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("hello world"),
                  Text("I am Jack"),
                  Text(
                    "I am Jack",
                    style: TextStyle(
                        inherit: false, //2. 不继承默认样式
                        color: Colors.grey),
                  ),
                ],
              )),
          const Divider(),
          const Text(
            'Use Raleway for this text',
            style: TextStyle(fontFamily: 'Raleway', fontSize: 25),
          ),
          const Text(
            'Use AbrilFatface for this text',
            style: TextStyle(fontFamily: 'AbrilFatface', fontSize: 25),
          ),
        ],
      ),
    );
  }
}

// Buttons
class _Buttons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Buttons'),
        ),
        body: ListView(padding: const EdgeInsets.all(20.0), children: [
          ElevatedButton(onPressed: () {}, child: const Text('ElevatedButton')),
          TextButton(onPressed: () {}, child: const Text('TextButton')),
          OutlinedButton(onPressed: () {}, child: const Text('OutlinedButton')),
          IconButton(onPressed: () {}, icon: const Icon(Icons.thumb_up)),
          const Divider(),
          ElevatedButton.icon(
            icon: const Icon(Icons.send),
            label: const Text("发送"),
            onPressed: () {},
          ),
          OutlinedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text("添加"),
            onPressed: () {},
          ),
          TextButton.icon(
            icon: const Icon(Icons.info),
            label: const Text("详情"),
            onPressed: () {},
          ),
        ]));
  }
}

// Image
class _Image extends StatelessWidget {
  const _Image({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image'),
      ),
      body: Column(
        children: [
          const Image(
            image: AssetImage('assets/images/avatar.jpg'),
            width: 200,
          ),
          const Image(
            image: NetworkImage(
                'https://www.baidu.com/img/PCtm_d9c8750bed0b3c7d089fa7d55720d6cf.png'),
          ),
          Image.network(
              'https://flutterchina.club/images/flutter-mark-square-100.png'),
        ],
      ),
    );
  }
}

// Icon
class _Icon extends StatelessWidget {
  const _Icon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Icon'),
        ),
        body: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Icon(Icons.accessible, color: Colors.green),
              Icon(Icons.error, color: Colors.green),
              Icon(Icons.fingerprint, color: Colors.green),
              Divider(),
              Icon(_RemixIcons.homeInline, color: Colors.blue),
              Icon(_RemixIcons.homeWifiLine, color: Colors.blue),
              Divider(),
              Icon(Remix.home_3_line, color: Colors.red),
              Icon(Remix.home_2_line, color: Colors.red),
            ],
          ),
        ));
  }
}

class _RemixIcons {
  static const IconData homeInline = IconData(
    0xee2b,
    fontFamily: 'RemixIcon',
    matchTextDirection: true,
  );

  static const IconData homeWifiLine = IconData(
    0xEE31,
    fontFamily: 'RemixIcon',
    matchTextDirection: true,
  );
}
