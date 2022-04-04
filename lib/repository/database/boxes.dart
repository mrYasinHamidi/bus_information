import 'package:bus_information/Constants.dart';
import 'package:bus_information/abstracts/DataBaseBox.dart';
import 'package:bus_information/abstracts/DatabaseObject.dart';

class DriverBox implements DatabaseBox {
  @override
  String key = Constants.driverBoxKey;

  @override
  // TODO: implement objects
  List<DatabaseObject> get objects => throw UnimplementedError();

  @override
  void put() {
    // TODO: implement put
  }

  @override
  void remove() {
    // TODO: implement remove
  }
}
