import 'package:bus_information/abstracts/Languages.dart';
import 'package:flutter/material.dart';

enum DriverStatus {
  active,
  inActive,
  vacation,
  coordination,
}
extension DriverStatusEx on DriverStatus {
  String get text {
    switch (this) {
      case DriverStatus.active:
        return Languages.language.value.active;
      case DriverStatus.inActive:
        return Languages.language.value.inActive;
      case DriverStatus.vacation:
        return Languages.language.value.vacation;
      case DriverStatus.coordination:
        return Languages.language.value.coordination;
    }
  }
}

extension DriverStatusExe on List<DriverStatus> {
  List<Text> get asTextList => map((e) => Text(e.text)).toList();
}

