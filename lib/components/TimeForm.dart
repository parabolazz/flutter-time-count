
import 'package:flutter/material.dart';
import 'package:hello_world/models/eventStorage.dart';
import './DatePicker.dart';
import './ColorPicker.dart';
import '../const/colors.dart';

class TimeForm extends StatefulWidget {

  TimeForm({Key key, this.callback}) : super(key: key);
  final callback;

  @override
  MyTimeFormState createState() => MyTimeFormState();
}

class MyTimeFormState extends State<TimeForm>{

  final _timeNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int color ;
  DateTime selectedDate = DateTime.now();

  void onSave(info) {
    widget.callback(info);
  }

  List renderColorPickers () {
    return availableColors.map((c) {
      return ColorPicker(color: c, active:color == c, onClick: (newColor) {
        setState(() {
          color = newColor;
        });
      });
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Theme(
        data: ThemeData(
          primaryColor: Color(0xFF12a257)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _timeNameController,
              decoration: const InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  // width: 0.0 produces a thin "hairline" border
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(20.0),
                  ),
                  borderSide: const BorderSide(color: Colors.blueGrey, width: 0.0),
                ),
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(20.0),
                  ),
                ),
                hintText: 'What do people call you?',
                labelText: '它的名字',
              ),
              validator: (value) {
                if(value.isEmpty) {
                  return '值不能为空';
                }
                return null;
              }
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Row(
                children: <Widget>[
                  Text('选择时间：',
                    style: TextStyle(
                      color: Color(0xFF757575),
                      fontSize: 16.0
                    ),
                  ),
                  DatePicker(
                    selectedDate,
                    (newDate) {
                      setState(() {
                        selectedDate = newDate;
                      });
                    }
                  )
                ],
              )
            ),
            Container(
              padding: const EdgeInsets.only(top: 15.0),
              child: Row(
                children: <Widget>[
                  Text('选择颜色：',
                    style: TextStyle(
                      color: Color(0xFF757575),
                      fontSize: 16.0
                    )
                  ),
                  Flex(
                    direction: Axis.horizontal,
                    children: renderColorPickers()
                  )
                ],
              )
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 55.0),
              alignment: Alignment.topCenter,
              child: RaisedButton(
                color: Color(0xFF44b070),
                textColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                onPressed: () {
                  if(_formKey.currentState.validate()) {
                      final timeinfo = 
                        Event(
                          _timeNameController.text,
                        // !!!TODO: save real datetime
                          selectedDate,
                          new DateTime.now().millisecondsSinceEpoch,
                          color
                        );
                      onSave(timeinfo);
                  }
                },
                child: Text('GO!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    letterSpacing: 2.0,
                  )
                )
              ),
            )
          ],
        )
      )
    );
  }
}
