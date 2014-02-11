library rsd.test;

import 'dart:async';

import 'package:unittest/unittest.dart';
import 'package:rsd/rsd.dart';

part 'matcher_adapter_test.dart';
part 'rsd_router_test.dart';

main() {
  matcherAdapterTest();
  rsdRouterTest();
}