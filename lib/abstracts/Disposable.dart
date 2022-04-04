abstract class Disposable {
  bool _isBusy = false;

  bool isDispose = true;

  Future<void> Function()? _do;

  Future<void> a() async {
    isDispose = false;
  }

  Future<void> b() async {
    isDispose = true;
  }

  Future<void> init() async {
    if (_isBusy) {
      _do = a;
      return;
    }

    _isBusy = true;
    if (isDispose) await a.call();
    if (_do == b) await _do?.call();
    _do = null;
    _isBusy = false;
  }

  Future<void> dispose() async {
    if (_isBusy) {
      _do = b;
      return;
    }
    _isBusy = true;
    if (!isDispose) await b.call();
    if (_do == a) await _do?.call();
    _do = null;
    _isBusy = false;
  }
}
