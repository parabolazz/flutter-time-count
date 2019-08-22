import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import '../models/eventStorage.dart';
import '../components/DatePicker.dart';
import '../const/colors.dart';
import '../components/ColorPicker.dart';

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
  Event eventInfo;
  final inputController = TextEditingController();


  void setColor(color) {
    setState(() {
      eventInfo.color = color;
    });
  }

  List renderColorPickers () {
    return availableColors.map((c) =>
        ColorPicker(color: c, active: eventInfo.color == c, onClick: setColor)
      ).toList();
  }

    setNewName() {
      setState(() {
        eventInfo.name = inputController.text;
      });
    }

    // Start listening to changes.

  @override
  void initState() {
    super.initState();
    inputController.addListener(() {
      setNewName();
    });
  }

  @override
  Widget build(BuildContext context) {

    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    eventInfo = args.event;

    inputController.text = eventInfo.name;

    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        backgroundColor: Color(eventInfo.color),
        elevation: 0.0,
      ),
      body: new Builder(
        builder:  (BuildContext context) {
          return Column(
            children: [
              Container(
                color: Color(eventInfo.color),
                height: 300.0,
                padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
                alignment: Alignment.bottomLeft,
                  child: TextField(
                    controller: inputController,
                    maxLines: null,
                    style: new TextStyle(
                      fontSize: 40.0,
                      color: Colors.white
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  )
              ),
              Expanded(
                  child: Container(
                    alignment: Alignment.topLeft,
                    decoration: BoxDecoration(
                      color: Color(eventInfo.color)
                    ),
                    child: Material(
                      elevation: 16.0,
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(46.0)),
                      ),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 0.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40.0),
                            topRight: Radius.circular(40.0),
                          ),
                        ),
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
                                color: Color(eventInfo.color),
                                child: Text(
                                  '修改', 
                                  style: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: 4.0
                                  )
                                ),
                                onPressed: () {
                                  myEvents.updateEvent(eventInfo)
                                    .then((data) {
                                      Scaffold.of(context).showSnackBar(new SnackBar(
                                        content: new Text("修改成功！"),
                                      ));
                                      Future.delayed(const Duration(milliseconds: 800), () {
                                        Navigator.pop(context);
                                      });
                                    });
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
                )
              ),
            ]
          );
        }
      )
    );
  }
}