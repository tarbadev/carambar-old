import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'base_view_tester.dart';

class AgeEventView extends BaseViewTester {
  final int id;

  String get age => getTextByKey('JobDialog__JobTitle');
  List<String> get events => (tester.widget(find.byKey(Key('AgeEventItem__${id}__events'))) as Column)
      .children
      .map((eventPadding) => ((eventPadding as Padding).child as Text).data)
      .toList();

  AgeEventView(this.id, tester) : super(tester);
}
