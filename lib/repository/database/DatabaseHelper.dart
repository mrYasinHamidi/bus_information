import 'package:bus_information/Constants.dart';
import 'package:bus_information/abstracts/DatabaseObject.dart';
import 'package:bus_information/abstracts/Disposable.dart';
import 'package:bus_information/abstracts/Observable.dart';
import 'package:bus_information/abstracts/Observer.dart';
import 'package:bus_information/extensions.dart';
import 'package:bus_information/models/enums/ObjectType.dart';
import 'package:bus_information/models/events.dart';
import 'package:bus_information/models/objects/Bus.dart';
import 'package:bus_information/models/objects/Driver.dart';
import 'package:bus_information/models/objects/Prop.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/change_notifier.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DatabaseHelper {
  DatabaseHelper.privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper.privateConstructor();

  factory DatabaseHelper() {
    return instance;
  }

  Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(Constants.driverBoxKey);
    await Hive.openBox(Constants.busBoxKey);
    await Hive.openBox(Constants.propBoxKey);
  }

  List<Driver> get drivers =>
      Hive.box(Constants.driverBoxKey).values.map((e) => Driver.fromString(e)).toList()..reSort();

  List<Bus> get buses => Hive.box(Constants.busBoxKey).values.map((e) => Bus.fromString(e)).toList()..reSort();

  List<Prop> get props => Hive.box(Constants.propBoxKey).values.map((e) => Prop.fromString(e)).toList()..reSort();

  void put(DatabaseObject object) => Hive.box(object.boxKey).put(object.id, object.encode());

  void delete(DatabaseObject object) => Hive.box(object.boxKey).delete(object.id);

  ValueListenable<Box> getListenable(ObjectType type) {
    switch (type) {
      case ObjectType.bus:
        return Hive.box(Constants.busBoxKey).listenable();
      case ObjectType.driver:
        return Hive.box(Constants.driverBoxKey).listenable();
      case ObjectType.prop:
        return Hive.box(Constants.propBoxKey).listenable();
    }
  }

  List<DatabaseObject> getItems(ObjectType type) {
    switch (type) {
      case ObjectType.bus:
        return buses;
      case ObjectType.driver:
        return drivers;
      case ObjectType.prop:
        return props;
    }
  }

  bool containName(String name) => Hive.box(Constants.driverBoxKey).containsKey(name.trim());

  bool containBus(String number) => Hive.box(Constants.busBoxKey).containsKey(number.trim());

  Bus? getBus(String id) {
    String? source = Hive.box(Constants.busBoxKey).get(id);
    if (source == null) return null;
    return Bus.fromString(source);
  }

  Driver? getDriver(String id) {
    String? source = Hive.box(Constants.driverBoxKey).get(id);
    if (source == null) return null;
    return Driver.fromString(source);
  }
}
