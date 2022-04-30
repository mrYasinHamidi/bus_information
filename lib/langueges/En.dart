import 'dart:ui';

import 'package:bus_information/abstracts/Languages.dart';

class En extends Languages {
  @override
  TextDirection get direction => TextDirection.ltr;

  @override
  String get name => 'Name';

  @override
  String get appName => 'Bus Information';

  @override
  String get drivers => 'Drivers';

  @override
  String get buses => 'Buses';

  @override
  String get eveningShift => 'Evening Shift';

  @override
  String get firstOverTime => 'first Over Time';

  @override
  String get morningShift => 'Morning Shift';

  @override
  String get secondOverTime => 'Second Over Time';

  @override
  String get shiftSwitching => 'Shift Switching';

  @override
  String get active => 'Active';

  @override
  String get coordination => 'Coordination';

  @override
  String get inActive => 'Inactive';

  @override
  String get vacation => 'Vacation';

  @override
  String get submit => 'Submit';

  @override
  String get operationDone => 'Operation successfully done';

  @override
  String get repeatedName => 'Repeated Name';

  @override
  String get shouldNotEmpty => 'Should Not Empty';

  @override
  String get driverInformation => 'Driver Information';

  @override
  String get busInformation => 'Bus Information';

  @override
  String get busNumber => 'Bus Number';

  @override
  String get driver => 'Driver';

  @override
  String get busStatus => 'Bus Status';

  @override
  String get driverStatus => 'Driver Status';

  @override
  String get shiftWork => 'Shift Work';

  @override
  String get alternativeDriver => 'Second Driver';

  @override
  String get repeatedNumber => 'Repeated Number';

  @override
  String get alternative => 'Alternative';

  @override
  String get addProp => 'Add Property';

  @override
  String get props => 'Properties';
}
