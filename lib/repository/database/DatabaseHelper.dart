import 'package:bus_information/Constants.dart';
import 'package:bus_information/abstracts/DatabaseObject.dart';
import 'package:bus_information/abstracts/Disposable.dart';
import 'package:bus_information/abstracts/Observable.dart';
import 'package:bus_information/abstracts/Observer.dart';
import 'package:bus_information/models/events.dart';
import 'package:bus_information/models/objects/Bus.dart';
import 'package:bus_information/models/objects/Driver.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/change_notifier.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DatabaseHelper extends Disposable implements Observable {
  DatabaseHelper.privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper.privateConstructor();

  factory DatabaseHelper() {
    return instance;
  }

  List<Driver> get drivers => Hive.box(Constants.driverBoxKey).values.map((e) => Driver.fromString(e)).toList();

  List<Bus> get buses => Hive.box(Constants.busBoxKey).values.map((e) => Bus.fromString(e)).toList();

  ValueListenable<Box> get busesListenable => Hive.box(Constants.busBoxKey).listenable();

  ValueListenable<Box> get driversListenable => Hive.box(Constants.driverBoxKey).listenable();

  void put(DatabaseObject object) async {
    await Hive.box(object.boxKey).put(object.id, object.encode());
    if (object is Driver) notifyObservers(data: DriversChange());
    if (object is Bus) notifyObservers(data: BusesChange());
  }

  void delete(DatabaseObject object) async {
    await Hive.box(object.boxKey).delete(object.id);
    notifyObservers();
    if (object is Driver) notifyObservers(data: DriversChange());
    if (object is Bus) notifyObservers(data: BusesChange());
  }

  @override
  Future<void> a() async {
    await super.a();
    if (!Hive.isBoxOpen(Constants.driverBoxKey)) {
      await Hive.openBox(Constants.driverBoxKey);
    }
    if (!Hive.isBoxOpen(Constants.busBoxKey)) {
      await Hive.openBox(Constants.busBoxKey);
    }
    notifyObservers(data: Initialized());
  }

  @override
  Future<void> b() async {
    await super.b();
    if (Hive.isBoxOpen(Constants.driverBoxKey)) {
      await Hive.box(Constants.driverBoxKey).close();
    }
    if (Hive.isBoxOpen(Constants.busBoxKey)) {
      await Hive.box(Constants.busBoxKey).close();
    }
  }

  @override
  addObserver(Observer observer) {
    observers[observer.key] = observer;
  }

  @override
  notifyObservers({String? key = '', Data? data}) {
    if (observers[key] != null) {
      observers[key]?.onNewEvent(data);
      return;
    }
    for (var i in observers.values) {
      i.onNewEvent(data);
    }
  }

  @override
  removeObserver(Observer observer) {
    observers.remove(observer.key);
  }

  @override
  Map<String, Observer> observers = {};

  bool containedName(String name) => Hive.box(Constants.driverBoxKey).containsKey(name.trim());
}
