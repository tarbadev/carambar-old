import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class AgeEventView {
  final int id;
  final WidgetTester tester;

  Finder get _ageFinder => find.byKey(Key('AgeEventItem__${id}__age'));
  Finder get _eventsFinder => find.byKey(Key('AgeEventItem__${id}__events'));

  String get age => (tester.widget(_ageFinder) as Text).data;
  List<String> get events => (tester.widget(_eventsFinder) as Column)
      .children
      .map((eventText) => (eventText as Text).data)
      .toList();

  AgeEventView(this.id, this.tester);
}
