import 'dart:convert';

import 'package:bus_information/Constants.dart';
import 'package:bus_information/abstracts/DatabaseObject.dart';
import 'package:bus_information/models/enums/DriverStatus.dart';
import 'package:bus_information/models/enums/ObjectType.dart';
import 'package:bus_information/models/enums/ShiftWork.dart';

class Prop implements DatabaseObject {
  String? driverId;
  String? busId;
  String? secondDriverId;
  DateTime time = DateTime.now();

  Prop();

  factory Prop.fromString(String source) => Prop()..decode(source);

  @override
  String get id => time.toString();

  @override
  String get boxKey => Constants.propBoxKey;

  @override
  DateTime get creationTime => time;

  @override
  decode(String source) {
    Map data = jsonDecode(source);
    driverId = data['driverId'];
    secondDriverId = data['secondDriverId'];
    busId = data['busId'];
    time = DateTime.parse(data['time']);
  }

  @override
  String encode() {
    Map data = {
      'driverId': driverId,
      'secondDriverId': secondDriverId,
      'busId': busId,
      'time': time.toString(),
    };
    return jsonEncode(data);
  }

  @override
  ObjectType get type => ObjectType.prop;
}
