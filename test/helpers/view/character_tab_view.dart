import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'base_view_tester.dart';

class CharacterTabView extends BaseViewTester {
  CharacterTabView(WidgetTester tester) : super(tester);

  String get name => getTextByKey('Character__Name');
  String get gender => getTextByKey('Character__Gender');
  String get origin => getTextByKey('Character__Origin');
  String get age => getTextByKey('Character__Age');
  String get ageCategory => getTextByKey('Character__AgeCategory');
  String get school => getTextByKey('Character__School');
  List<String> get graduates {
    var graduatesFinder = find.byKey(Key('Character__Graduates'));
    expect(graduatesFinder, findsOneWidget);

    var graduates = graduatesFinder.evaluate().single.widget as Column;
    return graduates.children.map((text) => (text as Text).data).toList();
  }
  String get job => getTextByKey('Character__Job');
  String get salary => getTextByKey('Character__Salary');
  JobHistoryElement jobHistory(int index) => JobHistoryElement(tester, index);
}

class JobHistoryElement extends BaseViewTester {
  final int index;

  JobHistoryElement(tester, this.index): super(tester);

  bool get isVisible => widgetExists('JobHistoryItem__$index');
  String get name => getTextByKey('JobHistoryItem__${index}__name');
  String get experience => getTextByKey('JobHistoryItem__${index}__experience');
}