
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class BaseViewTester {
  BaseViewTester(this.tester);

  final WidgetTester tester;

  String getTextByKey(String key) {
    var textFinder = find.byKey(Key(key));
    expect(textFinder, findsOneWidget);

    Text text = tester.widget(textFinder);
    return text.data;
  }
}