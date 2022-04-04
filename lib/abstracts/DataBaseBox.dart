import 'package:bus_information/abstracts/DatabaseObject.dart';

abstract class DatabaseBox<T extends DatabaseObject> {
  String key = '';

  List<T> get objects;

  void remove();

  void put();
}
