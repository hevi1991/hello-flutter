import 'package:flutter/material.dart';

class DialogPage extends StatelessWidget {
  const DialogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var child = Column(
      children: [
        const ListTile(title: Text('Choose one')),
        Expanded(
          child: ListView.builder(
            itemCount: 30,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text('$index'),
                onTap: () {
                  Navigator.pop(context, index);
                },
              );
            },
          ),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('对话框'),
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(16),
        childAspectRatio: 10,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        crossAxisCount: 1,
        children: [
          OutlinedButton(
            onPressed: () async {
              bool? result = await showDeleteConfirmDialog1(context);
              if (result == null) {
                debugPrint('cancel');
              } else {
                if (result == true) {
                  debugPrint('delete');
                }
              }
            },
            child: const Text('Alert Dialog'),
          ),
          OutlinedButton(
            onPressed: () async {
              int? result = await showDialog<int>(
                context: context,
                builder: (BuildContext context) {
                  return SimpleDialog(
                    title: const Text('Choose language'),
                    children: [
                      SimpleDialogOption(
                        child: const Text('中文简体'),
                        onPressed: () {
                          Navigator.pop(context, 1);
                        },
                      ),
                      SimpleDialogOption(
                        child: const Text('English'),
                        onPressed: () {
                          Navigator.pop(context, 2);
                        },
                      ),
                    ],
                  );
                },
              );

              if (result != null) {
                debugPrint('Chose ${result == 1 ? "简体中文" : "English"}');
              }
            },
            child: const Text('Simple Dialog'),
          ),
          OutlinedButton(
            onPressed: () async {
              int? i = await showDialog<int>(
                  context: context,
                  builder: (context) {
                    return Dialog(child: child);
                  });
              debugPrint('Dialog chose $i');
            },
            child: const Text('Dialog'),
          ),
          OutlinedButton(
            onPressed: () async {
              int? i = await showDialog<int>(
                  context: context,
                  builder: (context) {
                    return UnconstrainedBox(
                      constrainedAxis: Axis.vertical,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 280),
                        child: Material(
                          child: child,
                          type: MaterialType.card,
                        ),
                      ),
                    );
                  });
              debugPrint('(custom widget with Material Style) chose $i');
            },
            child: const Text('Using UnconstrainedBox'),
          ),
          OutlinedButton(
            onPressed: () async {
              bool? result = await showDeleteConfirmDialog2(context);
              if (result == null) {
                debugPrint('delete cancel');
              } else {
                if (result) {
                  debugPrint('delete with tree');
                } else {
                  debugPrint('delete without tree');
                }
              }
            },
            child: const Text('Stateful Widget in Dialog'),
          ),
          OutlinedButton(
            onPressed: () async {
              var result = await showMyNumberModalBottomSheet(context);
              debugPrint('ModalBottomSheet: Chose ${result.toString()}');
            },
            child: const Text('showModalBottomSheet'),
          ),
          OutlinedButton(
            onPressed: () async {
              var date = DateTime.now();
              DateTime? picked = await showDatePicker(
                context: context,
                initialDate: date,
                firstDate: date,
                lastDate: date.add(
                  const Duration(days: 30),
                ),
              );
              debugPrint('Pick $picked');
            },
            child: const Text('showDatePicker'),
          ),
        ],
      ),
    );
  }
}

/// 弹出基础对话框
Future<bool?> showDeleteConfirmDialog1(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('提示'),
        content: const Text('您确认要删除吗？'),
        actions: [
          TextButton(
            onPressed: () {
              // 退出关闭dialog，默认返回 Future null
              Navigator.of(context).pop();
            },
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              // 返回 Future true
              Navigator.of(context).pop(true);
            },
            child: const Text(
              '删除',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      );
    },
  );
}

/// 弹出带状态组件的对话框
Future<bool?> showDeleteConfirmDialog2(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        bool _withTree = false;

        return AlertDialog(
          title: const Text('提示'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('你确定要删除吗？'),
              Row(
                children: [
                  const Text('同时删除子目录'),
                  StatefulBuilder(
                    builder: (BuildContext context, setState) {
                      return Checkbox(
                        value: _withTree,
                        onChanged: (bool? value) {
                          setState(() {
                            if (value == null) {
                              _withTree = false;
                            } else {
                              _withTree = value;
                            }
                          });
                        },
                      );
                    },
                  ),
                ],
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // 退出关闭dialog，默认返回 Future null
                Navigator.of(context).pop();
              },
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () {
                // 返回 Future true
                Navigator.of(context).pop(_withTree);
              },
              child: const Text(
                '删除',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      });
}

/// 底部菜单列表
Future<int?> showMyNumberModalBottomSheet(BuildContext context) {
  return showModalBottomSheet<int>(
    context: context,
    builder: (context) {
      return ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('$index'),
            onTap: () {
              Navigator.pop(context, index);
            },
          );
        },
      );
    },
  );
}
