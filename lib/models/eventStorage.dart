import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';

class EventList {
  List events;

  EventList(this.events);

  String toJson() {
    final data = events.map((event) => event.toJson()).toList();
    return json.encode(data);
  }
  EventList.fromJson(List jsonList) 
    : events = jsonList.map((item) => 
      Event(
        item['name'],
        DateTime.parse(item['time']),
        item['id']
      )).toList();
  
  void deleteEvent(id) {
    this.events = this.events.where((event) => event.id != id);
  }

  List addEvent(event) {
    this.events.add(event);
    final String jsonString = this.toJson();
    EventStorage().writeStorage(jsonString)
      .then((data) {
        print('添加成功！');
      }).catchError((e) {
        print('添加失败');
      });
    return events;
  }
}

class Event {
  String name;
  DateTime utcTime;
  // 使用 timestamp 作为 id
  int id;

  Event(this.name, this.utcTime, this.id);
  
  Event.fromJson(Map<String, dynamic> map)
    : name = map['name'],
      utcTime = DateTime.parse(map['time']),
      id = map['id'];

  Map<String, dynamic> toJson() => {
    'name': name,
    'time': utcTime.toIso8601String(),
    'id': id
  };
}

class EventStorage {

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/events.json');
  }

  Future<List> readStorage() async {
    try {
      final file = await _localFile;
      final String dataStrings = await file.readAsString();
      return json.decode(dataStrings);
    } catch (e) {
      return [];
    }
  }

  Future<File> writeStorage(String string) async {
    final file = await _localFile;
    return file.writeAsString(string);
  }

  String toJSONString(value) {
    return json.encode(value);
  }
}