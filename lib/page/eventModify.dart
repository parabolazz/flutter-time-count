import 'package:flutter/material.dart';

class ScreenArguments {
  final String name;
  final DateTime time;

  ScreenArguments(this.name, this.time);
}

class EventModifyRoute extends StatelessWidget {

  static const routeName = '/modify';

  @override
  Widget build(BuildContext context) {

    final ScreenArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
            print('click!');
            Navigator.pop(context);
          },
          child: Row(
            children: [
              Text('click me!'),
              Text('${args.name}')
            ]       
          )
        )
      )
    );
  }
}