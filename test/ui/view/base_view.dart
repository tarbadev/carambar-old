
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class BaseView {
  BaseView(this.tester);

  final WidgetTester tester;

  String getDataFromTextByKey(String key) {
    var textFinder = find.byKey(Key(key));
    expect(textFinder, findsOneWidget);

    Text text = tester.widget(textFinder);
    return text.data;
  }
}