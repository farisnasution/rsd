part of rsd;

class MatcherAdapter {

  bool isMatch(data, value) {
    var regExp = new RegExp(value);

    return regExp.hasMatch(data);
  }

  List allGroups(data, value) {
    var regExp = new RegExp(value),
        match = regExp.firstMatch(data),
        groups = BowGeneral.allGroups(match);

    return groups
        .map((catched) => BowGeneral.tryToNum(catched))
        .toList(growable: false);
  }
}
