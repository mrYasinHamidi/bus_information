abstract class DatabaseObject<T> {
  String get id;

  String encode();

  T decode(String source);
}
