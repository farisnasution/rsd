part of rsd.test;

void rsdRouterTest() {
  group('RsdRouter test', () {

    test('handler and default handler test', () {
      var c = new StreamController(),
          s = c.stream,
          router = new RsdRouter()..stream = s;

      router
        ..handler(r'^/$', expectAsync((data) {
          expect(data, equals('/'));
        }))
        ..handler(r'^/(\w+)/(\d+)/$', expectAsync((data) {
          expect(data, equals('/faris/100/'));
        }));

      c
        ..add('/faris/100/')
        ..add('/');

    });

    test('nested router', () {
      var c = new StreamController(),
          s = c.stream,
          router = new RsdRouter()..stream = s,
          nested = new RsdRouter(),
          anotherNested = new RsdRouter();

      router
        ..include(r'^/api/', nested)
        ..include(r'^/reddit/r/', anotherNested);

      nested
        ..handler(r'user/$', expectAsync((data) {
          expect(data, equals('/api/user/'));
        }));

      anotherNested
        ..handler(r'dartlang/$', ((data) {
          expect(data, equals('/reddit/r/dartlang/'));
        }));

      c
        ..add('/api/user/')
        ..add('/reddit/r/dartlang/');
    });

  });
}