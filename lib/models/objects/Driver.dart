import 'dart:convert';

import 'package:bus_information/Constants.dart';
import 'package:bus_information/abstracts/DatabaseObject.dart';
import 'package:bus_information/models/enums/DriverStatus.dart';
import 'package:bus_information/models/enums/ObjectType.dart';
import 'package:bus_information/models/enums/ShiftWork.dart';

class Driver implements DatabaseObject,MainObject {
  String name;
  ShiftWork shiftWork;
  DriverStatus status;
  DateTime time = DateTime.now();

  Driver({
    this.name = '',
    this.status = DriverStatus.active,
    this.shiftWork = ShiftWork.morning,
  });

  factory Driver.fromString(String source) => Driver()..decode(source);

  @override
  String get id => name;

  @override
  String get boxKey => Constants.driverBoxKey;

  @override
  DateTime get creationTime => time;

  @override
  decode(String source) {
    Map data = jsonDecode(source);
    name = data['name'];
    status = DriverStatus.values[data['status'] ?? 0];
    shiftWork = ShiftWork.values[data['shiftWork'] ?? 0];
    time = DateTime.parse(data['time']);
  }

  @override
  String encode() {
    Map data = {
      'name': name,
      'status': status.index,
      'shiftWork': shiftWork.index,
      'time': time.toString(),
    };
    return jsonEncode(data);
  }

  @override
  ObjectType get type => ObjectType.driver;

  @override
  String get searchWord => name;
}
