import 'package:bus_information/abstracts/DatabaseObject.dart';

extension ObjectList on List<DatabaseObject> {
  void reSort(){
    sort((a, b) => b.creationTime.compareTo(a.creationTime),);
  }
}
