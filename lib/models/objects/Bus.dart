import 'dart:convert';

import 'package:bus_information/Constants.dart';
import 'package:bus_information/abstracts/DatabaseObject.dart';
import 'package:bus_information/models/enums/BusStatus.dart';

class Bus implements DatabaseObject {
  String busNumber;
  BusStatus? status;
  String? driverId;
  String? secondDriverId;

  Bus({
    this.busNumber='',
    this.status,
  });

  factory Bus.fromString(String source) => Bus()..decode(source);

  @override
  decode(String source) {
    Map data = jsonDecode(source);
    busNumber = data['busNumber'];
    driverId = data['driverId'];
    secondDriverId = data['secondDriverId'];
    status = BusStatus.values[data['status'] ?? 0];
  }

  @override
  String encode() {
    Map data = {
      'busNumber': busNumber,
      'status': status?.index,
      'driverId': driverId,
      'secondDriverId': secondDriverId,
    };
    return jsonEncode(data);
  }

  @override
  String get id => busNumber;

  @override
  String get boxKey => Constants.busBoxKey;
}
