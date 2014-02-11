part of rsd.test;

void matcherAdapterTest() {
  group('MatcherAdapter test', () {

    test('is match', () {
      var mark1 = r'^/(\w+)/(\d+)/$',
          mark2 = r'^/$',
          data1 = '/faris/100/',
          data2 = '/',
          matcher = new MatcherAdapter();

      expect(matcher.isMatch(data1, mark1), isTrue);
      expect(matcher.isMatch(data2, mark2), isTrue);

      expect(matcher.isMatch(data1, mark2), isFalse);
      expect(matcher.isMatch(data2, mark1), isFalse);
    });

  });
}