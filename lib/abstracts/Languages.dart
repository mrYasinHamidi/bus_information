import 'package:bus_information/langueges/Fa.dart';
import 'package:flutter/cupertino.dart';

abstract class Languages {
  static ValueNotifier<Languages> language = ValueNotifier(Fa());

  TextDirection get direction;

  String get appName;

  String get name;

  String get morningShift;

  String get eveningShift;

  String get firstOverTime;

  String get secondOverTime;

  String get shiftSwitching;

  String get drivers;

  String get buses;

  String get active;

  String get inActive;

  String get vacation;

  String get coordination;

  String get submit;

  String get operationDone;

  String get repeatedName;

  String get shouldNotEmpty;

  String get driverInformation;

  String get busInformation;

  String get busNumber;

  String get driver;

  String get busStatus;

  String get driverStatus;

  String get shiftWork;

  String get alternativeDriver;

  String get repeatedNumber;
}
