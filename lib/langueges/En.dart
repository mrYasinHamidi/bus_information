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
}
