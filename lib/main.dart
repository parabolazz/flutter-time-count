import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        canvasColor: Colors.transparent,
      ),
      home: MyHomePage(title: '计日'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static final timeInfos = [
    {
      'name': '告白纪念日',
      'time': '2019-09-30',
      'countdown': _computeCountdown('2019-09-30')
    },
    {
      'name': '苹果 2019 发布会',
      'time': '2019-09-21',
      'countdown': _computeCountdown('2019-09-21')
    },
    {
      'name': '外婆的生日',
      'time': '2019-12-21',
      'countdown': _computeCountdown('2019-12-21')
    },
    {
      'name': '杨千嬅惠州演唱会',
      'time': '2019-08-25',
      'countdown': _computeCountdown('2019-08-25')
    },
    {
      'name': '国庆旅游',
      'time': '2019-10-01',
      'countdown': _computeCountdown('2019-10-01')
    },
    {
      'name': '国庆旅游',
      'time': '2019-10-01',
      'countdown': _computeCountdown('2019-10-01')
    },
    {
      'name': '国庆旅游',
      'time': '2019-10-01',
      'countdown': _computeCountdown('2019-10-01')
    }
  ];

  static int _computeCountdown(setTime) {
    final currentTime = new DateTime.now();
    final bookTime = DateTime.parse(setTime);
    final durat = bookTime.difference(currentTime);
    return durat.inDays;
  }

  void _test() {}

  List renderAllTimeCards(timeInfos) {
    return timeInfos.map<Widget>((item) => TimeCard(timeInfo: item)).toList();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _test method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(left: 20.0, top: 20.0),
        alignment: Alignment.topLeft,
        child: ListView(
            // Column is also layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Invoke "debug painting" (press "p" in the console, choose the
            // "Toggle Debug Paint" action from the Flutter Inspector in Android
            // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
            // to see the wireframe for each widget.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.start,
            // scrollDirection: Axis.vertical,
            // itemExtent: 130.0,
            children: renderAllTimeCards(timeInfos),
          ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet<Null>(context:context, builder:(BuildContext context) {
              return Container(
                height: 500,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      RaisedButton(
                              child: Text('升压'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              }),
                           RaisedButton(
                              child: Text('降压'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              }),    
                    ],
                  )
                )
              );
            });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class TimeCard extends StatelessWidget {
  final Map timeInfo;
  TimeCard({this.timeInfo});

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      padding: EdgeInsets.only(right: 80.0),
      child: Container(
        margin: EdgeInsets.only(bottom: 20.0),
        padding: EdgeInsets.all(12.0),
        width: 300.0,
        height: 130.0,
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
                        fontSize: 20.0,
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
                      '${timeInfo['countdown']}',
                      style: TextStyle(
                        height: 0.79,
                        fontSize: 88.0,
                        letterSpacing: -8.0,
                        color: Colors.white70,
                      ),
                    ),
                    Text('天',
                      style: TextStyle(
                        height: 1.0,
                        fontSize: 12.0,
                        color: Colors.white54,
                      ))
                    ]))
            ]))
    );
  }
}
