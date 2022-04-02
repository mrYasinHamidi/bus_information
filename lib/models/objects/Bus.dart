import 'dart:convert';

import 'package:bus_information/abstracts/DatabaseObject.dart';
import 'package:bus_information/models/enums/BusStatus.dart';

class Bus implements DatabaseObject {
  String? busNumber;
  BusStatus? status;
  String? driverId;
  String? secondDriverId;

  Bus({
    this.busNumber,
    this.status,
  });

  factory Bus.fromString(String source) => Bus()..decode(source);

  @override
  decode(String source) {
    Map data = jsonDecode(source);
    busNumber = data['busNumber'];
    driverId = data['driverId'];
    secondDriverId = data['secondDriverId'];
    status = data['status'];
  }

  @override
  String encode() {
    Map data = {
      'busNumber': busNumber,
      'status': status,
      'driverId': driverId,
      'secondDriverId': secondDriverId,
    };
    return jsonEncode(data);
  }

  @override
  String get id => throw UnimplementedError();
}
