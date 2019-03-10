import 'package:flutter_test/flutter_test.dart';

import 'base_view.dart';

class CharacterInformationView extends BaseView {
  CharacterInformationView(WidgetTester tester) : super(tester);

  String getCharacterName() {
    return getDataFromTextByKey("characterName");
  }

  String getCharacterSex() {
    return getDataFromTextByKey("characterSex");
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
}