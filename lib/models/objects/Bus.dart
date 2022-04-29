import 'dart:convert';

import 'package:bus_information/Constants.dart';
import 'package:bus_information/abstracts/DatabaseObject.dart';
import 'package:bus_information/models/enums/BusStatus.dart';
import 'package:bus_information/models/enums/ObjectType.dart';

class Bus implements DatabaseObject {
  String busNumber;
  BusStatus status;
  DateTime time = DateTime.now();

  Bus({
    this.busNumber = '',
    this.status = BusStatus.active,
  });

  factory Bus.fromString(String source) => Bus()..decode(source);

  @override
  String get id => busNumber;

  @override
  String get boxKey => Constants.busBoxKey;

  @override
  DateTime get creationTime => time;

  @override
  decode(String source) {
    Map data = jsonDecode(source);
    busNumber = data['busNumber'];
    status = BusStatus.values[data['status'] ?? 0];
    time = DateTime.parse(data['time']);

  }

  @override
  String encode() {
    Map data = {
      'busNumber': busNumber,
      'status': status.index,
      'time': time.toString(),
    };
    return jsonEncode(data);
  }

  @override
  ObjectType get type => ObjectType.bus;
}
