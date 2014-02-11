part of rsd;

class MatcherAdapter {

  bool isMatch(data, value) {
    var regExp = new RegExp(value);

    return regExp.hasMatch(data);
  }
}
