import 'package:flutter/material.dart';
import '../models/eventStorage.dart';

class ScreenArguments {
  final Event event;

  ScreenArguments(this.event);
}

class EventModifyRoute extends StatelessWidget {

  static const routeName = '/modify';

  @override
  Widget build(BuildContext context) {

    final ScreenArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        title: Text('修改')
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: RaisedButton(
              color: Color(0xffEF5350),
              onPressed: () {
                print(args.event.id);
              },
              child: Text(
                '删除',
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 4.0
                ),
              ),
            )
          )
        ]
      )
    );
  }
}