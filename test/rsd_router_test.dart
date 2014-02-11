part of rsd.test;

void rsdRouterTest() {
  group('RsdRouter test', () {

    test('handler and default handler test', () {
      var c = new StreamController(),
          s = c.stream,
          router = new RsdRouter()..stream = s;

      router
        ..handler(r'^/$', expectAsync((data, args) {
          expect(data, equals('/'));
          expect(args, isList);
          expect(args, isEmpty);
        }))
        ..handler(r'^/(\w+)/(\d+)/$', expectAsync((data, args) {
          expect(data, equals('/faris/100/'));
          expect(args, isList);
          expect(args, isNot(isEmpty));
          expect(args.length, equals(2));
          expect(args.first, equals('faris'));
          expect(args.last, equals(100));
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
        ..include(r'^/reddit/(\w+)/', anotherNested);

      nested
        ..handler(r'user/$', expectAsync((data, args) {
          expect(data, equals('/api/user/'));
          expect(args, isList);
          expect(args, isEmpty);
        }));

      anotherNested
        ..handler(r'(\w+)/$', ((data, args) {
          expect(data, equals('/reddit/r/dartlang/'));
          expect(args, isList);
          expect(args, isNot(isEmpty));
          expect(args.length, equals(2));
          expect(args.first, equals('r'));
          expect(args.last, equals('dartlang'));
        }));

      c
        ..add('/api/user/')
        ..add('/reddit/r/dartlang/');
    });

  });
}