import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'base_view_tester.dart';

class CharacterTabView extends BaseViewTester {
  CharacterTabView(WidgetTester tester) : super(tester);

  String get name => getTextByKey("characterName");
  String get gender => getTextByKey("characterGender");
  String get origin => getTextByKey("characterOrigin");
  String get age => getTextByKey("characterAge");
  String get ageCategory => getTextByKey("characterAgeCategory");
  String get school => getTextByKey("characterSchool");
  List<String> get graduates {
    var graduatesFinder = find.byKey(Key('characterGraduates'));
    expect(graduatesFinder, findsOneWidget);

    var graduates = graduatesFinder.evaluate().single.widget as Column;
    return graduates.children.map((text) => (text as Text).data).toList();
  }
}