import 'package:flutter/material.dart';

class TimeCard extends StatelessWidget {
  final Map timeInfo;
  TimeCard({this.timeInfo});

  @override
  Widget build(
    BuildContext context,
  ) {

  int _computeCountdown(setTime) {
    print(setTime);
    final currentTime = new DateTime.now();
    final bookTime = setTime is DateTime ? setTime : DateTime.parse(setTime);
    final durat = bookTime.difference(currentTime);
    return durat.inDays;
  }

    final countdown = _computeCountdown(timeInfo['time']);
  
    return Container(
      padding: EdgeInsets.only(right: 80.0),
      child: Container(
        margin: EdgeInsets.only(bottom: 20.0),
        padding: EdgeInsets.all(10.0),
        width: 300.0,
        height: 110.0,
        decoration: BoxDecoration(
          color: Colors.red,
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
                        color: Colors.white,
                        fontSize: 18.0,
                        letterSpacing: 0.5),
                    ),
                    Text('${timeInfo['time']}',
                      style: TextStyle(
                        color: Colors.white54,
                      ))
                    ])),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      countdown.toString(),
                      style: TextStyle(
                        height: 0.79,
                        fontSize: 75.0,
                        letterSpacing: -8.0,
                        color: Colors.white70,
                      ),
                    ),
                    Text('天',
                      style: TextStyle(
                        height: 1.0,
                        fontSize: 12.0,
                        color: Colors.white54,
                      )),
                    ]))
            ]))
    );
  }
}
