import 'package:flutter_test/flutter_test.dart';

import 'base_view.dart';

class CharacterTabView extends BaseView {
  CharacterTabView(WidgetTester tester) : super(tester);

  String getCharacterName() {
    return getDataFromTextByKey("characterName");
  }

  String getCharacterGender() {
    return getDataFromTextByKey("characterGender");
  }

  String getCharacterOrigin() {
    return getDataFromTextByKey("characterOrigin");
  }

  String getCharacterAge() {
    return getDataFromTextByKey("characterAge");
  }

  String getCharacterAgeCategory() {
    return getDataFromTextByKey("characterAgeCategory");
  }

  String getCharacterSchool() {
    return getDataFromTextByKey("characterSchool");
  }
}