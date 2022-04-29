import 'package:bus_information/models/enums/ObjectType.dart';

abstract class DatabaseObject<T> {
  String get id;

  String get boxKey;

  ObjectType get type;

  String encode();

  T decode(String source);

  DateTime get creationTime;

}
