abstract class DatabaseObject<T> {
  String get id;

  String get boxKey;

  String encode();

  T decode(String source);

  DateTime get creationTime;

}
