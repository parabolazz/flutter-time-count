import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import '../models/eventStorage.dart';
import '../components/DatePicker.dart';

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
        backgroundColor: Color(0xffFF8A80),
        elevation: 0.0,
      ),
      body: new Builder(
        builder:  (BuildContext context) {
          return Column(
            children: [
              Container(
                color: Color(0xffFF8A80),
                height: 300.0,
                padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 80.0),
                alignment: Alignment.bottomLeft,
                  child: Text(
                    args.event.name,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 40.0,
                      color: Colors.white
                    ),
                  )
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 0.0),
                  decoration: BoxDecoration(
                    // color: Color(0xff000000),
                    // borderRadius: BorderRadius.only({topLeft:8.0}),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: [
                            Text('时间：'),
                            DatePicker(
                              args.event.utcTime,
                              (newDate) {
                                print(newDate);
                              }
                            )
                          ],
                        )
                      ),
                      Center(
                        child: OutlineButton(
                          borderSide: BorderSide(color: Color(0xffEF5350)),
                          shape: StadiumBorder(),
                          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 50.0),
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
                              color: Color(0xffEF5350),
                              letterSpacing: 4.0
                            ),
                          ),
                        )
                      )
                    ],
                  )
                ),
              ),
            ]
          );
        }
      )
    );
  }
}