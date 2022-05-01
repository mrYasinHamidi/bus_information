import 'package:bus_information/models/enums/ObjectType.dart';

abstract class DatabaseObject<T> {
  String get id;

  String get boxKey;

  DateTime get creationTime;

  String encode();

  T decode(String source);
}
abstract class MainObject{
  ObjectType get type;
  String get searchWord;
}
