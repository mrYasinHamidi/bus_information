import 'package:bus_information/Constants.dart';
import 'package:bus_information/repository/database/DatabaseHelper.dart';
import 'package:flutter/foundation.dart';

enum PageType { driver, bus }

extension PageTypeExtension on PageType{
  ValueListenable get listenable{
    switch(this){
      case PageType.driver:
        return DatabaseHelper.instance.driversListenable;
      case PageType.bus:
        return DatabaseHelper.instance.driversListenable;
    }
  }
}