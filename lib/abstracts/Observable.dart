import 'package:bus_information/abstracts/Observer.dart';
import 'package:bus_information/models/events.dart';

abstract class Observable {
  Map<String, Observer> observers = {};

  addObserver(Observer observer);

  removeObserver(Observer observer);

  notifyObservers({String? key,Data? data});
}
