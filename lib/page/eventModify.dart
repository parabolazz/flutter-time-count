import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import '../models/eventStorage.dart';
import '../components/DatePicker.dart';

class ScreenArguments {
  final Event event;

  ScreenArguments(this.event);
}

class EventModifyRoute extends StatefulWidget {

  static const routeName = '/modify';

  @override
  EventModifyState createState() => EventModifyState();
}

class EventModifyState extends State {
  static const availableColors = [0xffFF8A80, 0xff9E9E9E, 0xFF8C9EFF];
  int currColor = 0xFF8C9EFF;

  List renderColorPickers () {
    return availableColors.map((c) => 
      Padding(
        padding: EdgeInsets.fromLTRB(0.0, 5.0, 20.0, 5.0),
        child: GestureDetector(
          onTap: () {
            setState(() {
              currColor = c;
            });
            print(currColor);
          },
          child: ClipOval(
            child: Container(
              padding: EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: const Color(0xFF878787)),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: ClipOval(
                child: Container(
                  width: 28.0,
                  height: 28.0,
                  decoration: BoxDecoration(
                    color: Color(c)
                  ),
                ),
              )
            )
          )
        )
      )).toList();
  }

  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    Event eventInfo = args.event;

    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        backgroundColor: Color(currColor),
        elevation: 0.0,
      ),
      body: new Builder(
        builder:  (BuildContext context) {
          return Column(
            children: [
              Container(
                color: Color(currColor),
                height: 300.0,
                padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 80.0),
                alignment: Alignment.bottomLeft,
                  child: Text(
                    eventInfo.name,
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
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(bottom: 50.0),
                        child: Wrap(
                          children: [
                            Row(
                              children: [
                                Text(
                                  '时间：',
                                  style: TextStyle(
                                    fontSize: 18.0
                                  )),
                                DatePicker(
                                  eventInfo.utcTime,
                                  (newTime) {
                                    setState(() {
                                      eventInfo.utcTime = newTime;
                                    });
                                  }
                                )
                              ]
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  '颜色：',
                                  style: TextStyle(
                                    fontSize: 18.0
                                  )
                                ),
                                Flex(
                                  direction: Axis.horizontal,
                                  children: renderColorPickers()
                                )
                              ],
                            )
                          ],
                        )
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20.0),
                        child: RaisedButton(
                          shape: StadiumBorder(),
                          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 50.0),
                          color: Color(currColor),
                          child: Text(
                            '修改', 
                            style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 4.0
                            )
                          ),
                          onPressed: () {
                            myEvents.updateEvent(eventInfo);
                          },
                        )
                      ),
                      Center(
                        child: OutlineButton(
                          borderSide: BorderSide(color: Color(0xffEF5350)),
                          shape: StadiumBorder(),
                          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 50.0),
                          color: Color(0xffEF5350),
                          onPressed: () {
                            myEvents.deleteEvent(eventInfo.id)
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