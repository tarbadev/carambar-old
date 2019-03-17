import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'base_view.dart';

class CharacterTabView extends BaseView {
  CharacterTabView(WidgetTester tester) : super(tester);

  String get name => getDataFromTextByKey("characterName");
  String get gender => getDataFromTextByKey("characterGender");
  String get origin => getDataFromTextByKey("characterOrigin");
  String get age => getDataFromTextByKey("characterAge");
  String get ageCategory => getDataFromTextByKey("characterAgeCategory");
  String get school => getDataFromTextByKey("characterSchool");
  List<String> get graduates {
    var graduatesFinder = find.byKey(Key('characterGraduates'));
    expect(graduatesFinder, findsOneWidget);

    var graduates = graduatesFinder.evaluate().single.widget as Column;
    return graduates.children.map((text) => (text as Text).data).toList();
  }
}