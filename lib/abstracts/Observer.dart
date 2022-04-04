import 'package:bus_information/models/events.dart';

abstract class Observer {
  String get key;

  onNewEvent(Data? data);
}
