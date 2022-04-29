import 'package:bus_information/abstracts/Languages.dart';

enum ObjectType { bus, driver, prop }

extension ObjectTypeExtension on ObjectType {
  String get text {
    switch (this) {
      case ObjectType.bus:
        return Languages.language.value.buses;
      case ObjectType.driver:
        return Languages.language.value.driver;
      case ObjectType.prop:
        return Languages.language.value.buses;
    }
  }
}
