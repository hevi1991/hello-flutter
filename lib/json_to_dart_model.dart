import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hello_flutter/models/person.dart';
import 'package:hello_flutter/models/user.dart';

class JSON2DartModelPage extends StatelessWidget {
  const JSON2DartModelPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var jsonString = '{"name":"peter", "email": "abc@email.com"}';
    User user = User.fromJson(json.decode(jsonString));

    var jsonString2 = '''
    {
      "name": "John Smith",
      "email": "john@example.com",
      "mother":{
        "name": "Alice",
        "email":"alice@example.com"
      },
      "friends":[
        {
          "name": "Jack",
          "email":"Jack@example.com"
        },
        {
          "name": "Nancy",
          "email":"Nancy@example.com"
        }
      ]
    }
    ''';
    var person = Person.fromJson(json.decode(jsonString2));
    debugPrint(json.encode(person.toJson()));

    return Scaffold(
      appBar: AppBar(
        title: const Text('JSON转Dart类'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(user.name),
            Text(user.email),
            const Divider(),
            Text(person.name),
            Text(person.email),
            Offstage(
              offstage: person.mother == null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Mother: '),
                  Text(person.mother!.name),
                  const Text(' - '),
                  Text(person.mother!.email),
                ],
              ),
            ),
            Offstage(
              offstage: person.friends == null && person.friends!.isEmpty,
              child: Column(
                children: [
                  const Text('Friends: '),
                  ...person.friends!.map(
                    (e) => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(e.name),
                        const Text(' - '),
                        Text(e.email),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
