import 'package:flutter/material.dart';

class SwitchAndCheckboxPage extends StatelessWidget {
  const SwitchAndCheckboxPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Switch And Checkbox'),
      ),
      body: const Center(child: _SwitchAndCheckbox()),
    );
  }
}

class _SwitchAndCheckbox extends StatefulWidget {
  const _SwitchAndCheckbox({Key? key}) : super(key: key);

  @override
  _SwitchAndCheckboxState createState() => _SwitchAndCheckboxState();
}

class _SwitchAndCheckboxState extends State<_SwitchAndCheckbox> {
  bool _switchSelected = false;
  bool _checkboxSelected = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
          child: Text('Switch: ${_switchSelected ? "开" : "关"}'),
        ),
        Switch(
            value: _switchSelected,
            onChanged: (value) {
              setState(() {
                _switchSelected = value;
              });
            }),
        const Divider(),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
          child: Text('Checkbox: ${_checkboxSelected ? "开" : "关"}'),
        ),
        Checkbox(
            value: _checkboxSelected,
            activeColor: Colors.red,
            onChanged: (value) {
              setState(() {
                _checkboxSelected = value!;
              });
            }),
        CheckboxListTile(
            title: const Text('有标题的Checkbox'),
            value: _checkboxSelected,
            onChanged: (value) {
              setState(() {
                _checkboxSelected = value!;
              });
            })
      ],
    );
  }
}
