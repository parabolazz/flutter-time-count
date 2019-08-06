import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class TimeCard extends StatelessWidget {
  final Map timeInfo;
  TimeCard({this.timeInfo});

  @override
  Widget build(
    BuildContext context,
  ) {

  const List cardColors = [0xffFF8A80, 0xff9E9E9E, 0XFF8C9EFF];
  final currentCardColor = cardColors[new Random().nextInt(3)];

  String _computeCountdown(DateTime setTime) {
    final currentTime = new DateTime.now();
    final durat = setTime.difference(currentTime);
    final days = durat.inSeconds > 0 ? durat.inDays > 0 ? durat.inDays.toString() : '<1' : '0';
    return days;
  }

    final String countdown = _computeCountdown(timeInfo['time']);
    final textTime =  DateFormat('yyyy-MM-dd').format(timeInfo['time']);

    return Container(
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
              offset: Offset(2.0, 4.0),
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
                      '${timeInfo['name']}',
                      style: TextStyle(
                        color: Colors.black,
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
                        color: Color(currentCardColor)
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
    );
  }
}
