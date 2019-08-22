import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';

class EventList {
  List<Event> events;

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
        item['id'],
        item['color']
      )).toList();
  
  Future deleteEvent(id) {
    this.events = this.events.where((event) => event.id != id).toList();
    final String jsonString = this.toJson();
    return EventStorage().writeStorage(jsonString);
  }

  Future saveDataToLocal() {
    final String jsonString = this.toJson();
    return EventStorage().writeStorage(jsonString)
      .then((data) {
        print('操作成功！');
      }).catchError((e) {
        print('操作失败');
      });
  }

  List addEvent(event) {
    this.events.add(event);
     this.saveDataToLocal();
    return events;
  }

  Future updateEvent(event) {
    final index = this.events.indexWhere((e) => e.id == event.id);
    final Event newOne = new Event(event.name, event.utcTime, event.id, event.color);
    this.events.replaceRange(index, index+1, [newOne]);
    return this.saveDataToLocal();
  }
}

var myEvents = new EventList([]);

class Event {
  String name;
  DateTime utcTime;
  // 使用 timestamp 作为 id
  int id;
  int color;

  Event(this.name, this.utcTime, this.id, this.color);
  
  Event.fromJson(Map<String, dynamic> map)
    : name = map['name'],
      utcTime = DateTime.parse(map['time']),
      id = map['id'],
      color = map['color'];

  Map<String, dynamic> toJson() => {
    'name': name,
    'time': utcTime.toIso8601String(),
    'id': id,
    'color': color
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