import 'package:flutter/material.dart';

class StateManagePage extends StatelessWidget {
  const StateManagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("StateManage")),
        body: Column(
            children: const [TapboxA(), ParentWidget(), ParentWidgetC()]));
  }
}

// TapboxA 管理自身状态.
class TapboxA extends StatefulWidget {
  const TapboxA({Key? key}) : super(key: key);

  @override
  _TapboxAState createState() => _TapboxAState();
}

class _TapboxAState extends State<TapboxA> {
  bool _active = false;

  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 20.0),
        child: Center(
          child: Text(
            'Tapbox-A: ' + (_active ? 'Active' : 'Inactive'),
            style: const TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        height: 200.0,
        decoration: BoxDecoration(
          color: _active ? Colors.lightGreen[700] : Colors.grey[600],
        ),
      ),
    );
  }
}

// ParentWidget 为 TapboxB 管理状态.

//------------------------ ParentWidget --------------------------------

class ParentWidget extends StatefulWidget {
  const ParentWidget({Key? key}) : super(key: key);

  @override
  _ParentWidgetState createState() => _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> {
  bool _active = false;

  void _handleTapboxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TapboxB(
      active: _active,
      onChanged: _handleTapboxChanged,
    );
  }
}

//------------------------- TapboxB ----------------------------------

class TapboxB extends StatefulWidget {
  const TapboxB({Key? key, this.active = false, required this.onChanged})
      : super(key: key);

  final bool active;
  final ValueChanged<bool> onChanged;

  @override
  State<TapboxB> createState() => _TapboxBState();
}

class _TapboxBState extends State<TapboxB> {
  bool _highlight = false;

  void _handleTap() {
    widget.onChanged(!widget.active);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      onTapDown: (details) {
        setState(() {
          _highlight = true;
        });
      },
      onTapUp: (details) {
        setState(() {
          _highlight = false;
        });
      },
      onTapCancel: () {
        setState(() {
          _highlight = false;
        });
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 20.0),
        child: Center(
          child: Text(
            'Tapbox-B: ' + (widget.active ? 'Active' : 'Inactive'),
            style: const TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        height: 200.0,
        decoration: BoxDecoration(
          color: widget.active ? Colors.lightGreen[700] : Colors.grey[600],
          border: _highlight
              ? Border.all(
                  color: Colors.teal,
                  width: 10.0,
                )
              : null,
        ),
      ),
    );
  }
}

//---------------------------- ParentWidgetC ----------------------------

class ParentWidgetC extends StatefulWidget {
  const ParentWidgetC({Key? key}) : super(key: key);

  @override
  _ParentWidgetCState createState() => _ParentWidgetCState();
}

class _ParentWidgetCState extends State<ParentWidgetC> {
  bool _active = false;

  void _handleTapboxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TapboxC(
      active: _active,
      onChanged: _handleTapboxChanged,
    );
  }
}

//----------------------------- TapboxC ------------------------------

class TapboxC extends StatefulWidget {
  const TapboxC({Key? key, this.active = false, required this.onChanged})
      : super(key: key);

  final bool active;
  final ValueChanged<bool> onChanged;

  @override
  _TapboxCState createState() => _TapboxCState();
}

class _TapboxCState extends State<TapboxC> {
  bool _highlight = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _highlight = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTapCancel() {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTap() {
    widget.onChanged(!widget.active); // TapboxC Widget 触发状态给ParentWidgetC
  }

  @override
  Widget build(BuildContext context) {
    // 在按下时添加绿色边框，当抬起时，取消高亮
    return GestureDetector(
      onTapDown: _handleTapDown, // 处理按下事件
      onTapUp: _handleTapUp, // 处理抬起事件
      onTap: _handleTap,
      onTapCancel: _handleTapCancel,
      child: Container(
        child: Center(
          child: Text(
            'Tapbox-C: ' + (widget.active ? 'Active' : 'Inactive'),
            style: const TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        height: 200.0,
        decoration: BoxDecoration(
          color: widget.active ? Colors.lightGreen[700] : Colors.grey[600],
          border: _highlight
              ? Border.all(
                  color: Colors.teal,
                  width: 10.0,
                )
              : null,
        ),
      ),
    );
  }
}
