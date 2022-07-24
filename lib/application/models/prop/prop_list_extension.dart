part of 'prop.dart';

extension PropListExtension on List<Prop> {
  reSort() {
    sort(
      (a, b) => b.getCreationTime().compareTo(a.getCreationTime()),
    );
  }
}
