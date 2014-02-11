part of rsd;

class RsdRouter {
  BaseRouter _router;
  final MatcherAdapter adapter = new MatcherAdapter();

  void set stream(Stream value) {
    _router = new BaseRouter(value);
  }

  void handler(String settings, view) {
    _router.handler((data) => adapter.isMatch(data, settings)).listen(view);
  }

  void include(String settings, RsdRouter router) {
    var controller = new StreamController(),
        stream = controller.stream;

    router.stream = stream;

    _router.handler((data) => adapter.isMatch(data, settings)).listen((data) {
      controller.add(data);
    });
  }

  void defaultHandler(view) {
    _router.defaultHandler.listen(view);
  }

  Future close() => _router.close();
}
