import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class WebSocketsPage extends StatefulWidget {
  const WebSocketsPage({Key? key}) : super(key: key);

  @override
  State<WebSocketsPage> createState() => _WebSocketsPageState();
}

class _WebSocketsPageState extends State<WebSocketsPage> {
  final TextEditingController _textEditingController = TextEditingController();
  late IOWebSocketChannel channel;
  String _text = '';

  @override
  void initState() {
    super.initState();
    channel = IOWebSocketChannel.connect(Uri.parse('ws://0.0.0.0:8081'));
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebSocket'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              child: TextFormField(
                controller: _textEditingController,
                decoration: const InputDecoration(labelText: 'Send a message'),
              ),
            ),
            StreamBuilder(
              stream: channel.stream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  _text = 'Network Error: ${snapshot.error}';
                } else if (snapshot.hasData) {
                  _text = 'echo: ${snapshot.data}';
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Text(_text),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: const Icon(Icons.send),
      ),
    );
  }

  void _sendMessage() {
    if (_textEditingController.text.isNotEmpty) {
      channel.sink.add(_textEditingController.text);
      _textEditingController.text = '';
    }
  }
}
