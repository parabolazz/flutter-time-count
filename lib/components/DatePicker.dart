
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatelessWidget{
  final DateTime selectedDate;
  final onSelected;
  DatePicker(this.selectedDate, this.onSelected);

  Future<Null> _selectDate(BuildContext context, DateTime stateTime) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: stateTime,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != stateTime)
      this.onSelected(picked);
  }

  @override
  Widget build (
    BuildContext context,
  ) {
    return FlatButton(
      padding: EdgeInsets.all(0),
      onPressed: () => _selectDate(context, selectedDate),
      child: Text(
        DateFormat('yyyy-MM-dd').format(selectedDate),
        style: TextStyle(
          fontSize: 18.0
        )),
    );
  }
}