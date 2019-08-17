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
      body: new Builder(
        builder:  (BuildContext context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${args.event.id}'),
              Center(
                child: RaisedButton(
                  color: Color(0xffEF5350),
                  onPressed: () {
                    myEvents.deleteEvent(args.event.id)
                      .then((data) {
                        Scaffold.of(context).showSnackBar(new SnackBar(
                          content: new Text("删除事件成功！"),
                        ));
                        Future.delayed(const Duration(milliseconds: 800), () {
                          Navigator.pop(context);
                        });
                      });
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
          );
        }
      )
    );
  }
}