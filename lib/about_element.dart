import 'package:flutter/material.dart';

class AboutElementPage extends StatelessWidget {
  const AboutElementPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Element <-> BuildingContext'),
      ),
      body: const Center(
        child: CustomHome(),
      ),
    );
  }
}

class CustomHome extends Widget {
  const CustomHome({Key? key}) : super(key: key);

  @override
  Element createElement() {
    return HomeView(this);
  }
}

class HomeView extends ComponentElement {
  HomeView(Widget widget) : super(widget);

  String text = '1234567890';

  @override
  Widget build() {
    // context -> Element 本身
    Color primary = Theme.of(this).primaryColor;
    return TextButton(
      onPressed: () {
        var t = text.split("")..shuffle();
        text = t.join();
        // 告知要rebuild
        markNeedsBuild();
      },
      child: Text(
        text,
        style: TextStyle(color: primary),
      ),
    );
  }
}
