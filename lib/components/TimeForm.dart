
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeForm extends StatefulWidget {

  TimeForm({Key key, this.callback}) : super(key: key);
  final callback;

  @override
  MyTimeFormState createState() => MyTimeFormState();
}

class MyTimeFormState extends State<TimeForm>{

  final _timeNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();

  void onSave(info) {
    widget.callback(info);
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
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
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Row(
                children: <Widget>[
                  Text('选择时间：',
                    style: TextStyle(
                      color: Color(0xFF757575),
                      fontSize: 16.0
                    ),
                  ),
                  FlatButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () => _selectDate(context),
                    child: Text(DateFormat('yyyy-MM-dd').format(selectedDate)),
                  ),
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
                      final timeinfo = {
                        'name': _timeNameController.text,
                        // !!!TODO: save real datetime
                        'time': DateFormat('yyyy-MM-dd').format(selectedDate)
                      };
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
