import 'package:flutter/material.dart';
import 'package:hello_world/models/eventStorage.dart';
import 'package:intl/intl.dart';

class TimeCard extends StatelessWidget {
  final Event eventInfo;
  TimeCard({this.eventInfo, this.onClick});
  final onClick;

  @override
  Widget build(
    BuildContext context,
  ) {

  String _computeCountdown(DateTime setTime) {
    final currentTime = new DateTime.now();
    final durat = setTime.difference(currentTime);
    final days = durat.inSeconds > 0 ? durat.inDays > 0 ? durat.inDays.toString() : '<1' : '0';
    return days;
  }

    final String countdown = _computeCountdown(eventInfo.utcTime);
    final textTime =  DateFormat('yyyy-MM-dd').format(eventInfo.utcTime);

    return GestureDetector(
      onTap: () {
        onClick(eventInfo);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20.0),
        padding: EdgeInsets.all(10.0),
        width: 330.0,
        height: 110.0,
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0.0, 4.0),
              blurRadius: 6.0 /*,spreadRadius:2.0*/)
          ],
        ),
          alignment: Alignment.topLeft,
          child: Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                fit: FlexFit.loose,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${eventInfo.name}',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18.0,
                        letterSpacing: 0.5),
                    ),
                    Text(
                      textTime,
                      style: TextStyle(
                        color: Colors.black54,
                      ))
                    ])),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      countdown,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        height: 0.8,
                        fontSize: 60.0,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -4.0,
                        color: Color(eventInfo.color)
                      ),
                    ),
                    Text('天',
                      style: TextStyle(
                        height: 1.0,
                        fontSize: 12.0,
                        color: Colors.black54,
                      )),
                    ]))
            ])
      )
    );
  }
}
