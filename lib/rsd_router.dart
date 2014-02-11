part of rsd;

typedef MatchedCallback(data, args);

class RsdRouter {
  BaseRouter _router;
  final MatcherAdapter adapter = new MatcherAdapter();
  String _prefix;

  void set stream(Stream value) {
    _router = new BaseRouter(value);
  }

  void handler(String settings, MatchedCallback callback) {
    settings = _prefix == null ? settings : '$_prefix$settings';
    _router.handler((data) => adapter.isMatch(data, settings)).listen((data) {
      var args = adapter.allGroups(data, settings);

      callback(data, args);
    });
  }

  void include(String settings, RsdRouter router) {
    var controller = new StreamController(),
        stream = controller.stream;

    router
      ..stream = stream
      .._prefix = settings;

    _router.handler((data) => adapter.isMatch(data, settings)).listen((data) {
      controller.add(data);
    });
  }

  void defaultHandler(view) {
    _router.defaultHandler.listen(view);
  }

  Future close() => _router.close();
}
